#' Information on locations
#'
#' @import httr
#' @export
#' @template all
#' @importFrom plyr compact rbind.fill
#' @inheritParams gs_traffic
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' res <- gs_gauge_list()
#' id = res$brief[ res$brief$title == 'Recology-Jekyll', "id"]
#' gs_locations(id=id)
#' }

gs_locations <- function(id, date=NULL, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/locations', id)
  args <- compact(list(date=date))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), ...))
  stop_for_status(tt)
  out <- content(tt)

  foo <- function(z){
    if(length(z) == 0){ data.frame(title=NA,views=NA,key=NA) } else {
      do.call(rbind.fill, lapply(z, function(y) data.frame(y,stringsAsFactors=FALSE) ))
    }
  }
  temp <- lapply(out$locations, function(x)
    data.frame(title=x$title,
               key=x$key,
               views=x$views,
               foo(x$regions),
               stringsAsFactors=FALSE)
  )
  tempdf <- do.call(rbind.fill, temp)
  names(tempdf)[4:6] <- c('region_title','region_views','views_state')
  tempdf <- tempdf[,c('title','key','views','region_title','views_state','region_views')]
  meta <- out[!names(out) %in% "locations"]
  return( list(metadata = meta, data=tempdf) )
}

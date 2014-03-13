#' Information on locations
#' 
#' @import httr
#' @template all
#' @importFrom plyr compact rbind.fill
#' @inheritParams gs_traffic
#' @param callopts Curl debugging options passed in to httr::GET
#' @examples \dontrun{
#' out <- gs_gauge_list()
#' gs_locations(id=out$brief[6,1])
#' }
#' @export
gs_locations <- function(id, date=NULL, keyname='GaugesKey', callopts=list())
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/locations', id)
  args <- compact(list(date=date))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)

  foo <- function(z){  
    if(identical(z,list())){ data.frame(title=NA,views=NA,key=NA) } else {
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
  names(tempdf)[4:6] <- c('region_title','region_views','region_key')
  tempdf <- tempdf[,c('title','key','views','region_title','region_key','region_views')]
  meta <- out[!names(out) %in% "locations"]
  return( list(metadata = meta, data=tempdf) )
}
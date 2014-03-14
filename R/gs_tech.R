#' Gets browsers and platforms for a gauge.
#' 
#' @template all
#' @import httr
#' @importFrom plyr compact rbind.fill
#' @export
#' @inheritParams gs_traffic
#' @param callopts Curl debugging options passed in to httr::GET
#' @return list of two, browsers and platforms
#' @examples \dontrun{
#' gs_tech(id='4efd83a6f5a1f5158a000004')
#' 
#' # Get list of gauge's, then pass in one of the ids
#' # output will depend on the id, so this may give no data
#' out <- gs_gauge_list()
#' gs_tech(id=out$brief[1,'id'])
#' }

gs_tech <- function(id, date=NULL, key=NULL, keyname='GaugesKey', callopts=list())
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/technology', id)
  args <- compact(list(date=date))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)
  brows <- 
    do.call(rbind.fill,
    lapply(out$browsers, function(x) if(length(x$versions)==0){
      data.frame(browser=x$title, version="NA", views=x$views)
    } else
    {
      thing <- data.frame(x$title, do.call(rbind.fill, lapply(x$versions, function(y) data.frame(y,stringsAsFactors=FALSE)))) 
      names(thing) <- c("browser","version","views")
      thing
    }))
  plats <- do.call(rbind.fill, lapply(out$platforms, function(x) data.frame(x,stringsAsFactors=FALSE)))
  return( list(browsers = brows, platforms = plats) )
}

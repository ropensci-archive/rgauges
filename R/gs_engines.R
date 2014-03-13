#' Lists the browser engines and visits to them for a single date.
#' 
#' @import httr
#' @export
#' @template all
#' @importFrom plyr rbind.fill compact
#' @inheritParams gs_traffic
#' @param callopts Curl debugging options passed in to httr::GET
#' @examples \dontrun{
#' gs_engines(id='4efd83a6f5a1f5158a000004')
#' 
#' # or get a gauge id using X
#' out <- gs_gauge_list()
#' gs_engines(id=out$brief[15,1])
#' gs_engines(id=out$brief[15,1], date="2013-11-01")
#' 
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_engines(id=out$brief[6,1])
#' }

gs_engines <- function(id, date=NULL, keyname='GaugesKey', callopts=list())
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/engines', id)
  args <- compact(list(date=date))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)
  temp <- do.call(rbind.fill, lapply(out$engines, function(x) data.frame(x,stringsAsFactors=FALSE)))
  temp <- temp[,c("key","title","views")]
  return( temp )
}

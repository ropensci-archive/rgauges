#' Lists the browser engines and visits to them for a single date.
#' 
#' @import httr
#' @importFrom plyr rbind.fill compact
#' @inheritParams gs_traffic
#' @examples \dontrun{
#' # scotts data
#' gs_engines(id='4efd83a6f5a1f5158a000004')
#' 
#' # or get a gauge id using X
#' out <- gs_gauge_list()
#' gs_engines(id=out$brief[15,1])
#' gs_engines(id=out$brief[15,1], date="2013-11-01")
#' 
#' # ropensci data
#' out <- gs_gauge_list(keyname='ropensciGaugesKey')
#' gs_engines(id=out$brief[6,1], keyname='ropensciGaugesKey')
#' }
#' @export

gs_engines <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/engines', id)
  args <- compact(list(date=date))
  tt <- GET(url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  temp <- do.call(rbind.fill, lapply(out$engines, function(x) data.frame(x,stringsAsFactors=FALSE)))
  temp <- temp[,c("key","title","views")]
  return( temp )
}

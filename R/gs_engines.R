#' Lists the browser engines and visits to them for a single date.
#'
#' @export
#' @template all
#' @inheritParams gs_traffic
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' gs_engines(id='4efd83a6f5a1f5158a000004')
#'
#' # or get a gauge id using X
#' out <- gs_gauge_list()
#' gs_engines(id=out$brief[1,'id'])
#' gs_engines(id=out$brief[1,'id'], date="2013-11-01")
#'
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_engines(id=out$brief[1,'id'])
#' }

gs_engines <- function(id, date=NULL, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('%s/gauges/%s/engines', gsbase(), id)
  args <- compact(list(date=date))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), ...))
  stop_for_status(tt)
  out <- content(tt)
  temp <- do.call(rbind.fill, lapply(out$engines, function(x) data.frame(x,stringsAsFactors=FALSE)))
  temp <- temp[,c("key","title","views")]
  return( temp )
}

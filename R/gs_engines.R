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
#' gs_engines(id=out$brief[13,'id'])
#' gs_engines(id=out$brief[13,'id'], date="2014-11-01")
#' }

gs_engines <- function(id, date=NULL, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('%s/gauges/%s/engines', gsbase(), id)
  args <- compact(list(date=date))
  out <- gs_GET(url, key, args, ...)
  temp <- do.call(rbind.fill, lapply(out$engines, function(x) data.frame(x,stringsAsFactors=FALSE)))
  temp <- temp[,c("key","title","views")]
  return( temp )
}

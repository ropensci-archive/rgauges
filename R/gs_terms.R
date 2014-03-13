#' Gets search terms for a gauge, paginated.
#' 
#' @template all
#' @import httr
#' @importFrom plyr compact rbind.fill
#' @export
#' @inheritParams gs_ref
#' @param callopts Curl debugging options passed in to httr::GET
#' @examples \dontrun{
#' gs_terms(id='4efd83a6f5a1f5158a000004')
#' 
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_terms(id=out$brief[12,1])
#' }

gs_terms <- function(id, date=NULL, page=NULL, keyname='GaugesKey', callopts=list())
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- paste0('https://secure.gaug.es/gauges/', id, '/terms')
  args <- compact(list(date=date, page=page))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)
  dat <- do.call(rbind.fill, lapply(out$terms, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "terms"]
  return( list(metadata=meta, data=dat) )
}
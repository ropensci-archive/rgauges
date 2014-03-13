#' Gets search terms for a gauge, paginated.
#' 
#' @template all
#' @import httr
#' @importFrom plyr compact rbind.fill
#' @inheritParams gs_ref
#' @examples \dontrun{
#' gs_terms(id='4efd83a6f5a1f5158a000004')
#' 
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_terms(id=out$brief[6,1])
#' }
#' @export
gs_terms <- function(id, date=NULL, page=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- paste0('https://secure.gaug.es/gauges/', id, '/terms')
  args <- compact(list(date=date, page=page))
  tt <- GET(url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  dat <- do.call(rbind.fill, lapply(out$terms, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "terms"]
  return( list(metadata=meta, data=dat) )
}
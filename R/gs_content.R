#' Gets top content for a gauge, paginated.
#' 
#' @import httr
#' @template all
#' @importFrom plyr compact rbind.fill
#' @inheritParams gs_ref
#' @examples \dontrun{
#' # Default key name is GaugesKey
#' gs_content(id='4efd83a6f5a1f5158a000004')
#' gs_content(id='4efd83a6f5a1f5158a000004', date="2013-11-01")
#' 
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_content(id=out$brief[6,1])
#' }
#' @export
gs_content <- function(id, date=NULL, page=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/content', id)
  args <- compact(list(date=date, page=page))
  tt <- GET(url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  dat <- do.call(rbind.fill, lapply(out$content, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "content"]
  return( list(metadata = meta, data=dat) )
}

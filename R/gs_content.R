#' Gets top content for a gauge, paginated.
#' 
#' @import httr
#' @export
#' @template all
#' @importFrom plyr compact rbind.fill
#' @inheritParams gs_ref
#' @param callopts Curl debugging options passed in to httr::GET
#' @examples \dontrun{
#' # Default key name is GaugesKey
#' gs_content(id='4efd83a6f5a1f5158a000004')
#' gs_content(id='4efd83a6f5a1f5158a000004', date="2013-11-01")
#' 
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_content(id=out$brief[12,1])
#' }

gs_content <- function(id, date=NULL, page=NULL, keyname='GaugesKey', callopts=list())
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/content', id)
  args <- compact(list(date=date, page=page))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)
  dat <- do.call(rbind.fill, lapply(out$content, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "content"]
  return( list(metadata = meta, data=dat) )
}

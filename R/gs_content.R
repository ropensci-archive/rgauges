#' Gets top content for a gauge, paginated.
#'
#' @export
#' @template all
#' @importFrom plyr compact rbind.fill
#' @inheritParams gs_ref
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' # Default key name is GaugesKey
#' gs_content(id='4efd83a6f5a1f5158a000004')
#' gs_content(id='4efd83a6f5a1f5158a000004', date="2013-11-01")
#'
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_content(id=out$brief[13,'id'])
#' }

gs_content <- function(id, date=NULL, page=NULL, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('%s/gauges/%s/content', gsbase(), id)
  args <- compact(list(date=date, page=page))
  out <- gs_GET(url, key, args, ...)
  dat <- do.call(rbind.fill, lapply(out$content, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "content"]
  return( list(metadata = meta, data=dat) )
}

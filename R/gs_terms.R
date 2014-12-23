#' Gets search terms for a gauge, paginated.
#'
#' @export
#' @template all
#' @inheritParams gs_ref
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' gs_terms(id='4efd83a6f5a1f5158a000004')
#'
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_terms(id=out$brief[1,'id'])
#' }

gs_terms <- function(id, date=NULL, page=NULL, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- paste0(gsbase(), '/gauges/', id, '/terms')
  args <- compact(list(date=date, page=page))
  out <- gs_GET(url, key, keyname, args, ...)
  dat <- do.call(rbind.fill, lapply(out$terms, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "terms"]
  return( list(metadata=meta, data=dat) )
}

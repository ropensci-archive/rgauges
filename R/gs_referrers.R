#' Gets referrers for a gauge, paginated.
#'
#' @export
#'
#' @template all
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param page page to return
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' gs_ref(id='4efd83a6f5a1f5158a000004')
#'
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_ref(id=out$brief[12,1])
#'
#' library("httr")
#' gs_ref(id='4efd83a6f5a1f5158a000004', config=verbose())
#' }

gs_ref <- function(id, date=NULL, page=NULL, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('%s/gauges/%s/referrers', gsbase(), id)
  args <- compact(list(date=date, page=page))
  tt <- GET(url, query=args, add_headers('X-Gauges-Token' = key), ...)
  stop_for_status(tt)
  out <- content(tt)
  dat <- do.call(rbind.fill, lapply(out$referrers, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "referrers"]
  return( list(metadata = meta, data=dat) )
}

#' Lists the people that have access to a Gauge.
#'
#' @export
#' @template all
#' @param id Your gaug.es id
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' gs_shares(id='4efd83a6f5a1f5158a000004')
#'
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_shares(id=out$brief[1,'id'])
#' }

gs_shares <- function(id, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('%s/gauges/%s/shares', gsbase(), id)
  gs_GET(url, key, keyname, args, ...)
}

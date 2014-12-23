#' Returns an array of your API clients.
#'
#' @import httr
#' @template all
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' # Default key name is GaugesKey
#' gs_clients()
#' }
#' @export
gs_clients <- function(key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- 'https://secure.gaug.es/clients'
  tt <- GET(url=url, config=c(add_headers('X-Gauges-Token' = key), ...))
  stop_for_status(tt)
  out <- content(tt)
  return( out )
}

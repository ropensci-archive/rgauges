#' Returns an array of your API clients.
#' 
#' @import httr
#' @template all
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # Default key name is GaugesKey
#' gs_clients()
#' }
#' @export
gs_clients <- function(keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- 'https://secure.gaug.es/clients'
  tt <- GET(url, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  return( out )
}
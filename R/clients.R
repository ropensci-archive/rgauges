#' Returns an array of your API clients.
#' 
#' @import httr
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_clients()
#' 
#' # ropensci data
#' gs_clients(keyname='ropensciGaugesKey')
#' }
#' @export
gs_clients <- function(keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- 'https://secure.gaug.es/clients'
  out <- content( GET(url=url, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  return( out )
}
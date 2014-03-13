#' Lists the people that have access to a Gauge.
#' 
#' @template all
#' @import httr
#' @param id Your gaug.es id
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' gs_shares(id='4efd83a6f5a1f5158a000004')
#' 
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_shares(id=out$brief[6,1])
#' }
#' @export
gs_shares <- function(id, keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/shares', id)
  tt <- GET(url, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  return( out )
}
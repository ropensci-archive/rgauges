#' Lists the people that have access to a Gauge.
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_shares(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_shares(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_shares <- function(id, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/shares')
  out <- content( GET(url=url, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  return( out )
}
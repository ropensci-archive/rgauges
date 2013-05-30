#' Information on referrers
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param page page to return
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_ref(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_ref(id=ro_id, keyname='ropensciGaugesKey') # ropensci referrers
#' }
#' @export
gs_ref <- function(id, date=NULL, page=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/referrers')
  args <- compact(list(date=date, page=page))
  content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
}
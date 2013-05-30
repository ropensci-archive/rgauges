#' Traffic on a gauges ID
#' 
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_traffic(id='4efd83a6f5a1f5158a000004')
#' gs_traffic(id='4efd83a6f5a1f5158a000004', date='2013-05-26')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_traffic(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_traffic <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/traffic')
  #   args <- compact(list(date=date))
  out <- content( GET(url=url, query=args, config=list(date=date, httpheader=paste0('X-Gauges-Token:',key))) )
  temp <- ldply(out$traffic, function(x) as.data.frame(x))
  return( temp )
}

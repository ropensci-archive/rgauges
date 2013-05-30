#' Information on locations
#' 
#' @import httr
#' @inheritParams gs_traffic
#' @examples \dontrun{
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_locations(id=ro_id, keyname='ropensciGaugesKey') # ropensci locations
#' }
#' @export
gs_locations <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/locations')
  args <- compact(list(date=date))
  out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  temp <- ldply(out$locations[[1]]$regions, function(x) as.data.frame(x))
  return( temp )
}

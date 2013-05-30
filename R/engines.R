#' Lists the people that have access to a Gauge.
#' 
#' @import httr
#' @inheritParams gs_traffic
#' @examples \dontrun{
#' # scotts data
#' gs_engines(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_engines(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_engines <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/engines')
  args <- compact(list(date=date))
  out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  temp <- ldply(out$engines, function(x) as.data.frame(x))
  return( temp )
}

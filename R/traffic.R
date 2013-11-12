#' Traffic on a gauges ID
#' 
#' @import httr
#' @importFrom plyr rbind.fill
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD. This works in a weird way. If you give no 
#'    date, you get the traffic for each day since the beginning of the current month,
#'    but if you give a date, you get the traffic for each day for that entire month.
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_traffic(id='4efd83a6f5a1f5158a000004')
#' gs_traffic(id='4efd83a6f5a1f5158a000004', date='2013-05-26')
#' gs_traffic(id='4efd83a6f5a1f5158a000004', date='2013-01-10')
#' 
#' # ropensci data
#' ro_id <- gs_gauge_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_traffic(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_traffic <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/traffic', id)
  args <- compact(list(date=date))
  tt <- GET(url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  dat <- do.call(rbind.fill, lapply(out$traffic, function(x) data.frame(x, stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "traffic"]
  list(metadata=meta, data=dat)
}

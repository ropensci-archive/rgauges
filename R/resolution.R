#' Information on screen/browser resolutions
#' 
#' @import httr
#' @inheritParams gs_traffic
#' @examples \dontrun{
#' # scotts data
#' gs_reso(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_reso(id=ro_id, keyname='ropensciGaugesKey') 
#' }
#' @export
gs_reso <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/resolutions')
  args <- compact(list(date=date))
  out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  bh <- ldply(out$browser_heights, function(x) as.data.frame(x))
  bw <- ldply(out$browser_widths, function(x) as.data.frame(x))
  sw <- ldply(out$screen_widths, function(x) as.data.frame(x))
  return( list(browser_height = bh, browser_width = bw, screen_width = sw) )
}
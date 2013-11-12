#' Information on screen/browser resolutions
#' 
#' @import httr
#' @importFrom plyr compact rbind.fill
#' @inheritParams gs_traffic
#' @examples \dontrun{
#' # scotts data
#' gs_reso(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' out <- gs_gauge_list(keyname='ropensciGaugesKey')
#' gs_reso(id=out$brief[6,1], keyname='ropensciGaugesKey') 
#' }
#' @export
gs_reso <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/resolutions', id)
  args <- compact(list(date=date))
  tt <- GET(url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  bh <- do.call(rbind.fill, lapply(out$browser_heights, function(x) data.frame(x,stringsAsFactors=FALSE)))
  bw <- do.call(rbind.fill, lapply(out$browser_widths, function(x) data.frame(x,stringsAsFactors=FALSE)))
  sw <- do.call(rbind.fill, lapply(out$screen_widths, function(x) data.frame(x,stringsAsFactors=FALSE)))
  return( list(browser_height = bh, browser_width = bw, screen_width = sw) )
}
#' Information on screen/browser resolutions
#' 
#' @template all
#' @import httr
#' @importFrom plyr compact rbind.fill
#' @export
#' @inheritParams gs_traffic
#' @param callopts Curl debugging options passed in to httr::GET
#' @examples \dontrun{
#' gs_reso(id='4efd83a6f5a1f5158a000004')
#' 
#' # Get list of gauge's, then pass in one of the ids
#' out <- gs_gauge_list()
#' gs_reso(id=out$brief[12,1]) 
#' }

gs_reso <- function(id, date=NULL, keyname='GaugesKey', callopts=list())
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/resolutions', id)
  args <- compact(list(date=date))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)
  bh <- do.call(rbind.fill, lapply(out$browser_heights, function(x) data.frame(x,stringsAsFactors=FALSE)))
  bw <- do.call(rbind.fill, lapply(out$browser_widths, function(x) data.frame(x,stringsAsFactors=FALSE)))
  sw <- do.call(rbind.fill, lapply(out$screen_widths, function(x) data.frame(x,stringsAsFactors=FALSE)))
  return( list(browser_height = bh, browser_width = bw, screen_width = sw) )
}
#' Gets referrers for a gauge, paginated.
#' 
#' @import httr
#' @importFrom plyr compact rbind.fill
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param page page to return
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_ref(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' out <- gs_gauge_list(keyname='ropensciGaugesKey')
#' gs_ref(id=out$brief[6,1], keyname='ropensciGaugesKey') # ropensci referrers
#' }
#' @export
gs_ref <- function(id, date=NULL, page=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s/referrers', id)
  args <- compact(list(date=date, page=page))
  tt <- GET(url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  out <- content(tt)
  dat <- do.call(rbind.fill, lapply(out$referrers, function(x) data.frame(x,stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "referrers"]
  return( list(metadata = meta, data=dat) )
}
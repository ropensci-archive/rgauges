#' Gets top content for a gauge, paginated.
#' 
#' @import httr lubridate
#' @inheritParams gs_ref
#' @param fromdate Date to get data from. Defaults to today.
#' @param todate Date to get data to. Defaults to today.
#' @examples \dontrun{
#' # scotts data
#' gs_pageviews(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_pageviews(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_pageviews <- function(id, fromdate = 'today', todate = 'today', keyname='GaugesKey')
{
  datestoget <- c(today()-1, today())
  
  getcontents <- function(x){  
    key <- getOption(keyname)
    url <- paste0('https://secure.gaug.es/gauges/', id, '/content')
    args <- compact(list(date=x))
    out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
    temp <- ldply(out$content, function(x) as.data.frame(x))
    return( temp )
  }
  
  llply(datestoget, getcontents)
}

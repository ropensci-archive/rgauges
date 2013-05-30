#' Gets top content for a gauge, paginated.
#' 
#' @import httr
#' @inheritParams gs_ref
#' @examples \dontrun{
#' # scotts data
#' gs_content(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_content(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_content <- function(id, date=NULL, page=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/content')
  args <- compact(list(date=date, page=page))
  out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  temp <- ldply(out$content, function(x) as.data.frame(x))
  return( temp )
}

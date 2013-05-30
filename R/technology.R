#' Gets browsers and platforms for a gauge.
#' 
#' @import httr
#' @inheritParams gs_traffic
#' @return list of two, browsers and platforms
#' @examples \dontrun{
#' # scotts data
#' gs_tech(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_tech(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_tech <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/technology')
  args <- compact(list(date=date))
  out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  brows <- 
    ldply(out$browsers, function(x) if(length(x$versions)==0){
      data.frame(browser=x$title, version="NA", views=x$views)
    } else
    {
      thing <- data.frame(x$title, ldply(x$versions, function(y) as.data.frame(y))) 
      names(thing) <- c("browser","version","views")
      thing
    })
  plats <- ldply(out$platforms, function(x) as.data.frame(x))
  return( list(browsers = brows, platforms = plats) )
}

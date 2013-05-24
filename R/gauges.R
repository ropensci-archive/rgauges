#' Information on yourself
#' 
#' @import httr
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_me()
#' 
#' # ropensci data
#' gs_me("ropensciGaugesKey")
#' }
#' @export
gs_me <- function(keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- 'https://secure.gaug.es/me'
#   args <- compact(list())
  content( GET(url=url, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
}

#' Traffic on a gauges ID
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_traffic(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_traffic(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_traffic <- function(id, date=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/traffic')
  args <- compact(list(date=date))
  out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  temp <- ldply(out$traffic, function(x) as.data.frame(x))
  return( temp )
}

#' List your gauges
#' 
#' @import httr
#' @param page Page to return.
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_list()
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' }
#' @export
gs_list <- function(keyname='GaugesKey', page=NULL)
{
  key <- getOption(keyname)
  url <- 'https://secure.gaug.es/gauges'
  args <- compact(list(page=page))
  content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
}

#' Information on locations
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param keyname Your API key name in your .Rprofile file
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

#' Information on referrers
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param page page to return
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_ref(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_ref(id=ro_id, keyname='ropensciGaugesKey') # ropensci referrers
#' }
#' @export
gs_ref <- function(id, date=NULL, page=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/referrers')
  args <- compact(list(date=date, page=page))
  content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
}

#' Information on screen/browser resolutions
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_reso(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_reso(id=ro_id, keyname='ropensciGaugesKey') # ropensci locations
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

#' Gets browsers and platforms for a gauge.
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param keyname Your API key name in your .Rprofile file
#' @return list of two, browsers and platforms
#' @examples \dontrun{
#' # scotts data
#' gs_tech(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_tech(id=ro_id, keyname='ropensciGaugesKey') # ropensci locations
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

#' Gets top content for a gauge, paginated.
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD.
#' @param page page to return
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_content(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_content(id=ro_id, keyname='ropensciGaugesKey') # ropensci locations
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
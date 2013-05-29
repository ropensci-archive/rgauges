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
#' gs_traffic(id='4efd83a6f5a1f5158a000004', date='2013-05-26')
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
#   args <- compact(list(date=date))
  out <- content( GET(url=url, query=args, config=list(date=date, httpheader=paste0('X-Gauges-Token:',key))) )
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
#' gs_list_gauges()
#' 
#' # ropensci data
#' ro_id <- gs_list_gauges(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' }
#' @export
gs_list_gauges <- function(keyname='GaugesKey', page=NULL)
{
  key <- getOption(keyname)
  url <- 'https://secure.gaug.es/gauges'
  args <- compact(list(page=page))
  content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
}

#' Creates a new gauge.
#' 
#' @param title Title of the gauge. 
#' @param tz The time zone that should be used for all date/time operations. See here 
#'    \url{http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html} for reference. 
#' @param allowed_hosts Comma or space separated list of domains to accept tracking data from. 
#' @param keyname Your API key name in your .Rprofile file
#' @details Note that you can create gaguges with the same names, beware. 
#' @examples \dontrun{
#' gs_gauge_create() # create a gauge with defaults, your gauge will be called hello_world
#' }
#' @export
gs_gauge_create <- function(title = 'hello_world2', tz = 'Eastern Time (US & Canada)', 
                            allowed_hosts = NULL, keyname='GaugesKey')
{  
  token <- add_headers("X-Gauges-Token" = key)
  body <- compact(list(title = title, tz = tz, allowed_hosts = allowed_hosts))
  http_status(POST("https://secure.gaug.es/gauges", token, body = body))$message
}

#' Permanently deletes a gauge.
#' 
#' @param id id of the gauge
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' gs_gauge_create() # create a dummy gauge
#' gs_gauge_delete(id='51a54285f5a1f553cf000004') # and delete it
#' }
#' @export
gs_gauge_delete <-  function(id, keyname='GaugesKey'){
  key <- getOption(keyname)
  url <- 'https://secure.gaug.es/gauges/'
  url <- paste0(url, id)
  http_status(DELETE(url, token))$message
}

#' Gets details for a gauge.
#' 
#' @param id id of the gauge
#' @param keyname Your API key name in your .Rprofile file
#' @details Gets details on a gauge, by specifying the id of the gauge. 
#' @examples \dontrun{
#' gs_gauge_create() # create a dummy gauge
#' gs_gauge_detail(id='4efd83a6f5a1f5158a000004') # and get detail on it
#' }
#' @export
gs_gauge_detail <- function(id, keyname='GaugesKey'){
  key <- getOption(keyname)
  url <- 'https://secure.gaug.es/gauges/'
  url <- paste0(url, id)
  out <- content(GET(url, config=list(httpheader=paste0('X-Gauges-Token:',key))))
  parse_gauge_detail(out)
}

#' Parse guage detail
#' @param out Input from a gauge detail call.
#' @keywords internal
#' @export
parse_gauge_detail <- function(out)
{
  obj <- list(title = out$gauge$title,
              id = out$gauge$id,
              creator_id = out$gauge$creator_id,
              enabled = out$gauge$enabled,
              time_zone = out$gauge$tz,
              now_in_zone = out$gauge$now_in_zone,
              today = data.frame(out$gauge$today),
              yesterday = data.frame(out$gauge$yesterday),
              recent_hours = ldply(out$gauge$recent_hours, function(x) as.data.frame(x)),
              recent_days = ldply(out$gauge$recent_days, function(x) as.data.frame(x)),
              recent_months = ldply(out$gauge$recent_months, function(x) as.data.frame(x)),
              all_time = data.frame(out$gauge$all_time),
              allowed_hosts = out$gauge$allowed_hosts,
              urls = out$gauge$urls)
  class(obj) <- "gauge"
  return(obj)
}

#' Updates and returns a gauge with the updates applied.
#' 
#' @param title Title of the gauge. 
#' @param tz The time zone that should be used for all date/time operations. See here 
#'    \url{http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html} for reference. 
#' @param allowed_hosts Comma or space separated list of domains to accept tracking data from. 
#' @param keyname Your API key name in your .Rprofile file
#' @details Note that you can create gaguges with the same names, beware. 
#' @examples \dontrun{
#' gs_gauge_update(id='51a54191613f5d1a4b0000a7', title='foo_bar')
#' }
#' @export
gs_gauge_update <- function(title = 'foo_bar', tz = 'Eastern Time (US & Canada)', 
                            allowed_hosts = NULL, keyname='GaugesKey')
{  
  token <- add_headers("X-Gauges-Token" = key)
  body <- compact(list(title = title, tz = tz, allowed_hosts = allowed_hosts))
  out <- content(PUT(paste0("https://secure.gaug.es/gauges/",id), token, body = body))
  parse_gauge_detail(out)
}

#' Information on locations
#' 
#' @import httr
#' @inheritParams gs_traffic
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

#' Gets search terms for a gauge, paginated.
#' 
#' @import httr
#' @inheritParams gs_ref
#' @examples \dontrun{
#' # scotts data
#' gs_terms(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_terms(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_terms <- function(id, date=NULL, page=NULL, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/terms')
  args <- compact(list(date=date, page=page))
  out <- content( GET(url=url, query=args, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  temp <- ldply(out$terms, function(x) as.data.frame(x))
  return( temp )
}

#' Lists the people that have access to a Gauge.
#' 
#' @import httr
#' @param id Your gaug.es id
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_shares(id='4efd83a6f5a1f5158a000004')
#' 
#' # ropensci data
#' ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
#' gs_shares(id=ro_id, keyname='ropensciGaugesKey')
#' }
#' @export
gs_shares <- function(id, keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- paste0('https://secure.gaug.es/gauges/', id, '/shares')
  out <- content( GET(url=url, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  return( out )
}

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


#' Returns an array of your API clients.
#' 
#' @import httr
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # scotts data
#' gs_clients()
#' 
#' # ropensci data
#' gs_clients(keyname='ropensciGaugesKey')
#' }
#' @export
gs_clients <- function(keyname='GaugesKey')
{
  key <- getOption(keyname)
  url <- 'https://secure.gaug.es/clients'
  out <- content( GET(url=url, config=list(httpheader=paste0('X-Gauges-Token:',key))) )
  return( out )
}
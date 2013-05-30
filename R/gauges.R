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
#' List your gaug.es
#' 
#' @import httr
#' @template all
#' @importFrom plyr rbind.fill
#' @param page Page to return.
#' @param keyname Your API key name in your .Rprofile file
#' @param callopts Curl debugging options passed in to httr::GET
#' @examples \dontrun{
#' gs_gauge_list()
#' }
#' @export
gs_gauge_list <- function(key=NULL, keyname='GaugesKey', page=NULL, callopts=list())
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- 'https://secure.gaug.es/gauges'
  args <- compact(list(page=page))
  tt <- GET(url=url, query=args, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)
  brief <- do.call(rbind.fill, lapply(out$gauges, function(x) data.frame(x[c('id','title')],stringsAsFactors=FALSE)))
  list(brief=brief, all=out)
}

#' Permanently deletes a gauge.
#' 
#' @template all
#' @param id id of the gauge
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' # create a dummy gauge
#' out <- gs_gauge_create()
#' 
#' # and delete it
#' gs_gauge_delete(out$id)
#' }
#' @export
gs_gauge_delete <-  function(id, key=NULL, keyname='GaugesKey'){
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s', id)
  message(http_status(DELETE(url, add_headers("X-Gauges-Token" = key)))$message)
}

#' Gets details for a gauge.
#' 
#' @template all
#' @param id id of the gauge
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param callopts Curl debugging options passed in to httr::GET
#' @details Gets details on a gauge, by specifying the id of the gauge. 
#' @examples \dontrun{
#' # create a dummy gauge
#' out <- gs_gauge_create() 
#' 
#' # and get detail on it
#' gs_gauge_detail(out$id)
#' }
#' @export
gs_gauge_detail <- function(id, key=NULL, keyname='GaugesKey', callopts=list()){
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('https://secure.gaug.es/gauges/%s', id)
  tt <- GET(url, config=c(add_headers('X-Gauges-Token' = key), callopts))
  stop_for_status(tt)
  out <- content(tt)
  parse_gauge_detail(out)
}

#' Parse guage detail
#' @importFrom plyr ldply
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

#' Creates a new gauge.
#' 
#' @template all
#' @param title Title of the gauge. 
#' @param tz The time zone that should be used for all date/time operations. See here 
#'    \url{http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html} for reference. 
#' @param allowed_hosts Comma or space separated list of domains to accept tracking data from. 
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param verbose Print http status (default) or not
#' @details Note that you can create gaguges with the same names, beware. 
#' @return Gives HTTP status and metadata for the new gauge.
#' @examples \dontrun{
#' gs_gauge_create() # create a gauge with defaults, your gauge will be called hello_world
#' }
#' @export
gs_gauge_create <- function(title = 'hello_world2', tz = 'Eastern Time (US & Canada)', 
  allowed_hosts = NULL, key=NULL, keyname='GaugesKey', verbose=TRUE)
{  
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  body <- compact(list(title = title, tz = tz, allowed_hosts = allowed_hosts))
  tt <- POST("https://secure.gaug.es/gauges", add_headers("X-Gauges-Token" = key), body = body)
  stop_for_status(tt)
  status <- http_status(tt)$message
  if(verbose) message(status)
  out <- content(tt)
  out2 <- out$gauge
  listout <- out2[names(out2) %in% c('tz','id','title','creator_id')]
  listout$http_status <- status
  return( listout )
}

#' Updates and returns a gauge with the updates applied.
#' 
#' @template all
#' @param id Id of the gauge
#' @param title Title of the gauge. 
#' @param tz The time zone that should be used for all date/time operations. See here 
#'    \url{http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html} for reference. 
#' @param allowed_hosts Comma or space separated list of domains to accept tracking data from. 
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param verbose Print http status (default) or not
#' @details Note that you can create gaguges with the same names, beware. 
#' @return Gives HTTP status and metadata for the new gauge.
#' @examples \dontrun{
#' out <- gs_gauge_create(title='foo_bar')
#' gs_gauge_update(id=out$id, tz=out$tz, title='dumb')
#' }
#' @export
gs_gauge_update <- function(id = NULL, tz = 'Eastern Time (US & Canada)', 
  title = 'foo_bar', allowed_hosts = NULL, key=NULL, keyname='GaugesKey', verbose=TRUE)
{  
  if(is.null(id))
    stop('You must provide a gauge id')
  
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  
  token <- add_headers("X-Gauges-Token" = key)
  body <- compact(list(title = title, tz = tz, allowed_hosts = allowed_hosts))
  tt <- PUT(sprintf("https://secure.gaug.es/gauges/%s",id), token, body = body)
  stop_for_status(tt)
  status <- http_status(tt)$message
  if(verbose) message(status)
  out <- content(tt)
  out2 <- out$gauge
  listout <- out2[names(out2) %in% c('tz','id','title','creator_id')]
  listout$http_status <- status
  return( listout )
}
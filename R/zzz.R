#' Check if object is of class gauge
#' @param x input
#' @export
is.gauge <- function(x) inherits(x, "gauge")

gsbase <- function() 'https://secure.gaug.es'

gs_GET <- function(url, key, keyname, args=list(), ...){
  key <- key_check(key, keyname)
  tt <- GET(url, query=args, add_headers('X-Gauges-Token' = key), ...)
  check_resp(tt)
  out <- content(tt, as = "text")
  jsonlite::fromJSON(out, FALSE)
}

check_resp <- function(x){
  if( x$status_code != 200 )
    stop(sprintf("%s - %s", x$status_code, content(x)$message), call. = FALSE)
}

key_check <- function(x, y){
  tmp <- if(is.null(x)) Sys.getenv(y, "") else x
  if(tmp == "") getOption(y, stop("you need an API key for Gaug.es data")) else tmp
}


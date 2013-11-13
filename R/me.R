#' Information on yourself.
#' 
#' @template all
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' gs_me()
#' }
#' @export
gs_me <- function(keyname='GaugesKey')
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- 'https://secure.gaug.es/me'
  tt <- GET(url=url, config=list(httpheader=paste0('X-Gauges-Token:',key)))
  stop_for_status(tt)
  content(tt)
}

#' Updates and returns your information with the updates applied.
#' @export
gs_me_update <- function()
{
  message("Hmm, not sure if it's worth implementing this yet...let me know if you want it")
}

#' Information on yourself.
#' 
#' @template all
#' @param keyname Your API key name in your .Rprofile file
#' @examples \dontrun{
#' gs_me()
#' gs_me(callopts=verbose())
#' }
#' @export
gs_me <- function(keyname='GaugesKey', callopts=list())
{
  key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- 'https://secure.gaug.es/me'
  tt <- GET(url=url, config=c(httpheader=paste0('X-Gauges-Token: ',key), callopts))
  stop_for_status(tt)
  content(tt)
}

#' Updates and returns your information with the updates applied.
#' @export
gs_me_update <- function()
{
  message("Hmm, not sure if it's worth implementing this yet...let me know if you want it")
}

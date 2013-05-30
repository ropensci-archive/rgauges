#' Information on yourself.
#' 
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

#' Updates and returns your information with the updates applied.
#' @export
gs_update_me <- function()
{
  message("Hmm, not sure if it's worth implementing this yet...")
}

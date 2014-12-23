#' Information on yourself.
#'
#' @template all
#' @export
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' gs_me()
#' library(httr)
#' gs_me(callopts=verbose())
#' }
gs_me <- function(key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  tt <- GET(paste0(gsbase(), "/me"), add_headers('X-Gauges-Token' = key), ...)
  stop_for_status(tt)
  content(tt)
}

#' Updates and returns your information with the updates applied.
#' @export
gs_me_update <- function()
{
  message("Hmm, not sure if it's worth implementing this yet...let me know if you want it")
}

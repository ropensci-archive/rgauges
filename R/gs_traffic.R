#' Traffic on a gauges ID
#'
#' @export
#' @template all
#' @param id Your gaug.es id
#' @param date Date format YYYY-MM-DD. This works in a weird way. If you give no
#'    date, you get the traffic for each day since the beginning of the current month,
#'    but if you give a date, you get the traffic for each day for that entire month.
#' @param key API key. If left NULL, function looks for key in your options settings
#' defined in the keyname parameter
#' @param keyname Your API key name in your .Rprofile file
#' @param ... Curl debugging options passed in to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' gs_traffic(id='4efd83a6f5a1f5158a000004')
#' gs_traffic(id='4efd83a6f5a1f5158a000004', date='2013-05-26')
#' }

gs_traffic <- function(id, date=NULL, key=NULL, keyname='GaugesKey', ...)
{
  if(is.null(key))
    key <- getOption(keyname, stop("you need an API key for Gaug.es data"))
  url <- sprintf('%s/gauges/%s/traffic', gsbase(), id)
  args <- compact(list(date=date))
  out <- gs_GET(url, key, args, ...)
  dat <- do.call(rbind.fill, lapply(out$traffic, function(x) data.frame(x, stringsAsFactors=FALSE)))
  meta <- out[!names(out) %in% "traffic"]
  list(metadata=meta, data=dat)
}

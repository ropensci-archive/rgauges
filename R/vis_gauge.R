#' Plot a class of gauge
#' @param input Input data.frame
#' @param ... Additional parameters passed on to vis_gauge.default
#' @export
vis_gauge <- function(input, ...) UseMethod("vis_gauge")

#' Visualize gauge analytics.
#' 
#' @import ggplot2 reshape2 grid gridExtra
#' @S3method vis_gauge default
#' @param x gauge S3 object
#' @examples \dontrun{
#' # get detail on the ropensci gauge
#' out <- gs_gauge_detail(id='500ebcf4613f5d79c700001c', keyname='ropensciGaugesKey')
#' 
#' # visualize
#' vis_gauge(x=out)
#' }
vis_gauge.default <- function(x)
{
  if(!is.gauge(x))
    stop("Input is not of class gauge")
  
  by_hour <- melt(x$recent_hours)
  by_day <- melt(x$recent_days)
  by_day$date <- as.Date(by_day$date)
  by_month <- melt(x$recent_months)
  by_month$date <- as.Date(by_month$date)
  
  gauge_theme <- function(){
    list(theme(panel.grid.major = element_blank(),
               panel.grid.minor = element_blank(),
               legend.position = c(0.7,0.6),
               legend.key = element_blank()),
         guides(col = guide_legend(nrow=1)))
  }
  
  a <- ggplot(by_hour, aes(hour, value, group=variable, colour=variable)) +
    theme_bw(base_size=18) + 
    geom_line(size=2) +
    scale_color_brewer(name="", palette=2) +
    labs(x="Last 24 Hours", y="") +
    gauge_theme()
  
  b <- ggplot(by_day, aes(date, value, group=variable, colour=variable)) +
    theme_bw(base_size=18) + 
    geom_line(size=2) +
    scale_color_brewer(name="", palette=3) +
    labs(x="Last 30 Days", y="") +
    gauge_theme()
  
  c <- ggplot(by_month, aes(date, value, group=variable, colour=variable)) +
    theme_bw(base_size=18) + 
    geom_line(size=2) +
    scale_color_brewer(name="", palette=4) +
    labs(x="Last 12 Months", y="") +
    gauge_theme()
  
  plots <- grid.arrange(a, b, c)
    
  return( plots )
}
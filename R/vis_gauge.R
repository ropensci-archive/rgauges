#' Plot a class of gauge
#' 
#' @template all
#' @import gridExtra reshape2 scales ggplot2
#' @importFrom lubridate today hour<-
#' @param x Input, see examples
#' @param ... Additional parameters passed on to vis_gauge.default, not currenlty used
#' @export
#' @examples \dontrun{
#' # get detail on a gauge
#' out <- gs_gauge_detail(id='500ebcf4613f5d79c700001c', keyname='ropensciGaugesKey')
#' 
#' # visualize
#' vis_gauge(x=out)
#' }
vis_gauge <- function(...) UseMethod("vis_gauge")

#' @method vis_gauge default
#' @export
#' @rdname vis_gauge
vis_gauge.default <- function(x, ...)
{
  if(!is.gauge(x))
    stop("Input is not of class gauge")
  
  yesterday_ <- x$recent_hours[as.character(as.numeric(row.names(x$recent_hours[x$recent_hours$hour == "00", ]))+1):nrow(x$recent_hours),]
  today_ <- x$recent_hours[1:row.names(x$recent_hours[x$recent_hours$hour == "00", ]),]
  makeposixtime <- function(y, yest=FALSE){  
    if(yest){ nn <- today()-1 } else
      { nn <- today() }
    num <- as.numeric(as.character(y))
    if(num == 0){
      nn <- 
        as.POSIXct(paste(nn,"00:00:01"), format='%Y-%m-%d %H:%M:%S')
    } else
    {
      hour(nn) <- num      
    }
    return( nn )
  }
  
  alltimes <- c(lapply(today_$hour, makeposixtime),
    lapply(yesterday_$hour, makeposixtime, yest=TRUE))
  alltimes_df <- cbind(x$recent_hours, time=t(data.frame(alltimes)))
  row.names(alltimes_df) <- NULL

  by_hour <- melt(alltimes_df[,-1])
  by_hour$time <- as.POSIXct(by_hour$time, format= '%Y-%m-%d %H:%M:%S')
  
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
  
  a <- ggplot(by_hour, aes(time, value, group=variable, colour=variable)) +
    theme_bw(base_size=18) + 
    geom_line(size=2) +
    scale_color_brewer(name="", palette=2) +
    scale_x_datetime(breaks = date_breaks("3 hour"), labels = date_format('%H')) +
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
    scale_color_brewer(name="", palette=7) +
    labs(x="Last 12 Months", y="") +
    gauge_theme()
  
  plots <- grid.arrange(a, b, c)
    
  return( plots )
}
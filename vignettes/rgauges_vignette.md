<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{rgauges vignette}
-->




rgauges vignette
=======

Gaug.es is a paid service for website analytics. It doesn't do as much as Google Analytics, but its super simple and clean, and has a great iPhone app, and an Android app. Each website you want to track is tracked under its own gauge. 

Most functions have the same format in which you pass in the id for a gauge (i.e, a website you are tracking), and your API key (see authentication below). Some functions give back data on your site overall and in that case you don't pass in a date, but others can be quieried per date or a range of dates, in which case you can pass in dates. There is one plotting function (`vis_gauge`) that gives a nice default plot. But of course you can easily make your own plots. 

## Gaug.es API docs

See the Gaug.es API documentation here [http://get.gaug.es/documentation/](http://get.gaug.es/documentation/)

`rgauges` is listed as one of the Gaug.es API libraries [here](http://get.gaug.es/documentation/api/libraries/), along with libraries for Ruby and Node.js

## Authentication

Get your own API key in your Gaug.es 'My Account' page and put in your _.Rprofile_ file under the name 'GaugesKey' or some other name (you can specify `keyname` in function calls - but if you put in as 'GaugesKey' you're all set and don't need to bother with the `keyname` parameter).

You can alternatively pass in your key using the `key` parameter in each function. 

Note that in the below examples I'm using my key from my _.Rprofile_ file, so you don't see it being passed in the function call. 


## Installation

More stable version from CRAN


```r
install.packages("rgauges")
```


Development version from Github


```r
install.packages("devtools")
library(devtools)
install_github("rgauges", "ropensci")
```




```r
library(rgauges)
```


## Your info

Information on yourself.


```r
gs_me()
```

```
## $user
## $user$id
## [1] "4eddbafb613f5d5139000001"
## 
## $user$email
## [1] "myrmecocystus@gmail.com"
## 
## $user$name
## [1] "Scott Chamberlain"
## 
## $user$first_name
## [1] "Scott"
## 
## $user$last_name
## [1] "Chamberlain"
## 
## $user$urls
## $user$urls$self
## [1] "https://secure.gaug.es/me"
## 
## $user$urls$gauges
## [1] "https://secure.gaug.es/gauges"
## 
## $user$urls$clients
## [1] "https://secure.gaug.es/clients"
```


## Traffic

Traffic on a gauges ID


```r
gs_traffic(id = "4efd83a6f5a1f5158a000004")
```

```
## $metadata
## $metadata$date
## [1] "2014-03-14"
## 
## $metadata$views
## [1] 381
## 
## $metadata$people
## [1] 207
## 
## $metadata$urls
## $metadata$urls$older
## [1] "https://secure.gaug.es/gauges/4efd83a6f5a1f5158a000004/traffic?date=2014-02-01"
## 
## $metadata$urls$newer
## NULL
## 
## 
## 
## $data
##          date views people
## 1  2014-03-01    43     18
## 2  2014-03-02    28     16
## 3  2014-03-03    20     12
## 4  2014-03-04    38     15
## 5  2014-03-05    29     17
## 6  2014-03-06    18     14
## 7  2014-03-07    15     12
## 8  2014-03-08    23     15
## 9  2014-03-09    16      9
## 10 2014-03-10    68     51
## 11 2014-03-11    26     15
## 12 2014-03-12    43     26
## 13 2014-03-13    11      9
## 14 2014-03-14     3      3
```



## Screen/browser information

Information on screen/browser resolutions


```r
gs_reso(id = "4efd83a6f5a1f5158a000004")
```

```
## $browser_height
##   title views
## 1   600   166
## 2   768    78
## 3   480    57
## 4   900    57
## 5  1024    22
## 
## $browser_width
##   title views
## 1  1280   134
## 2  1024    93
## 3  1600    55
## 4  1440    38
## 5   800    28
## 6   320    18
## 7   480     9
## 8  2000     5
## 
## $screen_width
##   title views
## 1  1280   132
## 2  1600    95
## 3  1440    84
## 4  1024    38
## 5   320    10
## 6  2000    10
## 7   800     8
## 8   480     4
```


## Visualize traffic data

You'll need to load ggplot2 


```r
library(ggplot2)
out <- gs_gauge_detail(id = "4efd83a6f5a1f5158a000004")
vis_gauge(out)
```

```
## Using time as id variables
## Using date as id variables
## Using date as id variables
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 

```
## NULL
```


## Shares

Lists the people that have access to a Gauge.


```r
gs_shares(id = "4efd83a6f5a1f5158a000004")
```

```
## $shares
## $shares[[1]]
## $shares[[1]]$id
## [1] "4eddbafb613f5d5139000001"
## 
## $shares[[1]]$email
## [1] "myrmecocystus@gmail.com"
## 
## $shares[[1]]$name
## [1] "Scott Chamberlain"
## 
## $shares[[1]]$first_name
## [1] "Scott"
## 
## $shares[[1]]$last_name
## [1] "Chamberlain"
## 
## $shares[[1]]$type
## [1] "user"
## 
## $shares[[1]]$urls
## $shares[[1]]$urls$remove
## [1] "https://secure.gaug.es/gauges/4efd83a6f5a1f5158a000004/shares/4eddbafb613f5d5139000001"
```


## Referrers

Gets referrers for a gauge, paginated.


```r
gs_ref(id = "4efd83a6f5a1f5158a000004", date = "2014-03-10")$data
```

```
##                                                                               url
## 1                                                             http://twitter.com/
## 2                                                               http://bitly.com/
## 3                                 http://www.r-bloggers.com/r-ecology-workshop-2/
## 4                            http://semalt.com/crawler.php?u=http://recology.info
## 5 http://r-ecology.blogspot.com/2011/09/r-tutorial-on-visualizationsgraphics.html
##   views                   host
## 1    24            twitter.com
## 2     2              bitly.com
## 3     2         r-bloggers.com
## 4     2             semalt.com
## 5     1 r-ecology.blogspot.com
##                                                 path
## 1                                                  /
## 2                                                  /
## 3                             /r-ecology-workshop-2/
## 4                /crawler.php?u=http://recology.info
## 5 /2011/09/r-tutorial-on-visualizationsgraphics.html
```


## Technology

Gets browsers and platforms for a gauge.


```r
gs_tech(id = "4efd83a6f5a1f5158a000004")
```

```
## $browsers
##              browser version views
## 1             Chrome    33.0   114
## 2             Chrome    32.0    20
## 3             Chrome    31.0     3
## 4             Chrome    28.0     3
## 5             Chrome    21.0     2
## 6             Chrome    29.0     2
## 7             Chrome     0.3     1
## 8             Chrome    30.0     1
## 9             Chrome    27.0     1
## 10            Chrome    23.0     1
## 11            Chrome    22.0     1
## 12            Chrome    34.0     1
## 13            Chrome    35.0     1
## 14           Firefox    27.0    99
## 15           Firefox    24.0    15
## 16           Firefox    21.0     9
## 17           Firefox    26.0     9
## 18           Firefox    25.0     1
## 19           Firefox    22.0     1
## 20           Firefox    16.0     1
## 21 Internet Explorer     8.0    25
## 22 Internet Explorer     7.0     9
## 23 Internet Explorer    11.0     6
## 24 Internet Explorer     9.0     5
## 25 Internet Explorer    10.0     3
## 26            Safari     7.0    16
## 27            Safari     7.6     7
## 28            Safari     5.1     4
## 29            Safari     6.0     3
## 30            Safari     6.1     3
## 31            Safari     7.1     1
## 32             Other      NA    10
## 33             Opera     4.2     2
## 34             Opera    20.0     1
## 
## $platforms
##         key     title views
## 1   windows   Windows   200
## 2 macintosh Macintosh   107
## 3     linux     Linux    58
## 4    iphone    iPhone     8
## 5     other     Other     3
## 6   android   Android     3
## 7      ipad      iPad     2
```


## Get pageviews for each page


```r
head(gs_pageviews(id = "4efd83a6f5a1f5158a000004", fromdate = "2013-11-01", 
    todate = "2013-11-06"))
```

```
##                                             title V1
## 1                                        Recology 84
## 2                                    R to GeoJSON 20
## 3                        ggplot2 maps with insets  9
## 4 Displaying Your Data in Google Earth Using R2G2  8
## 5  GBIF biodiversity data from R - more functions 12
## 6                                     R resources 15
```


## Top content

Gets top content for a gauge, paginated.


```r
head(gs_content(id = "4efd83a6f5a1f5158a000004", date = "2013-11-01")$data)
```

```
##                         path          host views
## 1                          / recology.info     5
## 2          /2013/06/geojson/ recology.info     3
## 3 /2012/08/ggplot-inset-map/ recology.info     2
## 4     /2012/10/R2G2-package/ recology.info     2
## 5    /2012/10/rgbif-newfxns/ recology.info     1
## 6      /2013/07/r-resources/ recology.info     1
##                                             title
## 1                                        Recology
## 2                                    R to GeoJSON
## 3                        ggplot2 maps with insets
## 4 Displaying Your Data in Google Earth Using R2G2
## 5  GBIF biodiversity data from R - more functions
## 6                                     R resources
##                                              url
## 1                          http://recology.info/
## 2          http://recology.info/2013/06/geojson/
## 3 http://recology.info/2012/08/ggplot-inset-map/
## 4     http://recology.info/2012/10/R2G2-package/
## 5    http://recology.info/2012/10/rgbif-newfxns/
## 6      http://recology.info/2013/07/r-resources/
```


## Search terms

Gets search terms for a gauge, paginated.


```r
gs_terms(id = "4efd83a6f5a1f5158a000004", date = "2014-02-05")$data
```

```
##                                                        term views
## 1                              r markdown twitter bootstrap     3
## 2                                        geoconcept geojson     2
## 3                                              recology.com     2
## 4                                       two sex demographic     1
## 5                                                  r govdat     1
## 6  presenting logistic regression results to administrators     1
## 7                                                 phylometa     1
## 8                      http://recology.info/2012/12/taxize/     1
## 9                                                  recology     1
## 10                                                  gogle r     1
## 11                                                   gbif r     1
## 12                                      plot climate data r     1
## 13                         markdown for rstudio change font     1
## 14                                            geojson rgdal     1
## 15                                           species name r     1
```


## Locations

Information on locations


```r
head(gs_locations(id = "4efd83a6f5a1f5158a000004")$data)
```

```
##           title key views region_title region_key  region_views
## 1 United States  US   136           CA         20    California
## 2 United States  US   136           NY         16      New York
## 3 United States  US   136           WA         15    Washington
## 4 United States  US   136           IL         14      Illinois
## 5 United States  US   136           MA          8 Massachusetts
## 6 United States  US   136           PA          7  Pennsylvania
```


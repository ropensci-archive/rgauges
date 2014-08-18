rgauges
=======

[![Build Status](https://api.travis-ci.org/ropensci/rgauges.png)](https://travis-ci.org/ropensci/rgauges)
[![Build status](https://ci.appveyor.com/api/projects/status/vbir624l5erfhe0a/branch/master)](https://ci.appveyor.com/project/sckott/rgauges/branch/master)

`rgauges` is an R wrapper to the gaug.es API for website analytics.

### Gaug.es API docs

See the Gaug.es API documentation here [http://get.gaug.es/documentation/](http://get.gaug.es/documentation/)

`rgauges` is listed as one of the Gaug.es API libraries [here](http://get.gaug.es/documentation/api/libraries/), along with libraries for Ruby and Node.js

### Authentication

Get your own API key in your Gaug.es 'My Account' page and put in your .Rprofile file under the name 'GaugesKey' or some other name (you can specify `keyname` in function calls - but if you put in as 'GaugesKey' you're all set and don't need to bother with the `keyname` parameter).

### Quick start

#### Installation

More stable version from CRAN

```coffee
install.packages("rgauges")
```

Development version from Github

```coffee
install.packages("devtools")
library(devtools)
install_github("rgauges", "ropensci")
library(rgauges)
```

#### Your info

```coffee
gs_me()

$user
$user$name
[1] "Scott Chamberlain"

...etc... [cutoff for brevity]
```

##### Traffic

```coffee
gs_traffic(id='4efd83a6f5a1f5158a000004')
```

```coffee
$metadata
$metadata$people
[1] 231

$metadata$views
[1] 557

$metadata$urls
$metadata$urls$older
[1] "https://secure.gaug.es/gauges/4efd83a6f5a1f5158a000004/traffic?date=2013-10-01"

$metadata$urls$newer
NULL


$metadata$date
[1] "2013-11-13"


$data
   people views       date
1      13    19 2013-11-01
2       7    14 2013-11-02
3      17    44 2013-11-03
4      22    62 2013-11-04
5      20    36 2013-11-05
6      21    66 2013-11-06
7      31    44 2013-11-07
8      24    93 2013-11-08
9      14    26 2013-11-09
10     12    21 2013-11-10
11     30    37 2013-11-11
12     37    74 2013-11-12
13     12    21 2013-11-13
```

#### Screen/browser information

```coffee
gs_reso(id='4efd83a6f5a1f5158a000004')
```

```coffee
$browser_height
  views title
1   265   600
2   119   900
3   103   768
4    35   480
5    32  1024

$browser_width
  views title
1   205  1280
2   151  1024
3    89  1600
4    37  1440
5    32   480
6    32   800
7     5   320
8     3  2000

$screen_width
  views title
1   184  1280
2   164  1600
3    76  1440
4    64   480
5    46  1024
6    18  2000
7     3   320
8     2   800
```

#### Visualize traffic data

You'll need to load ggplot2

```coffee
library(ggplot2)
out <- gs_gauge_detail(id='4efd83a6f5a1f5158a000004')
vis_gauge(out)
```

![](inst/assets/plot.png)

------

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

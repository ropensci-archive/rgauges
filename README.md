rgauges
=======

`rgauges` is an R wrapper to the gaug.es API for website analytics.

#### docs

See the Gaug.es API documentation here: http://get.gaug.es/documentation/

#### Auth

Get your own API in your Gaug.es 'My Account' page and put in your .Rprofile file under the name 'GaugesKey' or some other name (you can specify `keyname` in function calls).

#### Quick start

##### your info

```ruby
gs_me()

$user
$user$name
[1] "Scott Chamberlain"
...
```

##### traffic

```ruby
gs_traffic(id='4efd83a6f5a1f5158a000004')

   views       date people
1      0 2013-05-01      0
2      0 2013-05-02      0
3      0 2013-05-03      0
4      0 2013-05-04      0
5      0 2013-05-05      0
6      0 2013-05-06      0
7      0 2013-05-07      0
8      0 2013-05-08      0
9      0 2013-05-09      0
10     0 2013-05-10      0
11     0 2013-05-11      0
12     0 2013-05-12      0
13     0 2013-05-13      0
14     0 2013-05-14      0
15     0 2013-05-15      0
16     0 2013-05-16      0
17     0 2013-05-17      0
18     0 2013-05-18      0
19     0 2013-05-19      0
20     0 2013-05-20      0
21     0 2013-05-21      0
22     0 2013-05-22      0
23     0 2013-05-23      0
24    11 2013-05-24      2
```

##### Screen/browser information

```ruby
gs_reso(id='4efd83a6f5a1f5158a000004')

$browser_height
  title views
1   600     9
2   900     2
3   768     0
4   480     0
5  1024     0

$browser_width
  title views
1  1440     9
2  1600     2
3  1280     0
4  1024     0
5   800     0
6   320     0
7  2000     0
8   480     0

$screen_width
  title views
1  1600     7
2  2000     2
3  1440     2
4  1024     0
5  1280     0
6   320     0
7   800     0
8   480     0
```


[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
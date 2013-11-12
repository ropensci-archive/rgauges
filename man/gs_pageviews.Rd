\name{gs_pageviews}
\alias{gs_pageviews}
\title{Gets top content for a gauge, paginated.}
\usage{
  gs_pageviews(id, fromdate = NULL, todate = NULL,
    page = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{fromdate}{Date to get data from. Defaults to
  today.}

  \item{todate}{Date to get data to. Defaults to today.}

  \item{page}{page to return}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Gets top content for a gauge, paginated.
}
\examples{
\dontrun{
# scotts data
gs_pageviews(id='4efd83a6f5a1f5158a000004', fromdate="2013-11-01", todate="2013-11-06")

# ropensci data
out <- gs_gauge_list(keyname='ropensciGaugesKey')
gs_pageviews(id=out$brief[6,1], keyname='ropensciGaugesKey')
}
}


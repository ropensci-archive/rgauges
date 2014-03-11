\name{gs_pageviews}
\alias{gs_pageviews}
\title{Gets top content for a gauge, paginated.}
\usage{
gs_pageviews(id, fromdate = NULL, todate = NULL, page = NULL,
  keyname = "GaugesKey")
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
\note{
Note that these examples only work if you provide your
Gaug.es API key either by passing in the function, or
storing your key in your .Rprofile file, defaults to
looking for an entry of "GaugesKey".
}
\examples{
\dontrun{
gs_pageviews(id='4efd83a6f5a1f5158a000004', fromdate="2013-11-01", todate="2013-11-06")
}
}


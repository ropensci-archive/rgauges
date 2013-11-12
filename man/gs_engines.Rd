\name{gs_engines}
\alias{gs_engines}
\title{Lists the browser engines and visits to them for a single date.}
\usage{
  gs_engines(id, date = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD. This works in a weird
  way. If you give no date, you get the traffic for each
  day since the beginning of the current month, but if you
  give a date, you get the traffic for each day for that
  entire month.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Lists the browser engines and visits to them for a single
  date.
}
\examples{
\dontrun{
# scotts data
gs_engines(id='4efd83a6f5a1f5158a000004')

# or get a gauge id using X
out <- gs_gauge_list()
gs_engines(id=out$brief[15,1])
gs_engines(id=out$brief[15,1], date="2013-11-01")

# ropensci data
out <- gs_gauge_list(keyname='ropensciGaugesKey')
gs_engines(id=out$brief[6,1], keyname='ropensciGaugesKey')
}
}


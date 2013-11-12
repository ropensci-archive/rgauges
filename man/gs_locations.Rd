\name{gs_locations}
\alias{gs_locations}
\title{Information on locations}
\usage{
  gs_locations(id, date = NULL, keyname = "GaugesKey")
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
  Information on locations
}
\examples{
\dontrun{
out <- gs_gauge_list(keyname='ropensciGaugesKey')
gs_locations(id=out$brief[6,1], keyname='ropensciGaugesKey') # ropensci locations
}
}


\name{gs_traffic}
\alias{gs_traffic}
\title{Traffic on a gauges ID}
\usage{
  gs_traffic(id, date = NULL, keyname = "GaugesKey")
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
  Traffic on a gauges ID
}
\note{
  Note that these examples only work if you provide your
  Gaug.es API key either by passing in the function, or
  storing your key in your .Rprofile file, defaults to
  looking for an entry of "GaugesKey".
}
\examples{
\dontrun{
gs_traffic(id='4efd83a6f5a1f5158a000004')
gs_traffic(id='4efd83a6f5a1f5158a000004', date='2013-05-26')
}
}


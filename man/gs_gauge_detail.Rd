\name{gs_gauge_detail}
\alias{gs_gauge_detail}
\title{Gets details for a gauge.}
\usage{
  gs_gauge_detail(id, keyname = "GaugesKey")
}
\arguments{
  \item{id}{id of the gauge}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Gets details for a gauge.
}
\details{
  Gets details on a gauge, by specifying the id of the
  gauge.
}
\examples{
\dontrun{
gs_gauge_create() # create a dummy gauge
gs_gauge_detail(id='4efd83a6f5a1f5158a000004') # and get detail on it
}
}


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
\note{
  Note that these examples only work if you provide your
  Gaug.es API key either by passing in the function, or
  storing your key in your .Rprofile file, defaults to
  looking for an entry of "GaugesKey".
}
\examples{
\dontrun{
# create a dummy gauge
out <- gs_gauge_create()

# and get detail on it
gs_gauge_detail(out$id)
}
}


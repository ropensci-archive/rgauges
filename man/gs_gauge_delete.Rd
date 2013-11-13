\name{gs_gauge_delete}
\alias{gs_gauge_delete}
\title{Permanently deletes a gauge.}
\usage{
  gs_gauge_delete(id, keyname = "GaugesKey")
}
\arguments{
  \item{id}{id of the gauge}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Permanently deletes a gauge.
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

# and delete it
gs_gauge_delete(out$id)
}
}


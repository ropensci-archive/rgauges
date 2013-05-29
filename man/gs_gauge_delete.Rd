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
\examples{
\dontrun{
gs_gauge_create() # create a dummy gauge
gs_gauge_delete(id='51a54285f5a1f553cf000004') # and delete it
}
}


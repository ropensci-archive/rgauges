\name{gs_shares}
\alias{gs_shares}
\title{Lists the people that have access to a Gauge.}
\usage{
  gs_shares(id, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Lists the people that have access to a Gauge.
}
\note{
  Note that these examples only work if you provide your
  Gaug.es API key either by passing in the function, or
  storing your key in your .Rprofile file, defaults to
  looking for an entry of "GaugesKey".
}
\examples{
\dontrun{
gs_shares(id='4efd83a6f5a1f5158a000004')

# Get list of gauge's, then pass in one of the ids
out <- gs_gauge_list()
gs_shares(id=out$brief[6,1])
}
}


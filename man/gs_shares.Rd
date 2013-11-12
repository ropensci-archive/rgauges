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
\examples{
\dontrun{
# scotts data
gs_shares(id='4efd83a6f5a1f5158a000004')

# ropensci data
out <- gs_gauge_list(keyname='ropensciGaugesKey')
gs_shares(id=out$brief[6,1], keyname='ropensciGaugesKey')
}
}


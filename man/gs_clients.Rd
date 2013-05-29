\name{gs_clients}
\alias{gs_clients}
\title{Returns an array of your API clients.}
\usage{
  gs_clients(keyname = "GaugesKey")
}
\arguments{
  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Returns an array of your API clients.
}
\examples{
\dontrun{
# scotts data
gs_clients()

# ropensci data
gs_clients(keyname='ropensciGaugesKey')
}
}


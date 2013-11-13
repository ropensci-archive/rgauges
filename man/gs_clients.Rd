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
\note{
  Note that these examples only work if you provide your
  Gaug.es API key either by passing in the function, or
  storing your key in your .Rprofile file, defaults to
  looking for an entry of "GaugesKey".
}
\examples{
\dontrun{
# Default key name is GaugesKey
gs_clients()
}
}


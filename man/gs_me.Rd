\name{gs_me}
\alias{gs_me}
\title{Information on yourself.}
\usage{
  gs_me(keyname = "GaugesKey")
}
\arguments{
  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Information on yourself.
}
\note{
  Note that these examples only work if you provide your
  Gaug.es API key either by passing in the function, or
  storing your key in your .Rprofile file, defaults to
  looking for an entry of "GaugesKey".
}
\examples{
\dontrun{
gs_me()
}
}


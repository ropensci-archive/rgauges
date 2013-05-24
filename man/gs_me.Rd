\name{gs_me}
\alias{gs_me}
\title{Information on yourself}
\usage{
  gs_me(keyname = "GaugesKey")
}
\arguments{
  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Information on yourself
}
\examples{
\dontrun{
# scotts data
gs_me()

# ropensci data
gs_me("ropensciGaugesKey")
}
}


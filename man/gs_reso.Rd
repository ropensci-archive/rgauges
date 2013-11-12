\name{gs_reso}
\alias{gs_reso}
\title{Information on screen/browser resolutions}
\usage{
  gs_reso(id, date = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD. This works in a weird
  way. If you give no date, you get the traffic for each
  day since the beginning of the current month, but if you
  give a date, you get the traffic for each day for that
  entire month.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Information on screen/browser resolutions
}
\examples{
\dontrun{
# scotts data
gs_reso(id='4efd83a6f5a1f5158a000004')

# ropensci data
out <- gs_gauge_list(keyname='ropensciGaugesKey')
gs_reso(id=out$brief[6,1], keyname='ropensciGaugesKey')
}
}


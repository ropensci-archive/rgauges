\name{gs_reso}
\alias{gs_reso}
\title{Information on screen/browser resolutions}
\usage{
  gs_reso(id, date = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

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
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_reso(id=ro_id, keyname='ropensciGaugesKey')
}
}


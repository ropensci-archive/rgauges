\name{gs_engines}
\alias{gs_engines}
\title{Lists the people that have access to a Gauge.}
\usage{
  gs_engines(id, date = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Lists the people that have access to a Gauge.
}
\examples{
\dontrun{
# scotts data
gs_engines(id='4efd83a6f5a1f5158a000004')

# ropensci data
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_engines(id=ro_id, keyname='ropensciGaugesKey')
}
}


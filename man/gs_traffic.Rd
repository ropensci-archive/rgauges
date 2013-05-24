\name{gs_traffic}
\alias{gs_traffic}
\title{Traffic on a gauges ID}
\usage{
  gs_traffic(id, date = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Traffic on a gauges ID
}
\examples{
\dontrun{
# scotts data
gs_traffic(id='4efd83a6f5a1f5158a000004')

# ropensci data
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_traffic(id=ro_id, keyname='ropensciGaugesKey')
}
}


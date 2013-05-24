\name{gs_locations}
\alias{gs_locations}
\title{Information on locations}
\usage{
  gs_locations(id, date = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Information on locations
}
\examples{
\dontrun{
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_locations(id=ro_id, keyname='ropensciGaugesKey') # ropensci locations
}
}


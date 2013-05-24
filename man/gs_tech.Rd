\name{gs_tech}
\alias{gs_tech}
\title{Gets browsers and platforms for a gauge.}
\usage{
  gs_tech(id, date = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\value{
  list of two, browsers and platforms
}
\description{
  Gets browsers and platforms for a gauge.
}
\examples{
\dontrun{
# scotts data
gs_tech(id='4efd83a6f5a1f5158a000004')

# ropensci data
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_tech(id=ro_id, keyname='ropensciGaugesKey') # ropensci locations
}
}


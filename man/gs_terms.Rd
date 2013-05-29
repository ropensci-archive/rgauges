\name{gs_terms}
\alias{gs_terms}
\title{Gets search terms for a gauge, paginated.}
\usage{
  gs_terms(id, date = NULL, page = NULL,
    keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

  \item{page}{page to return}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Gets search terms for a gauge, paginated.
}
\examples{
\dontrun{
# scotts data
gs_terms(id='4efd83a6f5a1f5158a000004')

# ropensci data
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_terms(id=ro_id, keyname='ropensciGaugesKey')
}
}


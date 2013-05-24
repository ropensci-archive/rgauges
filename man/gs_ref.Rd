\name{gs_ref}
\alias{gs_ref}
\title{Information on referrers}
\usage{
  gs_ref(id, date = NULL, page = NULL,
    keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

  \item{page}{page to return}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Information on referrers
}
\examples{
\dontrun{
# scotts data
gs_ref(id='4efd83a6f5a1f5158a000004')

# ropensci data
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_ref(id=ro_id, keyname='ropensciGaugesKey') # ropensci referrers
}
}


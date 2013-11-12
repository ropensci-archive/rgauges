\name{gs_content}
\alias{gs_content}
\title{Gets top content for a gauge, paginated.}
\usage{
  gs_content(id, date = NULL, page = NULL,
    keyname = "GaugesKey")
}
\arguments{
  \item{id}{Your gaug.es id}

  \item{date}{Date format YYYY-MM-DD.}

  \item{page}{page to return}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Gets top content for a gauge, paginated.
}
\examples{
\dontrun{
# scotts data
gs_content(id='4efd83a6f5a1f5158a000004')
gs_content(id='4efd83a6f5a1f5158a000004', date="2013-11-01")

# ropensci data
out <- gs_gauge_list(keyname='ropensciGaugesKey')
gs_content(id=out$brief[6,1], keyname='ropensciGaugesKey')
}
}


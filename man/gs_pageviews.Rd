\name{gs_pageviews}
\alias{gs_pageviews}
\title{Gets top content for a gauge, paginated.}
\usage{
  gs_pageviews(id, fromdate = "today", todate = "today",
    keyname = "GaugesKey")
}
\arguments{
  \item{fromdate}{Date to get data from. Defaults to
  today.}

  \item{todate}{Date to get data to. Defaults to today.}

  \item{id}{Your gaug.es id}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Gets top content for a gauge, paginated.
}
\examples{
\dontrun{
# scotts data
gs_pageviews(id='4efd83a6f5a1f5158a000004')

# ropensci data
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
gs_pageviews(id=ro_id, keyname='ropensciGaugesKey')
}
}


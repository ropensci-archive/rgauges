\name{gs_list_gauges}
\alias{gs_list_gauges}
\title{List your gauges}
\usage{
  gs_list_gauges(keyname = "GaugesKey", page = NULL)
}
\arguments{
  \item{page}{Page to return.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  List your gauges
}
\examples{
\dontrun{
# scotts data
gs_list_gauges()

# ropensci data
ro_id <- gs_list_gauges(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
}
}


\name{gs_list}
\alias{gs_list}
\title{List your gauges}
\usage{
  gs_list(keyname = "GaugesKey", page = NULL)
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
gs_list()

# ropensci data
ro_id <- gs_list(keyname='ropensciGaugesKey')$gauges[[6]]$id # ropensci is gauge number 6
}
}


\name{vis_gauge.default}
\alias{vis_gauge.default}
\title{Visualize gauge analytics.}
\usage{
  vis_gauge.default(x)
}
\arguments{
  \item{x}{gauge S3 object}
}
\description{
  Visualize gauge analytics.
}
\examples{
\dontrun{
# get detail on the ropensci gauge
out <- gs_gauge_detail(id='500ebcf4613f5d79c700001c', keyname='ropensciGaugesKey')

# visualize
vis_gauge(x=out)
}
}


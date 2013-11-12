\name{vis_gauge}
\alias{vis_gauge}
\alias{vis_gauge.default}
\title{Plot a class of gauge}
\usage{
  vis_gauge(...)

  \method{vis_gauge}{default} (x, ...)
}
\arguments{
  \item{x}{Input, see examples}

  \item{...}{Additional parameters passed on to
  vis_gauge.default, not currenlty used}
}
\description{
  Plot a class of gauge
}
\examples{
\dontrun{
# get detail on the ropensci gauge
out <- gs_gauge_detail(id='500ebcf4613f5d79c700001c', keyname='ropensciGaugesKey')

# visualize
vis_gauge(x=out)

# scotts data
out <- gs_gauge_detail(id='4efd83a6f5a1f5158a000004')
vis_gauge(out)
}
}


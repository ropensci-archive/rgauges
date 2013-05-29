\name{gs_gauge_update}
\alias{gs_gauge_update}
\title{Updates and returns a gauge with the updates applied.}
\usage{
  gs_gauge_update(title = "foo_bar",
    tz = "Eastern Time (US & Canada)",
    allowed_hosts = NULL, keyname = "GaugesKey")
}
\arguments{
  \item{title}{Title of the gauge.}

  \item{tz}{The time zone that should be used for all
  date/time operations. See here
  \url{http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html}
  for reference.}

  \item{allowed_hosts}{Comma or space separated list of
  domains to accept tracking data from.}

  \item{keyname}{Your API key name in your .Rprofile file}
}
\description{
  Updates and returns a gauge with the updates applied.
}
\details{
  Note that you can create gaguges with the same names,
  beware.
}
\examples{
\dontrun{
gs_gauge_update(id='51a54191613f5d1a4b0000a7', title='foo_bar')
}
}


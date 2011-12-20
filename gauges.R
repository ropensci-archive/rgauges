## Gaug.es API for blogs/websites
require(rJava); require(RCurl); require(RJSONIO)

key <- getOption("GaugesKey")
basecall <- paste('curl -H', " '", 'X-Gauges-Token:', key, "' ", sep='')
myinfo <- 'https://secure.gaug.es/me'
clients <- 'https://secure.gaug.es/clients'
gauges <- 'https://secure.gaug.es/gauges'
content <- 'https://secure.gaug.es/gauges/:id/content'
referrers <- 'https://secure.gaug.es/gauges/:id/referrers'

# your information
me <- paste(basecall, myinfo, sep='')
meout <- system(me, intern=T)
fromJSON(meout)

# API client list
clientlist <- paste(basecall, clients, sep='')
clientlistout <- system(clientlist, intern=T)
fromJSON(clientlistout)

# Gauges list
gaugeslist <- paste(basecall, gauges, sep='')
gaugeslistout <- system(gaugeslist, intern=T)
fromJSON(gaugeslistout)

# Top content
topcontent <- paste(basecall, content, sep='')
topcontenttout <- system(topcontent, intern=T)
fromJSON(topcontenttout)

# Referrers
referrers_ <- paste(basecall, referrers, sep='')
referrers_out <- system(referrers_, intern=T)
fromJSON(referrers_out)

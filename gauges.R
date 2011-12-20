## Gaug.es API for blogs/websites
require(rJava); require(RCurl); require(RJSONIO)

# your information
me<-'curl -H "X-Gauges-Token: 6e57f116f7933ee6c4d76efcc213081b" https://secure.gaug.es/me'
meout <- system(me, intern=T)
fromJSON(meout)

# API client list
clientlist<-'curl -H "X-Gauges-Token: 6e57f116f7933ee6c4d76efcc213081b" https://secure.gaug.es/clients'
clientlistout <- system(clientlist, intern=T)
fromJSON(clientlistout)

# Gauges list
gaugeslist<-'curl -H "X-Gauges-Token: 6e57f116f7933ee6c4d76efcc213081b" https://secure.gaug.es/gauges'
gaugeslistout <- system(gaugeslist, intern=T)
fromJSON(gaugeslistout)

# Top content
topcontent<-'curl -H "X-Gauges-Token: 6e57f116f7933ee6c4d76efcc213081b" https://secure.gaug.es/gauges/:id/content'
topcontenttout <- system(topcontent, intern=T)
fromJSON(topcontenttout)

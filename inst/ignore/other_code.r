# content( GET(url=url, config=list(data=list(date=date), httpheader=paste0('X-Gauges-Token:',key))) )
# 
# # this works
# httpPOST(url, postfields="date=2013-05-26", httpHeader=c("X-Gauges-Token"="6e57f116f7933ee6c4d76efcc213081b"))
# 
# httpPOST(url=url, httpheader=c(`X-Gauges-Token`=key))
# 
# PUT(url=url,
#     config = list(httpheader=paste0('X-Gauges-Token:',key)),
#     body = c(date=date))
# 
# httpPOST(url, .opts = list(postfields = toJSON(list(date=date)),
#                            httpheader = c('X-Gauges-Token'=key)))
# 
# curlPerform(url = url, httpheader=c(paste0('X-Gauges-Token:',key), Accept="application/json"))

# getForm(url, date="2013-05-28", .opts=list(httpHeader="X-Gauges-Token:6e57f116f7933ee6c4d76efcc213081b"))


install.packages("RCurl", dependencies = TRUE)
install.packages("rjson", dependencies = TRUE)

library("RCurl")
library("rjson")

# Accept SSL certificates issued by public Certificate Authorities
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

h = basicTextGatherer()
hdr = basicHeaderGatherer()


req = list(
  
  Inputs = list(
    
    
    "input1" = list(
      "ColumnNames" = list("Account", "Date", "Channel", "Units", "nth minute", "value"),
      "Values" = list( list( "26812030018", "6/19/2014", "605106493 1 kWh", "kWh", "2.05", "0.54" ),  list( "26438261005", "2/8/2014 ", "605107806 1 kWh", "kWh", "2.35", "36.57" )  )
    )                ),
  GlobalParameters = setNames(fromJSON('{}'), character(0))
)

body = enc2utf8(toJSON(req))
api_key = "rVr/tzhw64+S+fQs1xYZFUZWCCwjFvnhH+4WCGgRmITz1DkCbvVs1/A5cOytze4j4OQNKc5JFiCiNP2gjyry/g==" # Replace this with the API key for the web service
authz_hdr = paste('Bearer', api_key, sep=' ')

h$reset()
curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/7a42d134b6c64c51b80b0f36259de4c0/services/8799f80617664c4c86130a5f882c402b/execute?api-version=2.0&details=true",
            httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
            postfields=body,
            writefunction = h$update,
            headerfunction = hdr$update,
            verbose = TRUE
)

headers = hdr$value()
httpStatus = headers["status"]
if (httpStatus >= 400)
{
  print(paste("The request failed with status code:", httpStatus, sep=" "))
  
  # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
  print(headers)
}

print("Result:")
result = h$value()
print(fromJSON(result))


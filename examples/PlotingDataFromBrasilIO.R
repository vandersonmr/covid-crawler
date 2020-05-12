# Example of how to gather data from Brasil IO API

# Documentation: https://github.com/turicas/covid19-br/blob/master/api.md

library("httr")
library("jsonlite")
library("rjson")
library("data.table")

base = 'https://brasil.io/api/dataset/covid19/caso_full/data/'
parameter = '?page_size=10000'

url <- paste(base, parameter, sep='')

request <- GET(url)
response <- content(request, 'text', type='application/json', encoding = 'UTF-8')
json_data <- fromJSON(response)

data_registries <- json_data['count'] 
data_results <- json_data['results']

value_registries <- data_registries[['count']]
node_results <- data_results[['results']]

table_results <- rbindlist(node_results, use.names = TRUE)


library("httr")
library("jsonlite")
library("rjson")
library("data.table")
library('googleVis')


base = 'https://bigdata-api.fiocruz.br/numero/casos/pais/'
endpoint = 'Brasil'

url <- paste(base, endpoint, sep='')

request <- GET(url)
response <- content(request, 'text', type='application/json', encoding = 'UTF-8')
json_data <- fromJSON(response)

data_total_deaths <- json_data['total_mortes']
data_total_cases <- json_data['total_casos']
data_daily_details <- json_data['detalhes_por_dia']

value_total_deaths <- data_total_deaths[['total_mortes']]
value_total_cases <- data_total_cases[['total_casos']]
node_daily_details1 <- data_daily_details[['detalhes_por_dia']]

table_daily_details1 <- rbindlist(node_daily_details1, use.names = TRUE)

graph <- gvisLineChart(table_daily_details1, xvar='date', yvar=c('new_cases', 'new_deaths'))
plot(graph)


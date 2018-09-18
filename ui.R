library(shiny)
library(leaflet)
library(markdown)


shinyUI(fluidPage(
  tagList(
        navbarPage("Japan Hostel Application",
                   tabPanel("Map", headerPanel(h3("Mapping")),
                            tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
                            leafletOutput("map")),
                   tabPanel("Data Table", 
                            dataTableOutput("table")),
                   tabPanel("Plot",
                            plotOutput("plot1"),
                            uiOutput("All"))
                   ))
        
)
)

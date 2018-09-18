library(shiny)
library(tidyverse)
library(plotly)
library(tidyquant)

hostel <- read.csv("~/Desktop/shinylearn/leaflet/Hostel.csv")
hostel <- hostel[,-1]

colnames(hostel) <- c("Hostel Name", "City", "Price", "Distance", "Summary Score", "Rating Band", "Atmosphere", "Cleanliness", "Facilities", "Location", "Security", "Staff", "Value for Money", "lon", "lat")


rating <- select(hostel, c("Summary Score", "Atmosphere", "Cleanliness", "Facilities", "Location", "Security", "Staff", "Value for Money", "City"))




shinyServer(function(input, output){

  output$map <- renderLeaflet({
    leaflet(hostel) %>%
      #set the view for Japan 
      setView(lng = 138.2529, lat = 36.2048, zoom = 5) %>%
      addTiles() %>%
      addMarkers(clusterOptions = markerClusterOptions(),
                 lng = hostel$lon,
                 lat = hostel$lat, 
                 label = hostel$hostel.name)
  })
  
  output$table <- renderDataTable({
    hostel
  })
  
  output$All <- renderUI({
    tagList(
      selectInput("select", label = h4("Rating"),
                  names(rating))
      
    )
  })
  
  Data <- reactive({rating[, c(input$select)]})
  
  
  
  output$plot1 <- renderPlot({
    
   ggplot(rating, aes(x = City, y = Data(), fill = City)) +
      geom_boxplot() +
      labs(title = input$select,
           x = "City",
          y = "Rating") +
      theme(text = element_text(size = 18))
   
  })

  
})




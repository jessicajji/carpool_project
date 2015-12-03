library(shiny)
library(ggplot2)
library(ggmap)
library(rjson)
library(carpoolApi)
library(lubridate)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  moves <- getAllMoves()
  moves <- as.data.frame(moves)
  moves$Latitude = as.numeric(as.character(moves$Latitude))
  moves$Longitude =  as.numeric(as.character(moves$Longitude))
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should
  #     re-execute automatically when inputs change
  #  2) Its output type is a plot
  
  moves <- moves[29:nrow(moves), ]
  moves$Date <- mdy(moves$Date)
  
  
  mapgilbert <- get_map(location = c(lon = mean(moves$Longitude), lat = mean(moves$Latitude)), zoom = 13, scale = 2)
  output$distPlot <- renderPlot({
    
    moves <- moves[moves$Date >= ymd(input$dates[1]) & moves$Date <= ymd(input$dates[2]), ]
    
    ggmap(mapgilbert) + geom_point(data = moves, aes(x = Longitude, y = Latitude), color = "red", fill = "red", alpha = 0.8, size = 2, shape = 21) + guides(fill=FALSE, alpha=FALSE, size=FALSE)
    
    
    
  })
  
  output$value <- renderPrint({ input$dates })
})
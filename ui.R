# ui.R

shinyUI(fluidPage(
  titlePanel("Carpool Project"), 
  h5(em("Visualizing a month of location-based moves data")), br(),
  
  sidebarLayout(
    sidebarPanel(h4("Filter"),
                 #sliderInput("dates", label = h5("Days of data displayed"), min = 0, max = 30, value = 30),
                 #selectInput("select", label = h5("Users shown"), 
                 #           choices = list("Vivek" = 1), selected = 1),
                 # Copy the line below to make a date range selector
                 dateRangeInput("dates", label = h3("Date range")),
                 
                 hr()
                 #,
                 #fluidRow(column(4, verbatimTextOutput("value")))
    ),
    mainPanel(plotOutput("distPlot"))
    
  )
))
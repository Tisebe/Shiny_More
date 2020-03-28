library(shiny)

#Define UI

library(maps)
library(mapproj)

source("C:/Users/Tony Isebe/Desktop/App-1/Shiny_More/census-app/helpers.R")
counties <- readRDS("C:/Users/Tony Isebe/Desktop/App-1/Shiny_More/census-app/data/counties.rds")


ui <- fluidPage(
  titlePanel('censusVis'),
  
  sidebarLayout(
    
    sidebarPanel(
      
      helpText('Create demographic maps with 
               information from the 2010 US Census.'),
      
      selectInput('var',
                  label = 'Choose a variable to display.',
                  choices = list('Percent White',
                                 'Percent Black',
                                 'Percent Hispanic',
                                 'Percent Asian'),
                  selected = 'Percent White'),
      sliderInput('range',
                  label = 'Range of Interest:',
                  min = 0, max = 100, value = c(0,100))
      
    ),
    mainPanel(plotOutput("map"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    args <- switch(input$var,
                   "Percent White" = list(counties$white, "darkgreen", "% White"),
                   "Percent Black" = list(counties$black, "black", "% Black"),
                   "Percent Hispanic" = list(counties$hispanic, "darkorange", "% Hispanic"),
                   "Percent Asian" = list(counties$asian, "darkviolet", "% Asian"))
    
    args$min <- input$range[1]
    args$max <- input$range[2]
    
    do.call(percent_map, args)
  })
}

# Run app ----
shinyApp(ui, server)
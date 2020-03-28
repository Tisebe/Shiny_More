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
    data <- switch(input$var,
                   'Percent White'=counties$white,
                   'Percent Black'=counties$black,
                   'Percent Hispanic'=counties$hispanic,
                   'Percent Asian'=counties$asian)
    
    color <- switch(input$var,
                    'Percent White'='darkgreen',
                    'Percent Black'='black',
                    'Percent Hispanic'='darkorange',
                    'Percent Asian'='darkviolet')
    legend <- switch(input$var,
                     'Percent White'='%White',
                     'Percent Black'='%Black',
                     'Percent Hispanic'='%Hispanic',
                     'Percent Asian'='%Asian')
    percent_map(data, color, legend, input$range[1], input$range[2])
  })
}

# Run app ----
shinyApp(ui, server)
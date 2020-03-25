library(shiny)

#Define UI

ui <- fluidPage(
  
  titlePanel('Basic Widgets'),
  
  fluidRow(
    
    column(3,
           h3('Buttons'),
           actionButton('action', label = 'Action'),
           br(),
           br(),
           submitButton('Submit')),
    
    column(3,
          h3('Single checkbox'),
          checkboxInput('checkinbox','Choice A', value = TRUE)),
    column(3,
           checkboxGroupInput('checkGroup',
                              h3('Checkbox group'),
                              choices = list('Choice 1'=1,
                                             'Choice 2'=2,
                                             'Choice 3'=3),
                              selected = 1)),
    column(3,
           dateInput('date',
                     h3('Date input'),
                     value = '2014-01-01'))
  ),
  
fluidRow(
  
  column(3,
         dateRangeInput('dates', h3('Date range'))),
  column(3,
         fileInput('file', h3('File input'))),
  column(3,
         numericInput('num',
                      h3('Numeric input'),
                      value = 1))
),

fluidRow(
  column(3,
         radioButtons('radio', h3('Select box'),
                      choices = list('Choice 1'=1, 'Choice 2'=2,
                                     'Choice 3'=3), selected = 1)),
  column(3,
         textInput('text', h3('Text input'),
                   value = 'Enter text'))
)
)

#Define server logic

server <- function(input, output) {
  
}


#Run the app

shinyApp(ui=ui, server = server)
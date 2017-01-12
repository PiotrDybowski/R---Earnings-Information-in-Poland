library(shiny)
library(shinythemes)
shinyUI(fluidPage(
  theme = shinytheme("superhero"),
  
  titlePanel(title = "Earnings Information in Poland"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload a data file"),
      helpText("The file can have a maximum of 5MB!"),
      br(),
      h6("Select the read.table parameters below"),
      checkboxInput(
        inputId = 'header',
        label = 'Header',
        value = FALSE
      ),
      br(),
      radioButtons(
        inputId = 'sep',
        label = 'Separator',
        choices = c(
          Comma = ',',
          Semicolon = ';',
          Tab = '\t',
          Space = ''
        ),
        selected = ','
      )
    ),
    mainPanel(uiOutput("tb"))
  )
  
))

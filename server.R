library(shiny)
library(leaflet)
library(knitr)
library(maps)
library(markdown)

lokalizacje <-
  read.csv("/Users/piotrdybowski/Desktop/Projekt R/Location.csv", sep = ",")
shinyServer(function(input, output) {
  
  showModal(modalDialog(
    title = "ShinyApp",
    HTML(
      '<center><img src="DybosAppPresents.png" width="400"></center>'
    ),
    HTML(
      "<center><h3>ShinyApp - Earnings Information in Poland</center>"
    ),
    HTML(
      '<center>Powered by<img src="MyPhoto.png" width="200"></center>'
    ),
    HTML(
      '<center>© DYBOS APPS 2017 ALL RIGHTS RESERVED<img src="no-photo.png" width="100"></center>'
    ),
    easyClose = FALSE,
    footer = modalButton("Close")
  ))
  
  
  data <- reactive({
    file1 <- input$file
    if (is.null(file1)) {
      return()
    }
    read.table(
      file = file1$datapath,
      sep = input$sep,
      header = input$header
    )
  })
  
  output$filedf <- renderTable({
    if (is.null(data())) {
      return ()
    }
    input$file
  })
  
  output$sum <- renderTable({
    if (is.null(data())) {
      return ()
    }
    summary(data())
    
  })
  
  output$table <- renderTable({
    if (is.null(data())) {
      return ()
    }
    data()
  })
  output$myhist <- renderPlot({
    
    colm <- data$Salary
    
    hist(colm)
    
  })
  
  
  
  output$markdown <- renderUI({
    includeMarkdown("/Users/piotrdybowski/Desktop/Projekt R/R-Markdown.Rmd")
   })
  
  
  mapStates = map("world", "poland", fill = TRUE, plot = FALSE)
  l <- leaflet(data = mapStates)
  l <- addTiles(l)
  
  for (r in 1:6) {
    l <- addMarkers(l,
                 lng = lokalizacje[r, 2],
                 lat = lokalizacje[r, 1],
                 popup = lokalizacje[r, 3])
  }
  l <- addPolygons(l,
                fillColor = topo.colors(n = 100, alpha = 0.5),
                stroke = NULL)
  l <- addProviderTiles(l, "Stamen.Toner", group = "Toner")
  output$mapa <- renderLeaflet(l)
  
  output$tb <- renderUI({
    if (is.null(data()))
      h1("No data")
    else
      tabsetPanel(
        tabPanel("About file", tableOutput("filedf")),
        tabPanel("Data", tableOutput("table")),
        tabPanel("Summary", tableOutput("sum")),
        tabPanel("MarkDown", tableOutput("markdown")),
        tabPanel("Maps", leafletOutput('mapa', width = 1000, height = 800))
      )
  })
  
})
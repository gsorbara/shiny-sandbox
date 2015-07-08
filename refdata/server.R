library(shiny)
library(faosws)

# Define a server for the Shiny app
shinyServer(function(input, output, session) {
  
  selectedDomain <- reactive({ 
    if (input$domain != "") {
      try(faosws::GetDatasetNames(input$domain),silent = TRUE)
    }
  })
  
  selectedDataset <- reactive({
    if (input$domain != "" && input$dataset != "" ) {
      try(faosws::GetDatasetConfig(input$domain,input$dataset)[["dimensions"]],silent = TRUE)
    }
  })
  
  observe({
    #print(selectedDomain())
    try(updateSelectInput(session, "dataset", choices = c("", selectedDomain()),selected=1),silent=TRUE)
  })
  
  observe({
    #print(selectedDataset())
    try(updateSelectInput(session, "dimension", choices = c("", selectedDataset()),selected=1),silent=TRUE)
  })
  
#   observe({
#     domain <- input$domain
#     
#     print("OBS 1")
#     print(domain)
#     print(dataset)
#     print("SBO 1")
#     
#     if (domain != "" && dataset == "") {
#       datasets = faosws::GetDatasetNames(domain)
#       updateSelectInput(session, "dataset", choices = c("", datasets),selected=1)
#       updateSelectInput(session, "dimension", choices = c(""))
#     }
#   })
#   
#   output$dataset <- 
# 
#   observe({
#     dataset <- input$dataset
#     domain <- input$domain
#     
#     print("OBS 2")
#     print(domain)
#     print(dataset)
#     print("SBO 2")
#     
# #     
# #     if (dataset != " " &&  dataset != " ") {
# #       #dimensions = faosws::GetDatasetConfig(input$domain,dataset)[["dimensions"]]
# #       #updateSelectInput(session, "dimension", choices = c("  ", dimensions),selected=1)
# #     }
#   })

  
})

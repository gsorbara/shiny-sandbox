library(shiny)
library(faosws)

# Define a server for the Shiny app
shinyServer(function(input, output, session) {

  observe({
    domainSelected <- input$domain
    try(updateSelectInput(session, "dataset", choices = c(""),selected=1),silent=TRUE)
    try(updateSelectInput(session, "dimension", choices = c(""),selected=1),silent=TRUE)

    if (domainSelected != "") {
      datasetList <- try(faosws::GetDatasetNames(domainSelected),silent = TRUE)
      try(updateSelectInput(session, "dataset", choices = c("",datasetList),selected=1),silent=TRUE)
      print(datasetList)
    }
  })
  
  observe({
    datasetSelected <- input$dataset

    isolate ({
      domainSelected <- input$domain
      if (domainSelected != "" && datasetSelected != "") {
        dimensionList <- faosws::GetDatasetConfig(input$domain,datasetSelected)[["dimensions"]]
        try(updateSelectInput(session, "dimension", choices = c("",dimensionList),selected=1),silent=TRUE)
        print(dimensionList)
      }
    })
  })
  
  observe({
    input$showData
    isolate({
      domainSelected <- input$domain
      datasetSelected <- input$dataset
      dimensionSelected <- input$dimension
      if (domainSelected != "" && datasetSelected != "" && dimensionSelected != "") {
        output$refDataLabel <- renderPrint(paste(domainSelected,datasetSelected,dimensionSelected,sep = ":"))
        refData <- faosws::GetCodeList(domainSelected,datasetSelected,dimensionSelected)
        output$refData <- renderDataTable(refData)
      } 
    })
  })
})

library(shiny)
library(faosws)

# Define the overall UI
shinyUI(
  fluidPage(
    titlePanel("Reference Data Browser"),
    
    sidebarLayout(
      sidebarPanel(
        selectInput("domain","Domain",c("",faosws::GetDomainNames())),
        selectInput("dataset","Dataset",c("")),
        selectInput("dimension","Dimension",c("")),
        actionButton("showData","Show data")
      ),
      mainPanel(
        h4("Reference data"),
        verbatimTextOutput("refDataLabel"),
        dataTableOutput('refData')
      )
    )
  )  
)

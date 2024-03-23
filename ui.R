ui <- fluidPage(
  titlePanel("Data Exploration Tool"),
  sidebarLayout(
    sidebarPanel(
      selectInput("choice","Please select the type of document that you will uplaod: ",choices = c("xlsx","csv")),
      fileInput("file", "Upload your file: "),
      
      
      uiOutput("select_vars"),
      uiOutput("filter_vars")
    ),
    mainPanel(
      plotOutput("plot"),
      dataTableOutput("table")
    )
  )
)

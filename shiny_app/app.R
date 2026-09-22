library(shiny)

invoices <- read.csv(
  "https://raw.githubusercontent.com/Data-And-Stats-Course-Hub/ITAO-20200/main/Data/procurement_invoices.csv"
)

ui <- fluidPage(
  
  titlePanel("Procurement Invoice Random Sample"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput(
        "n",
        "Sample size:",
        value = 50,
        min = 1,
        max = nrow(invoices)
      ),
      
      actionButton(
        "sample",
        "Generate Random Sample"
      ),
      
      downloadButton(
        "download",
        "Download Sample"
      )
    ),
    
    mainPanel(
      textOutput("sample_info"),
      tableOutput("sample_table")
    )
  )
)

server <- function(input, output) {
  
  sampled_data <- eventReactive(input$sample, {
    invoices[
      sample(nrow(invoices), input$n),
    ]
  })
  
  output$sample_info <- renderText({
    req(sampled_data())
    
    paste(
      "Your random sample contains",
      nrow(sampled_data()),
      "invoices."
    )
  })
  
  output$sample_table <- renderTable({
    req(sampled_data())
    head(sampled_data(), 10)
  })
  
  output$download <- downloadHandler(
    filename = function() {
      paste0("invoice_sample_", input$n, ".csv")
    },
    
    content = function(file) {
      write.csv(
        sampled_data(),
        file,
        row.names = FALSE
      )
    }
  )
}

shinyApp(ui = ui, server = server)

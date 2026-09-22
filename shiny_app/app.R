library(shiny)

# ============================================================
# READ THE POPULATION
# ============================================================

invoices <- read.csv(
  "https://raw.githubusercontent.com/Data-And-Stats-Course-Hub/ITAO-20200/main/Data/procurement_invoices.csv"
)


# ============================================================
# SETTINGS FOR THE ACTIVITY
# ============================================================

sample_size <- 50
confidence_level <- 0.95


# ============================================================
# IDENTIFY THE INVOICE AMOUNT VARIABLE
# ============================================================

# CHANGE THIS to the actual name of the invoice amount column
amount_variable <- "invoices"


# ============================================================
# USER INTERFACE
# ============================================================

ui <- fluidPage(
  
  titlePanel("Repeated Random Samples: Confidence Intervals"),
  
  h3("Estimate the Population Mean"),
  
  p(
    "You will repeatedly take a random sample of 50 invoices "
    ,"from the population and calculate a 95% confidence interval "
    ,"for the population mean invoice amount."
  ),
  
  p(
    strong("Your goal: "),
    "See how the confidence intervals change from sample to sample."
  ),
  
  hr(),
  
  actionButton(
    "sample",
    "Take a New Random Sample",
    class = "btn-primary"
  ),
  
  br(),
  br(),
  
  h4("Current Random Sample"),
  
  textOutput("sample_number"),
  
  textOutput("sample_mean"),
  
  br(),
  
  h4("95% Confidence Interval"),
  
  textOutput("confidence_interval"),
  
  br(),
  
  tableOutput("sample_table"),
  
  hr(),
  
  h4("Confidence Intervals from Your Samples"),
  
  tableOutput("results_table")
)


# ============================================================
# SERVER
# ============================================================

server <- function(input, output) {
  
  # Store results from all samples taken during this session
  results <- reactiveVal(
    data.frame(
      Sample = integer(),
      Sample_Mean = numeric(),
      Lower = numeric(),
      Upper = numeric()
    )
  )
  
  
  # ----------------------------------------------------------
  # Generate a new sample whenever the button is clicked
  # ----------------------------------------------------------
  
  sampled_data <- eventReactive(input$sample, {
    
    # Random sample of 50 invoices
    sample_indices <- sample(
      nrow(invoices),
      size = sample_size,
      replace = FALSE
    )
    
    invoices[sample_indices, ]
    
  })
  
  
  # ----------------------------------------------------------
  # Calculate the confidence interval
  # ----------------------------------------------------------
  
  observeEvent(input$sample, {
    
    data <- sampled_data()
    
    # Extract the invoice amounts
    x <- data[[amount_variable]]
    
    # Remove missing values, if any
    x <- x[!is.na(x)]
    
    # Sample statistics
    n <- length(x)
    xbar <- mean(x)
    s <- sd(x)
    
    # Standard error
    se <- s / sqrt(n)
    
    # Critical value for a t interval
    critical_value <- qt(
      1 - (1 - confidence_level) / 2,
      df = n - 1
    )
    
    # Margin of error
    margin_of_error <- critical_value * se
    
    # Confidence interval
    lower <- xbar - margin_of_error
    upper <- xbar + margin_of_error
    
    # Add the new result to the results table
    old_results <- results()
    
    new_result <- data.frame(
      Sample = nrow(old_results) + 1,
      Sample_Mean = xbar,
      Lower = lower,
      Upper = upper
    )
    
    results(
      rbind(
        old_results,
        new_result
      )
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Display sample number
  # ----------------------------------------------------------
  
  output$sample_number <- renderText({
    
    req(sampled_data())
    
    paste(
      "Sample size:",
      nrow(sampled_data())
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Display sample mean
  # ----------------------------------------------------------
  
  output$sample_mean <- renderText({
    
    req(sampled_data())
    
    x <- sampled_data()[[amount_variable]]
    x <- x[!is.na(x)]
    
    paste(
      "Sample mean:",
      dollar(mean(x))
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Display confidence interval
  # ----------------------------------------------------------
  
  output$confidence_interval <- renderText({
    
    current_results <- results()
    
    req(nrow(current_results) > 0)
    
    current <- current_results[nrow(current_results), ]
    
    paste(
      "95% CI:",
      dollar(current$Lower),
      "to",
      dollar(current$Upper)
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Display first 10 observations from current sample
  # ----------------------------------------------------------
  
  output$sample_table <- renderTable({
    
    req(sampled_data())
    
    head(sampled_data(), 10)
    
  })
  
  
  # ----------------------------------------------------------
  # Display all confidence intervals generated so far
  # ----------------------------------------------------------
  
  output$results_table <- renderTable({
    
    current_results <- results()
    
    req(nrow(current_results) > 0)
    
    display_results <- current_results
    
    display_results$Sample_Mean <- dollar(
      display_results$Sample_Mean
    )
    
    display_results$Lower <- dollar(
      display_results$Lower
    )
    
    display_results$Upper <- dollar(
      display_results$Upper
    )
    
    names(display_results) <- c(
      "Sample",
      "Sample Mean",
      "Lower Limit",
      "Upper Limit"
    )
    
    display_results
    
  })
  
}


# ============================================================
# RUN THE APP
# ============================================================

shinyApp(
  ui = ui,
  server = server
)

library(shiny)

# ============================================================
# READ THE POPULATION
# ============================================================

invoices <- read.csv(
  "https://raw.githubusercontent.com/Data-And-Stats-Course-Hub/ITAO-20200/main/Data/procurement_invoices.csv"
)


# ============================================================
# SETTINGS
# ============================================================

sample_size <- 50
confidence_level <- 0.95

# IMPORTANT:
# Replace this with the actual name of the invoice amount column.
amount_variable <- "invoices"


# ============================================================
# USER INTERFACE
# ============================================================

ui <- fluidPage(
  
  titlePanel("Repeated Random Samples: Confidence Intervals"),
  
  h3("Estimate the Population Mean"),
  
  p(
    "Take repeated random samples of 50 invoices and "
    ,"calculate a 95% confidence interval for the population "
    ,"mean invoice amount."
  ),
  
  p(
    strong("Goal: "),
    "See how the confidence intervals change from sample to sample."
  ),
  
  hr(),
  
  actionButton(
    "sample",
    "Take a New Random Sample"
  ),
  
  br(),
  br(),
  
  h4("Current Sample"),
  
  textOutput("sample_number"),
  
  textOutput("sample_mean"),
  
  br(),
  
  h4("95% Confidence Interval"),
  
  textOutput("confidence_interval"),
  
  br(),
  
  h4("Your Samples"),
  
  tableOutput("results_table")
)


# ============================================================
# SERVER
# ============================================================

server <- function(input, output, session) {
  
  # Store results from all samples
  results <- reactiveVal(
    data.frame(
      Sample = integer(),
      Sample_Mean = numeric(),
      Lower = numeric(),
      Upper = numeric()
    )
  )
  
  
  # ----------------------------------------------------------
  # Take a random sample
  # ----------------------------------------------------------
  
  sampled_data <- eventReactive(input$sample, {
    
    invoices[
      sample(
        nrow(invoices),
        size = sample_size,
        replace = FALSE
      ),
    ]
    
  })
  
  
  # ----------------------------------------------------------
  # Calculate confidence interval
  # ----------------------------------------------------------
  
  observeEvent(input$sample, {
    
    data <- sampled_data()
    
    # Get invoice amounts
    x <- data[[amount_variable]]
    
    # Remove missing values
    x <- x[!is.na(x)]
    
    # Sample size
    n <- length(x)
    
    # Sample mean
    xbar <- mean(x)
    
    # Sample standard deviation
    s <- sd(x)
    
    # Standard error
    se <- s / sqrt(n)
    
    # t critical value
    critical_value <- qt(
      1 - (1 - confidence_level) / 2,
      df = n - 1
    )
    
    # Margin of error
    margin_of_error <- critical_value * se
    
    # Confidence interval
    lower <- xbar - margin_of_error
    upper <- xbar + margin_of_error
    
    # Previous results
    old_results <- results()
    
    # New result
    new_result <- data.frame(
      Sample = nrow(old_results) + 1,
      Sample_Mean = xbar,
      Lower = lower,
      Upper = upper
    )
    
    # Save result
    results(
      rbind(
        old_results,
        new_result
      )
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Sample information
  # ----------------------------------------------------------
  
  output$sample_number <- renderText({
    
    req(sampled_data())
    
    paste(
      "Sample size:",
      nrow(sampled_data())
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Sample mean
  # ----------------------------------------------------------
  
  output$sample_mean <- renderText({
    
    req(sampled_data())
    
    x <- sampled_data()[[amount_variable]]
    
    x <- x[!is.na(x)]
    
    paste(
      "Sample mean: $",
      format(
        mean(x),
        big.mark = ",",
        digits = 2,
        nsmall = 2
      )
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Confidence interval
  # ----------------------------------------------------------
  
  output$confidence_interval <- renderText({
    
    current_results <- results()
    
    req(nrow(current_results) > 0)
    
    current <- current_results[
      nrow(current_results),
    ]
    
    paste(
      "95% CI: $",
      format(
        current$Lower,
        big.mark = ",",
        digits = 2,
        nsmall = 2
      ),
      "to $",
      format(
        current$Upper,
        big.mark = ",",
        digits = 2,
        nsmall = 2
      )
    )
    
  })
  
  
  # ----------------------------------------------------------
  # Display all intervals
  # ----------------------------------------------------------
  
  output$results_table <- renderTable({
    
    current_results <- results()
    
    req(nrow(current_results) > 0)
    
    display_results <- current_results
    
    display_results$Sample_Mean <- paste0(
      "$",
      format(
        display_results$Sample_Mean,
        big.mark = ",",
        digits = 2,
        nsmall = 2
      )
    )
    
    display_results$Lower <- paste0(
      "$",
      format(
        display_results$Lower,
        big.mark = ",",
        digits = 2,
        nsmall = 2
      )
    )
    
    display_results$Upper <- paste0(
      "$",
      format(
        display_results$Upper,
        big.mark = ",",
        digits = 2,
        nsmall = 2
      )
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
# RUN APP
# ============================================================

shinyApp(
  ui = ui,
  server = server
)

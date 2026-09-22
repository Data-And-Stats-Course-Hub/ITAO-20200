library(shiny)

# ---------------------------------------------------------
# LOAD DATA
# ---------------------------------------------------------

invoices <- read.csv(
  "https://raw.githubusercontent.com/Data-And-Stats-Course-Hub/ITAO-20200/main/Data/procurement_invoices.csv",
  stringsAsFactors = FALSE
)

# Check that the invoice column exists
if (!"invoices" %in% names(invoices)) {
  stop("The column 'invoices' was not found in the data.")
}

# Extract invoice amounts
invoice_amounts <- invoices[["invoices"]]

# Clean and convert to numeric
invoice_amounts <- as.character(invoice_amounts)
invoice_amounts <- gsub(",", "", invoice_amounts)
invoice_amounts <- gsub("\\$", "", invoice_amounts)

invoice_amounts <- suppressWarnings(
  as.numeric(invoice_amounts)
)

# Keep only valid numeric values
invoice_amounts <- invoice_amounts[
  is.finite(invoice_amounts)
]


# ---------------------------------------------------------
# USER INTERFACE
# ---------------------------------------------------------

ui <- fluidPage(
  
  # -------------------------------------------------------
  # CUSTOM CSS
  # -------------------------------------------------------
  
  tags$head(
    tags$style(HTML("

      body {
        background-color: #f5f7fa;
        font-family: Arial, sans-serif;
        color: #333333;
      }

      .hero {
        background: linear-gradient(135deg, #0b2e59, #174a7c);
        color: white;
        padding: 30px 35px;
        border-radius: 10px;
        margin-bottom: 25px;
        box-shadow: 0 3px 8px rgba(0,0,0,0.15);
      }

      .hero h1 {
        margin-top: 0;
        font-size: 32px;
        font-weight: 700;
      }

      .hero p {
        font-size: 17px;
        margin-bottom: 0;
        line-height: 1.5;
      }

      .info-box {
        background-color: white;
        border-left: 6px solid #174a7c;
        padding: 20px 25px;
        margin-bottom: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
      }

      .info-box h4 {
        margin-top: 0;
        color: #0b2e59;
        font-weight: 700;
      }

      .step {
        margin-bottom: 12px;
        line-height: 1.5;
      }

      .card {
        background-color: white;
        padding: 22px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
      }

      .card h3 {
        margin-top: 0;
        color: #0b2e59;
      }

      .sample-button {
        background-color: #174a7c;
        color: white;
        border: none;
        width: 100%;
        padding: 13px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 6px;
        margin-top: 10px;
      }

      .sample-button:hover {
        background-color: #0b2e59;
        color: white;
      }

      .reset-button {
        background-color: #6c757d;
        color: white;
        border: none;
        width: 100%;
        padding: 11px;
        font-size: 15px;
        border-radius: 6px;
        margin-top: 10px;
      }

      .reset-button:hover {
        background-color: #545b62;
        color: white;
      }

      .result-box {
        background-color: #f1f6fb;
        border-radius: 8px;
        padding: 18px;
        margin-bottom: 15px;
        text-align: center;
      }

      .result-label {
        font-size: 14px;
        color: #555555;
        margin-bottom: 5px;
      }

      .result-value {
        font-size: 25px;
        font-weight: 700;
        color: #0b2e59;
      }

      .ci-value {
        font-size: 22px;
        font-weight: 700;
        color: #174a7c;
      }

      .sample-number {
        font-size: 16px;
        color: #555555;
        margin-bottom: 15px;
      }

      .plot-container {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
      }

      .plot-container h3 {
        margin-top: 0;
        color: #0b2e59;
      }

      .table-container {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
      }

      .table-container h3 {
        margin-top: 0;
        color: #0b2e59;
      }

    "))
  ),
  
  
  # -------------------------------------------------------
  # HERO
  # -------------------------------------------------------
  
  div(
    class = "hero",
    
    h1("CaterCo Invoice Audit"),
    
    p(
      "Can a random sample of invoices help you evaluate CaterCo's claim ",
      "that the average event costs $750?"
    )
  ),
  
  
  # -------------------------------------------------------
  # HOW THIS WORKS
  # -------------------------------------------------------
  
  div(
    class = "info-box",
    
    h4("How this works"),
    
    div(
      class = "step",
      
      strong("1. Start with the population. "),
      
      "The population is all of CaterCo's invoices from the past six months. ",
      "The true average cost of all those invoices is the population mean, ",
      "but that value is unknown to you."
    ),
    
    div(
      class = "step",
      
      strong("2. Take a random sample. "),
      
      "Instead of analyzing every invoice, you will randomly select a sample ",
      "of invoices from the population."
    ),
    
    div(
      class = "step",
      
      strong("3. Calculate the sample mean. "),
      
      "Your sample gives you an estimate of the population mean. ",
      "However, a different random sample could produce a different sample mean."
    ),
    
    div(
      class = "step",
      
      strong("4. Build a confidence interval. "),
      
      "The confidence interval uses your sample to create a range of plausible ",
      "values for the unknown population mean."
    ),
    
    div(
      class = "step",
      
      strong("5. Repeat the process. "),
      
      "Each time you click ",
      
      strong("Take a Random Sample"),
      
      ", you get a new random sample, a new sample mean, ",
      "and a new confidence interval."
    ),
    
    div(
      class = "step",
      
      strong("Your goal: "),
      
      "Watch how the intervals change from sample to sample. ",
      "Then investigate what happens when you change the sample size ",
      "and confidence level."
    ),
    
    div(
      class = "step",
      
      strong("Remember: "),
      
      "The confidence level describes the long-run performance of the ",
      "sampling-and-interval process. It is not the probability that one ",
      "particular interval contains the population mean."
    )
  ),
  
  
  # -------------------------------------------------------
  # CONTROLS
  # -------------------------------------------------------
  
  fluidRow(
    
    column(
      width = 4,
      
      div(
        class = "card",
        
        h3("Choose your settings"),
        
        numericInput(
          inputId = "sample_size",
          label = "Sample size (n):",
          value = 50,
          min = 2,
          max = min(1000, length(invoice_amounts)),
          step = 10
        ),
        
        selectInput(
          inputId = "confidence_level",
          label = "Confidence level:",
          choices = c(
            "80%" = 0.80,
            "90%" = 0.90,
            "95%" = 0.95,
            "98%" = 0.98,
            "99%" = 0.99
          ),
          selected = 0.95
        ),
        
        actionButton(
          inputId = "sample",
          label = "Take a Random Sample",
          class = "sample-button"
        ),
        
        actionButton(
          inputId = "reset",
          label = "Start Over",
          class = "reset-button"
        )
      )
    ),
    
    
    # -----------------------------------------------------
    # CURRENT SAMPLE RESULTS
    # -----------------------------------------------------
    
    column(
      width = 8,
      
      div(
        class = "card",
        
        h3("Current Sample"),
        
        div(
          class = "sample-number",
          
          textOutput("sample_number")
        ),
        
        fluidRow(
          
          column(
            width = 4,
            
            div(
              class = "result-box",
              
              div(
                class = "result-label",
                "Sample Mean"
              ),
              
              div(
                class = "result-value",
                
                textOutput("sample_mean")
              )
            )
          ),
          
          column(
            width = 4,
            
            div(
              class = "result-box",
              
              div(
                class = "result-label",
                "Margin of Error"
              ),
              
              div(
                class = "result-value",
                
                textOutput("margin_error")
              )
            )
          ),
          
          column(
            width = 4,
            
            div(
              class = "result-box",
              
              div(
                class = "result-label",
                "Confidence Interval"
              ),
              
              div(
                class = "ci-value",
                
                textOutput("confidence_interval")
              )
            )
          )
        )
      )
    )
  ),
  
  
  # -------------------------------------------------------
  # CONFIDENCE INTERVAL PLOT
  # -------------------------------------------------------
  
  div(
    class = "plot-container",
    
    h3("Confidence Intervals from Repeated Random Samples"),
    
    p(
      "Each horizontal line represents a confidence interval. ",
      "The dot represents the sample mean."
    ),
    
    plotOutput(
      outputId = "ci_plot",
      height = "500px"
    )
  ),
  
  
  # -------------------------------------------------------
  # REPEATED SAMPLE TABLE
  # -------------------------------------------------------
  
  div(
    class = "table-container",
    
    h3("Your Repeated Samples"),
    
    p(
      "Take several random samples and watch how the sample means ",
      "and confidence intervals change."
    ),
    
    tableOutput("results_table")
  )
)


# ---------------------------------------------------------
# SERVER
# ---------------------------------------------------------

server <- function(input, output, session) {
  
  # -------------------------------------------------------
  # Store results from repeated samples
  # -------------------------------------------------------
  
  results <- reactiveVal(
    data.frame(
      Sample = integer(),
      Sample_Mean = numeric(),
      Margin_of_Error = numeric(),
      Lower = numeric(),
      Upper = numeric(),
      Confidence_Level = numeric(),
      Sample_Size = integer(),
      stringsAsFactors = FALSE
    )
  )
  
  
  # -------------------------------------------------------
  # Take a random sample
  # -------------------------------------------------------
  
  observeEvent(input$sample, {
    
    # Randomly select invoices
    x <- sample(
      invoice_amounts,
      size = input$sample_size,
      replace = FALSE
    )
    
    # Make sure values are numeric
    x <- as.numeric(x)
    
    # Remove any invalid values
    x <- x[is.finite(x)]
    
    # Actual sample size after cleaning
    n <- length(x)
    
    # Sample mean
    x_bar <- mean(x)
    
    # Sample standard deviation
    s <- sd(x)
    
    # Standard error
    se <- s / sqrt(n)
    
    # Confidence level
    confidence <- as.numeric(input$confidence_level)
    
    # Alpha
    alpha <- 1 - confidence
    
    # Critical t-value
    t_star <- qt(
      1 - alpha / 2,
      df = n - 1
    )
    
    # Margin of error
    margin_of_error <- t_star * se
    
    # Confidence interval
    lower <- x_bar - margin_of_error
    upper <- x_bar + margin_of_error
    
    # Existing results
    old_results <- results()
    
    # New sample number
    sample_number <- nrow(old_results) + 1
    
    # New result
    new_result <- data.frame(
      Sample = sample_number,
      Sample_Mean = x_bar,
      Margin_of_Error = margin_of_error,
      Lower = lower,
      Upper = upper,
      Confidence_Level = confidence,
      Sample_Size = n,
      stringsAsFactors = FALSE
    )
    
    # Add new result
    results(
      rbind(
        old_results,
        new_result
      )
    )
  })
  
  
  # -------------------------------------------------------
  # Reset
  # -------------------------------------------------------
  
  observeEvent(input$reset, {
    
    results(
      data.frame(
        Sample = integer(),
        Sample_Mean = numeric(),
        Margin_of_Error = numeric(),
        Lower = numeric(),
        Upper = numeric(),
        Confidence_Level = numeric(),
        Sample_Size = integer(),
        stringsAsFactors = FALSE
      )
    )
    
  })
  
  
  # -------------------------------------------------------
  # Current sample number
  # -------------------------------------------------------
  
  output$sample_number <- renderText({
    
    data <- results()
    
    if (nrow(data) == 0) {
      return("No sample taken yet.")
    }
    
    paste(
      "Sample",
      data$Sample[nrow(data)]
    )
  })
  
  
  # -------------------------------------------------------
  # Current sample mean
  # -------------------------------------------------------
  
  output$sample_mean <- renderText({
    
    data <- results()
    
    if (nrow(data) == 0) {
      return("—")
    }
    
    paste0(
      "$",
      format(
        round(data$Sample_Mean[nrow(data)], 2),
        nsmall = 2,
        big.mark = ","
      )
    )
  })
  
  
  # -------------------------------------------------------
  # Current margin of error
  # -------------------------------------------------------
  
  output$margin_error <- renderText({
    
    data <- results()
    
    if (nrow(data) == 0) {
      return("—")
    }
    
    paste0(
      "$",
      format(
        round(data$Margin_of_Error[nrow(data)], 2),
        nsmall = 2,
        big.mark = ","
      )
    )
  })
  
  
  # -------------------------------------------------------
  # Current confidence interval
  # -------------------------------------------------------
  
  output$confidence_interval <- renderText({
    
    data <- results()
    
    if (nrow(data) == 0) {
      return("—")
    }
    
    lower <- data$Lower[nrow(data)]
    upper <- data$Upper[nrow(data)]
    
    paste0(
      "$",
      format(
        round(lower, 2),
        nsmall = 2,
        big.mark = ","
      ),
      " to $",
      format(
        round(upper, 2),
        nsmall = 2,
        big.mark = ","
      )
    )
  })
  
  
  # -------------------------------------------------------
  # Repeated sample table
  # -------------------------------------------------------
  
  output$results_table <- renderTable({
    
    data <- results()
    
    if (nrow(data) == 0) {
      return(NULL)
    }
    
    display_data <- data
    
    display_data$Sample_Mean <- paste0(
      "$",
      format(
        round(display_data$Sample_Mean, 2),
        nsmall = 2,
        big.mark = ","
      )
    )
    
    display_data$Margin_of_Error <- paste0(
      "$",
      format(
        round(display_data$Margin_of_Error, 2),
        nsmall = 2,
        big.mark = ","
      )
    )
    
    display_data$Confidence_Interval <- paste0(
      "$",
      format(
        round(display_data$Lower, 2),
        nsmall = 2,
        big.mark = ","
      ),
      " to $",
      format(
        round(display_data$Upper, 2),
        nsmall = 2,
        big.mark = ","
      )
    )
    
    display_data$Confidence_Level <- paste0(
      round(
        display_data$Confidence_Level * 100
      ),
      "%"
    )
    
    display_data$Sample_Size <- display_data$Sample_Size
    
    display_data <- display_data[
      ,
      c(
        "Sample",
        "Sample_Size",
        "Sample_Mean",
        "Margin_of_Error",
        "Confidence_Interval",
        "Confidence_Level"
      )
    ]
    
    names(display_data) <- c(
      "Sample",
      "n",
      "Sample Mean",
      "Margin of Error",
      "Confidence Interval",
      "Confidence Level"
    )
    
    display_data
  },
  
  striped = TRUE,
  bordered = TRUE,
  hover = TRUE,
  spacing = "s"
  )
  
  
  # -------------------------------------------------------
  # CONFIDENCE INTERVAL PLOT
  # -------------------------------------------------------
  
  output$ci_plot <- renderPlot({
    
    data <- results()
    
    # If no samples have been taken yet
    if (nrow(data) == 0) {
      
      plot.new()
      
      text(
        0.5,
        0.5,
        "Take a random sample to begin.",
        cex = 1.3
      )
      
      return()
    }
    
    
    # Number of samples
    num_samples <- nrow(data)
    
    
    # Determine reasonable x-axis limits
    all_values <- c(
      data$Lower,
      data$Upper,
      data$Sample_Mean
    )
    
    x_min <- min(all_values)
    x_max <- max(all_values)
    
    range_width <- x_max - x_min
    
    # Add some space around the intervals
    if (range_width == 0) {
      range_width <- 100
    }
    
    x_min <- x_min - 0.08 * range_width
    x_max <- x_max + 0.08 * range_width
    
    
    # Create plot area
    plot(
      NA,
      xlim = c(x_min, x_max),
      ylim = c(0.5, num_samples + 0.5),
      yaxt = "n",
      xlab = "Invoice Cost ($)",
      ylab = "",
      main = "Confidence Intervals from Repeated Random Samples",
      bty = "n"
    )
    
    
    # Add light vertical gridlines
    abline(
      v = pretty(
        c(x_min, x_max),
        n = 7
      ),
      col = "gray90",
      lty = 1
    )
    
    
    # Add sample labels
    axis(
      side = 2,
      at = data$Sample,
      labels = paste(
        "Sample",
        data$Sample
      ),
      las = 1,
      tick = FALSE
    )
    
    
    # Draw confidence intervals
    segments(
      x0 = data$Lower,
      y0 = data$Sample,
      x1 = data$Upper,
      y1 = data$Sample,
      lwd = 4
    )
    
    
    # Draw end caps
    segments(
      x0 = data$Lower,
      y0 = data$Sample - 0.12,
      x1 = data$Lower,
      y1 = data$Sample + 0.12,
      lwd = 2
    )
    
    segments(
      x0 = data$Upper,
      y0 = data$Sample - 0.12,
      x1 = data$Upper,
      y1 = data$Sample + 0.12,
      lwd = 2
    )
    
    
    # Draw sample mean
    points(
      x = data$Sample_Mean,
      y = data$Sample,
      pch = 19,
      cex = 1.3
    )
    
    
    # Add sample mean values to the right of the dot
    text(
      x = data$Sample_Mean,
      y = data$Sample + 0.28,
      labels = paste0(
        "$",
        format(
          round(data$Sample_Mean, 0),
          big.mark = ","
        )
      ),
      cex = 0.75
    )
    
  })
  
}


# ---------------------------------------------------------
# RUN APP
# ---------------------------------------------------------

shinyApp(
  ui = ui,
  server = server
)

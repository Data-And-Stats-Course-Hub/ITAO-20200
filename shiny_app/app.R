library(shiny)
library(bslib)

# ---------------------------------------------------------
# LOAD DATA
# ---------------------------------------------------------

invoices <- read.csv(
  "https://raw.githubusercontent.com/Data-And-Stats-Course-Hub/ITAO-20200/main/Data/procurement_invoices.csv",
  stringsAsFactors = FALSE
)

if (!"invoices" %in% names(invoices)) {
  stop("The invoice amount column named 'invoices' was not found.")
}

invoice_amounts <- invoices[["invoices"]]
invoice_amounts <- as.character(invoice_amounts)
invoice_amounts <- gsub(",", "", invoice_amounts)
invoice_amounts <- gsub("\\$", "", invoice_amounts)
invoice_amounts <- suppressWarnings(as.numeric(invoice_amounts))
invoice_amounts <- invoice_amounts[is.finite(invoice_amounts)]


# ---------------------------------------------------------
# THEME
# ---------------------------------------------------------

app_theme <- bs_theme(
  version = 5,
  bg = "#f5f7fa",
  fg = "#1f2a37",
  primary = "#174a7e",
  secondary = "#3d6f9f",
  success = "#1f9d55",
  base_font = font_google("Inter"),
  heading_font = font_google("Inter"),
  "border-radius" = "0.9rem"
)


# ---------------------------------------------------------
# USER INTERFACE
# ---------------------------------------------------------

ui <- fluidPage(
  
  theme = app_theme,
  
  tags$head(
    tags$style(HTML("

      body { font-family: 'Inter', Arial, sans-serif; }

      @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(8px); }
        to   { opacity: 1; transform: translateY(0); }
      }
      @keyframes pop {
        0%   { transform: scale(0.9); opacity: 0.4; }
        60%  { transform: scale(1.05); opacity: 1; }
        100% { transform: scale(1); }
      }

      .hero {
        background: linear-gradient(135deg, #0b2e59, #174a7e 60%, #2f7cc9);
        color: white;
        padding: 22px 28px;
        border-radius: 14px;
        margin-bottom: 16px;
        box-shadow: 0 8px 22px rgba(11,46,89,0.22);
        animation: fadeInUp 0.5s ease;
      }
      .hero h1 {
        font-size: 26px;
        font-weight: 800;
        margin-bottom: 4px;
        letter-spacing: -0.02em;
      }
      .hero p { font-size: 14.5px; opacity: 0.92; margin-bottom: 0; }

      .info-box {
        background-color: white;
        border-left: 5px solid #174a7e;
        padding: 16px 20px;
        border-radius: 10px;
        margin-bottom: 16px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
      }
      .info-box h3 { margin-top: 0; margin-bottom: 8px; color: #0b2e59; font-weight: 700; font-size: 18px; }
      .info-box ol { margin-bottom: 8px; padding-left: 20px; }
      .info-box li { margin-bottom: 3px; font-size: 14px; line-height: 1.4; }
      .info-box p { font-size: 13.5px; margin-bottom: 0; line-height: 1.4; }

      .card {
        background-color: white;
        padding: 18px 20px;
        border-radius: 12px;
        margin-bottom: 16px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        transition: box-shadow 0.2s ease;
      }
      .card:hover { box-shadow: 0 6px 18px rgba(0,0,0,0.08); }
      .card h3 { color: #0b2e59; margin-top: 0; margin-bottom: 12px; font-weight: 700; font-size: 18px; }

      .settings-label {
        font-weight: 600;
        font-size: 13px;
        color: #0b2e59;
        margin-bottom: 5px;
        display: block;
      }
      .spacer-label { visibility: hidden; }

      .action-area {
        background: linear-gradient(180deg, #f0f5fa, #e9f1fa);
        border-radius: 10px;
        padding: 14px 16px;
        margin-top: 12px;
        border: 1px solid #dce8f5;
      }
      .action-title { font-weight: 700; color: #0b2e59; font-size: 14.5px; margin-bottom: 10px; }

      .sample-button, .batch-button {
        border: none;
        font-size: 14px;
        font-weight: 700;
        height: 38px;
        padding: 0 14px;
        border-radius: 8px;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        transition: transform 0.08s ease, box-shadow 0.15s ease;
      }
      .sample-button { background-color: #174a7e; color: white; }
      .sample-button:hover { background-color: #0b2e59; color: white; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(23,74,126,0.35); }
      .batch-button { background-color: #3d6f9f; color: white; margin-top: 8px; }
      .batch-button:hover { background-color: #2d587f; color: white; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(61,111,159,0.35); }

      .reset-button {
        background-color: white;
        color: #b23b3b;
        border: 1.5px solid #e3b6b6;
        font-size: 13px;
        font-weight: 600;
        padding: 7px 16px;
        border-radius: 7px;
      }
      .reset-button:hover { background-color: #fdf2f2; color: #8f2c2c; border-color: #d99999; }

      .result-box {
        background: linear-gradient(180deg, #f7fafd, #eef4fa);
        border: 1px solid #e2ecf5;
        border-radius: 10px;
        padding: 12px;
        text-align: center;
        margin-bottom: 10px;
        transition: transform 0.15s ease;
      }
      .result-box:hover { transform: translateY(-2px); }
      .result-box h4 { color: #6b7a8b; margin-top: 0; margin-bottom: 4px; font-size: 11.5px; text-transform: uppercase; letter-spacing: 0.04em; }
      .ci-value { font-size: 19px; font-weight: 800; color: #0b2e59; animation: pop 0.35s ease; }
      .sample-number { font-size: 26px; font-weight: 800; color: #174a7e; animation: pop 0.35s ease; }

      .plot-container, .table-container {
        background-color: white;
        padding: 14px 16px;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        margin-bottom: 16px;
      }

      .batch-note { color: #6b7a8b; font-size: 12px; margin-top: 8px; margin-bottom: 0; }

      .nav-tabs { margin-bottom: 0; }
      .nav-tabs .nav-link.active {
        color: #0b2e59;
        font-weight: 700;
        border-bottom: 3px solid #174a7e;
      }
      .nav-tabs .nav-link { color: #6b7a8b; padding: 8px 14px; }

      .footer-note { text-align: center; color: #9aa7b5; font-size: 11.5px; margin: 6px 0 16px 0; }

    "))
  ),
  
  
  # -------------------------------------------------------
  # HEADER
  # -------------------------------------------------------
  
  div(
    class = "hero",
    h1("CaterCo Invoice Audit"),
    p("Use random samples of invoices to estimate the average cost of CaterCo events.")
  ),
  
  
  # -------------------------------------------------------
  # HOW THIS WORKS
  # -------------------------------------------------------
  
  div(
    class = "info-box",
    h3("How this works"),
    tags$ol(
      tags$li(strong("Start with the population: "),
              "CaterCo has many invoices from the past six months. The population is all of those invoices, ",
              "but you will not analyze every invoice. The true average cost of all events is unknown."),
      tags$li(strong("Take a random sample: "),
              "Your company can only review a sample of invoices. You will randomly select invoices from the population to audit."),
      tags$li(strong("Calculate the sample mean: "),
              "The sample mean gives you an estimate of the population mean. But a different random sample could give you a different sample mean."),
      tags$li(strong("Build a confidence interval: "),
              "The confidence interval uses your sample to create a range of plausible values for the unknown population mean."),
      tags$li(strong("Repeat: "),
              "Each random sample produces a new sample mean and a new confidence interval. You can take samples one at a time or generate several at once.")
    ),
    tags$p(strong("Remember: "),
           "The confidence level describes the long-run performance of the interval-building process, ",
           "not the probability that one particular interval contains the population mean.")
  ),
  
  
  # -------------------------------------------------------
  # SETTINGS + CURRENT RESULTS (side by side for compactness)
  # -------------------------------------------------------
  
  fluidRow(
    
    # ---- SETTINGS (narrow column) ----
    column(
      width = 4,
      
      div(
        class = "card",
        h3("Settings"),
        
        tags$label(class = "settings-label", "Sample size"),
        numericInput(
          inputId = "sample_size", label = NULL, value = 50,
          min = 2, max = min(1000, length(invoice_amounts)), step = 10
        ),
        
        tags$label(class = "settings-label", "Confidence level"),
        selectInput(
          inputId = "confidence_level", label = NULL,
          choices = c("80%" = 0.80, "90%" = 0.90, "95%" = 0.95, "98%" = 0.98, "99%" = 0.99),
          selected = 0.95
        ),
        
        div(
          class = "action-area",
          div(class = "action-title", icon("dice"), " Generate Random Samples"),
          
          actionButton("sample", label = tagList(icon("shuffle"), "Take 1 Sample"), class = "sample-button"),
          
          div(style = "margin-top: 10px;",
              tags$label(class = "settings-label", "Number of samples"),
              selectInput("batch_size", label = NULL,
                          choices = c("5 samples" = 5, "10 samples" = 10, "50 samples" = 50,
                                      "100 samples" = 100, "200 samples" = 200),
                          selected = 10),
              actionButton("batch_sample", label = tagList(icon("layer-group"), "Generate Multiple"), class = "batch-button")
          ),
          
          p(class = "batch-note", "Each sample gets its own sample mean and confidence interval.")
        ),
        
        div(style = "margin-top: 12px;",
            actionButton("reset", label = tagList(icon("rotate-left"), "Start Over"), class = "reset-button"))
      )
    ),
    
    # ---- CURRENT RESULTS (wide column) ----
    column(
      width = 8,
      
      div(
        class = "card",
        h3("Current Sample"),
        
        fluidRow(
          column(3, div(class = "result-box", h4("Sample"), div(class = "sample-number", textOutput("sample_number")))),
          column(3, div(class = "result-box", h4("Sample Mean"), div(class = "ci-value", textOutput("sample_mean")))),
          column(3, div(class = "result-box", h4("Margin of Error"), div(class = "ci-value", textOutput("margin_error")))),
          column(3, div(class = "result-box", style = "margin-bottom: 0;", h4("Confidence Interval"), div(class = "ci-value", textOutput("confidence_interval"))))
        )
      ),
      
      div(
        class = "card",
        style = "margin-bottom: 0;",
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("chart-line"), "Confidence Interval Plot"),
            div(style = "margin-top: 12px;",
                plotOutput("ci_plot", height = "480px"))
          ),
          
          tabPanel(
            title = tagList(icon("table"), "Repeated Samples"),
            div(style = "margin-top: 12px;",
                tableOutput("results_table"))
          ),
          
          tabPanel(
            title = tagList(icon("arrows-left-right"), "Compare Confidence Levels"),
            div(style = "margin-top: 12px;",
                p(class = "batch-note", style = "margin-bottom: 10px;",
                  "Same sample data, five confidence levels — see how a higher confidence level widens the interval."),
                plotOutput("compare_plot", height = "300px"),
                br(),
                tableOutput("compare_table"))
          )
        )
      )
    )
  ),
  
  div(class = "footer-note", "Each dot is a sample mean; the whiskers mark the confidence interval endpoints.")
)


# ---------------------------------------------------------
# SERVER
# ---------------------------------------------------------

server <- function(input, output, session) {
  
  CI_LEVELS <- c(0.80, 0.90, 0.95, 0.98, 0.99)
  
  results <- reactiveVal(
    data.frame(
      Sample = integer(), Sample_Size = integer(), Sample_Mean = numeric(),
      Sample_SD = numeric(),
      Margin_of_Error = numeric(), Lower = numeric(), Upper = numeric(),
      Interval_Width = numeric(),
      stringsAsFactors = FALSE
    )
  )
  
  calculate_interval <- function(sample_number, sample_size, confidence) {
    x <- sample(invoice_amounts, size = sample_size, replace = FALSE)
    x <- as.numeric(x)
    x <- x[is.finite(x)]
    n <- length(x)
    if (n < 2) return(NULL)
    
    x_bar <- mean(x)
    s <- sd(x)
    se <- s / sqrt(n)
    alpha <- 1 - confidence
    t_star <- qt(1 - alpha / 2, df = n - 1)
    margin_of_error <- t_star * se
    lower <- x_bar - margin_of_error
    upper <- x_bar + margin_of_error
    
    data.frame(
      Sample = sample_number, Sample_Size = n, Sample_Mean = x_bar,
      Sample_SD = s,
      Margin_of_Error = margin_of_error, Lower = lower, Upper = upper,
      Interval_Width = upper - lower,
      stringsAsFactors = FALSE
    )
  }
  
  observeEvent(input$sample, {
    requested_n <- as.integer(input$sample_size)
    confidence <- as.numeric(input$confidence_level)
    old_results <- results()
    next_sample_number <- nrow(old_results) + 1
    
    new_result <- calculate_interval(next_sample_number, requested_n, confidence)
    
    if (is.null(new_result)) {
      showNotification("There are not enough valid invoice amounts to calculate a confidence interval.", type = "error")
      return()
    }
    results(rbind(old_results, new_result))
  })
  
  observeEvent(input$batch_sample, {
    requested_n <- as.integer(input$sample_size)
    confidence <- as.numeric(input$confidence_level)
    number_of_samples <- as.integer(input$batch_size)
    old_results <- results()
    first_sample_number <- nrow(old_results) + 1
    
    new_results <- do.call(rbind, lapply(0:(number_of_samples - 1), function(i) {
      calculate_interval(first_sample_number + i, requested_n, confidence)
    }))
    
    if (is.null(new_results) || nrow(new_results) == 0) {
      showNotification("There were not enough valid invoice amounts to calculate the confidence intervals.", type = "error")
      return()
    }
    results(rbind(old_results, new_results))
  })
  
  observeEvent(input$reset, {
    results(
      data.frame(
        Sample = integer(), Sample_Size = integer(), Sample_Mean = numeric(),
        Sample_SD = numeric(),
        Margin_of_Error = numeric(), Lower = numeric(), Upper = numeric(),
        Interval_Width = numeric(),
        stringsAsFactors = FALSE
      )
    )
  })
  
  fmt_dollar <- function(x, digits = 2) {
    paste0("$", format(round(x, digits), big.mark = ",", nsmall = digits))
  }
  
  output$sample_number <- renderText({
    data <- results()
    if (nrow(data) == 0) return("—")
    as.integer(data$Sample[nrow(data)])
  })
  
  output$sample_mean <- renderText({
    data <- results()
    if (nrow(data) == 0) return("—")
    fmt_dollar(data$Sample_Mean[nrow(data)])
  })
  
  output$margin_error <- renderText({
    data <- results()
    if (nrow(data) == 0) return("—")
    fmt_dollar(data$Margin_of_Error[nrow(data)])
  })
  
  output$confidence_interval <- renderText({
    data <- results()
    if (nrow(data) == 0) return("—")
    paste0(fmt_dollar(data$Lower[nrow(data)]), "  to  ", fmt_dollar(data$Upper[nrow(data)]))
  })
  
  output$results_table <- renderTable({
    data <- results()
    if (nrow(data) == 0) return(NULL)
    
    display_data <- data.frame(
      Sample = as.character(as.integer(data$Sample)),
      Sample_Size = as.character(as.integer(data$Sample_Size)),
      Sample_Mean = sapply(data$Sample_Mean, fmt_dollar),
      Margin_of_Error = sapply(data$Margin_of_Error, fmt_dollar),
      Confidence_Interval = paste0(sapply(data$Lower, fmt_dollar), " to ", sapply(data$Upper, fmt_dollar)),
      Interval_Width = sapply(data$Interval_Width, fmt_dollar),
      stringsAsFactors = FALSE
    )
    
    names(display_data) <- c("Sample", "Sample Size", "Sample Mean", "Margin of Error",
                             "Confidence Interval", "Interval Width")
    display_data
  }, striped = TRUE, bordered = TRUE, hover = TRUE, spacing = "m")
  
  # -------------------------------------------------------
  # COMPARE CONFIDENCE LEVELS (same sample, five levels)
  # -------------------------------------------------------
  
  compare_data <- reactive({
    data <- results()
    if (nrow(data) == 0) return(NULL)
    
    last_row <- data[nrow(data), ]
    x_bar <- last_row$Sample_Mean
    s <- last_row$Sample_SD
    n <- last_row$Sample_Size
    
    do.call(rbind, lapply(CI_LEVELS, function(conf) {
      alpha <- 1 - conf
      t_star <- qt(1 - alpha / 2, df = n - 1)
      moe <- t_star * s / sqrt(n)
      data.frame(
        Confidence = conf, Sample_Mean = x_bar,
        Margin_of_Error = moe, Lower = x_bar - moe, Upper = x_bar + moe,
        Width = 2 * moe, stringsAsFactors = FALSE
      )
    }))
  })
  
  output$compare_table <- renderTable({
    data <- compare_data()
    if (is.null(data)) return(NULL)
    
    display_data <- data.frame(
      Confidence_Level = paste0(round(data$Confidence * 100), "%"),
      Margin_of_Error = sapply(data$Margin_of_Error, fmt_dollar),
      Confidence_Interval = paste0(sapply(data$Lower, fmt_dollar), " to ", sapply(data$Upper, fmt_dollar)),
      Interval_Width = sapply(data$Width, fmt_dollar),
      stringsAsFactors = FALSE
    )
    
    names(display_data) <- c("Confidence Level", "Margin of Error", "Confidence Interval", "Interval Width")
    display_data
  }, striped = TRUE, bordered = TRUE, hover = TRUE, spacing = "m")
  
  output$compare_plot <- renderPlot({
    data <- compare_data()
    
    if (is.null(data)) {
      plot.new()
      text(0.5, 0.5, "Take a random sample to begin.", cex = 1.3)
      return()
    }
    
    num_levels <- nrow(data)
    x_min <- min(data$Lower) - 0.08 * max(data$Width)
    x_max <- max(data$Upper) + 0.08 * max(data$Width)
    
    par(mar = c(4, 6, 1.5, 2) + 0.1)
    
    plot(
      NA, xlim = c(x_min, x_max), ylim = c(0.5, num_levels + 0.5),
      yaxt = "n", xlab = "Invoice Cost ($)", ylab = "", bty = "n"
    )
    
    abline(v = pretty(c(x_min, x_max), n = 7), col = "gray90", lty = 1)
    abline(v = data$Sample_Mean[1], col = "gray60", lty = 2)
    
    axis(
      side = 2, at = seq_len(num_levels),
      labels = paste0(round(data$Confidence * 100), "%"),
      las = 1, tick = FALSE
    )
    
    shades <- colorRampPalette(c("#8fbadf", "#0b2e59"))(num_levels)
    
    segments(
      x0 = data$Lower, y0 = seq_len(num_levels),
      x1 = data$Upper, y1 = seq_len(num_levels),
      lwd = 6, col = shades
    )
    
    points(x = data$Sample_Mean, y = seq_len(num_levels), pch = 19, cex = 1.1, col = "white")
    points(x = data$Sample_Mean, y = seq_len(num_levels), pch = 1, cex = 1.1, col = "#0b2e59")
    
    text(
      x = data$Upper, y = seq_len(num_levels),
      labels = paste0(" ±", format(round(data$Margin_of_Error, 0), big.mark = ",")),
      cex = 0.75, pos = 4, col = "#3a4a5a"
    )
  })
  
  # -------------------------------------------------------
  # CONFIDENCE INTERVAL PLOT
  # -------------------------------------------------------
  
  output$ci_plot <- renderPlot({
    
    data <- results()
    
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
    
    num_samples <- nrow(data)
    
    all_values <- c(
      data$Lower,
      data$Upper,
      data$Sample_Mean
    )
    
    x_min <- min(all_values)
    
    x_max <- max(all_values)
    
    range_width <- x_max - x_min
    
    if (range_width == 0) {
      range_width <- 100
    }
    
    x_min <- x_min - 0.08 * range_width
    
    x_max <- x_max + 0.08 * range_width
    
    # Extra left margin so "Sample 1" is not clipped
    par(
      mar = c(5, 8, 4, 2) + 0.1
    )
    
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
    
    abline(
      v = pretty(
        c(x_min, x_max),
        n = 7
      ),
      col = "gray90",
      lty = 1
    )
    
    axis(
      side = 2,
      at = data$Sample,
      labels = paste(
        "Sample",
        as.integer(data$Sample)
      ),
      las = 1,
      tick = FALSE
    )
    
    segments(
      x0 = data$Lower,
      y0 = data$Sample,
      x1 = data$Upper,
      y1 = data$Sample,
      lwd = 4
    )
    
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
    
    points(
      x = data$Sample_Mean,
      y = data$Sample,
      pch = 19,
      cex = 1.3
    )
    
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
# RUN THE APP
# ---------------------------------------------------------

shinyApp(ui = ui, server = server)

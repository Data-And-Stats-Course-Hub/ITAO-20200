################################################################################
# cor_matrix.R
# -----------------------------------------------------------------------------
# Correlation matrix, sample size and p-values for every pair of variables,
# using base R only (cor() and cor.test()). No packages needed.
#
# Output has three parts, laid out like psych::corr.test():
#   1. Correlation matrix   (Pearson r, rounded to 3 decimals by default)
#   2. Sample Size          (number of complete rows used)
#   3. Probability values   (two-sided p-values from cor.test(), rounded to
#                            4 decimals by default; NOT adjusted for multiple
#                            tests; diagonal set to 0)
#
# Usage:
#   source("https://data-and-stats-course-hub.github.io/ITAO-20200/R-Guides-and-Codes/cor_matrix.R")
#   cor_matrix(Housing[, c("Price", "Size")])
#   cor_matrix(Housing[, c("Price", "Size", "Age", "Rooms")])
#
# Arguments:
#   data      a data frame or matrix containing only numeric columns
#   digits_r  decimals for the correlations (default 3)
#   digits_p  decimals for the p-values (default 4)
#
# Rows with any missing value are removed before computing (with a message),
# so every correlation and p-value is based on the same sample size.
#
# Change log:
#   2026-11-13  First version, built from the helper in the Correlation and
#               SLR handout (v3). Added input checks, listwise removal of
#               missing values, and a p-value loop over the upper triangle
#               only (the matrix is symmetric). Output printed with plain
#               headings through a print method instead of as a raw list.
################################################################################

cor_matrix <- function(data, digits_r = 3, digits_p = 4) {
  
  # ---- Input checks ---------------------------------------------------------
  if (missing(data)) {
    stop("Please supply the data, e.g. cor_matrix(Housing[, c(\"Price\", \"Size\")]).",
         call. = FALSE)
  }
  if (!is.data.frame(data) && !is.matrix(data)) {
    stop("'data' must be a data frame or a matrix, not a ", class(data)[1], ".",
         call. = FALSE)
  }
  data <- as.data.frame(data)
  
  if (ncol(data) < 2) {
    stop("'data' must have at least 2 columns to compute correlations.",
         call. = FALSE)
  }
  
  is_num <- vapply(data, is.numeric, logical(1))
  if (!all(is_num)) {
    stop("All columns must be numeric. Remove these column(s): ",
         paste(names(data)[!is_num], collapse = ", "), call. = FALSE)
  }
  
  for (d in list(digits_r, digits_p)) {
    if (!is.numeric(d) || length(d) != 1 || is.na(d) || d < 0 || d != round(d)) {
      stop("'digits_r' and 'digits_p' must be single whole numbers, 0 or more.",
           call. = FALSE)
    }
  }
  
  # ---- Missing values: keep complete rows only ------------------------------
  complete <- stats::complete.cases(data)
  if (!all(complete)) {
    message(sum(!complete), " row(s) with missing values were removed; ",
            sum(complete), " complete row(s) used.")
    data <- data[complete, , drop = FALSE]
  }
  
  n <- nrow(data)
  if (n < 3) {
    stop("At least 3 complete rows are needed for a correlation test; only ",
         n, " available.", call. = FALSE)
  }
  
  sds <- vapply(data, stats::sd, numeric(1))
  if (any(sds == 0)) {
    stop("These column(s) have the same value in every row, so a correlation ",
         "cannot be computed: ", paste(names(data)[sds == 0], collapse = ", "),
         call. = FALSE)
  }
  
  # ---- Correlations and p-values --------------------------------------------
  r <- stats::cor(data)                       # correlation matrix
  k <- ncol(data)
  p <- matrix(0, nrow = k, ncol = k, dimnames = dimnames(r))
  
  for (i in 1:(k - 1)) {
    for (j in (i + 1):k) {
      p[i, j] <- stats::cor.test(data[[i]], data[[j]])$p.value
      p[j, i] <- p[i, j]                      # matrix is symmetric
    }
  }
  
  # ---- Output ---------------------------------------------------------------
  out <- list(r = round(r, digits_r),
              n = n,
              p = round(p, digits_p))
  class(out) <- "cor_matrix"
  out
}

# Print method: shows the three blocks with plain headings
# (no $ signs or backticks). Parts can still be pulled out with
# result$r, result$n and result$p.
print.cor_matrix <- function(x, ...) {
  cat("Correlation matrix\n")
  print(x$r)
  cat("\nSample Size\n")
  print(x$n)
  cat("\nProbability values\n")
  print(x$p)
  invisible(x)
}
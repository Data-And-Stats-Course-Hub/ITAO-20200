################################################################################
### Description:                                                             ###
###   The function ols_regress_mod function modifies the output of the       ###
###   original ols_regress output in the olsrr package. The MSE and RMSE     ###
###   in Model Summary component of the the ols_regress output do not much   ###
###   the MSE value in the ANOVA component of the output. This function      ###
###   replaces the MSE and the RMSE in the Model Summary component with the  ###
###   value from the ANOVA table.                                            ###
###                                                                          ###
###                                                                          ###
### Required Packages: olsrr                                                 ###
###                                                                          ###
###                                                                          ###
### Change Log        00/19/2025                                             ###
###                                                                          ###
################################################################################

ols_regress_mod <- function(model){
  package_name <- "olsrr"
  
  # Check if the package is installed
  if (!requireNamespace(package_name, quietly = TRUE)) {
    
    # If not installed, install it
    install.packages(package_name, dependencies = TRUE)
  }
  
  # Check to ensure that the model supplied is of class "lm".
  # If not print an error message.
  if(class(model) != "lm"){
    stop("You need to supply a model as an argument")
  }
  
  ## Load required packages and suppress any warning messages
  suppressWarnings(suppressMessages(library(olsrr)))
  
  ## Use ols_regress function to produce a nice formatted output
  dat <- ols_regress(model)
  
  ## Pick out the MSE and RMSE values in the model summary table and replace them
  dat$mse <- dat$ems
  dat$rmse <- sqrt(dat$mse)
  
  ## Now return the model results
  return(dat)
}

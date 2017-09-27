#' BUILD: Normalize a column
#' 
#' Normalizes a column so the numeric values are rescaled from 0 to 1
#'  
#' @param data data.frame that holds the column to be normalized
#' @param column the column name to normalize
#' 
#' @export
normalize_column <- function(data, column) {
  
  temp_col <- data[[column]]
  
  temp_min <- min(temp_col, na.rm=TRUE)
  temp_max <- max(temp_col, na.rm=TRUE)
  
  temp_output <- (temp_col-temp_min)/(temp_max-temp_min)
  
  return(temp_output)
}
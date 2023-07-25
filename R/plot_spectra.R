#' Plot Spectrum
#'
#' This function reads spectral data from the provided file and plots the spectrum.
#' It applies intensity adjustment and background subtraction to the data based on
#' the specified smoothing_factor and background_factor values (optional). If the
#' smoothing_factor and background_factor are not provided, default values will be used.
#' The function uses the `OpenSpecy` and `dplyr` packages for data processing.
#'
#' @param pathname A character string specifying the path to the file containing the spectrum data.
#' @param smoothing_factor An optional numerical value specifying the intensity adjustment smoothing factor (default: 3).
#'                         The valid range is between 1 and 7.
#' @param background_factor An optional numerical value specifying the background subtraction factor (default: 8).
#'                           The valid range is between 1 and 20.
#'
#' @details The function reads the spectral data from the provided file using the `read_data` function from the `OpenSpecy` package.
#'          It then applies intensity adjustment and background subtraction to the data based on the specified smoothing_factor and
#'          background_factor values (if provided) using the `adj_intens` and `subtr_bg` functions from the `dplyr` package, respectively.
#'          The resulting processed spectrum is plotted with the wavenumber (cm-1) on the x-axis and intensity on the y-axis using the
#'          base R `plot` function.
#'
#' @examples
#' # Example 1: Plot spectrum with default intensity and background factors
#' plot_spectrum("path/to/spectrum.csv")
#'
#' # Example 2: Plot spectrum with specified intensity and background factors
#' plot_spectrum("path/to/spectrum.csv", smoothing_factor = 5, background_factor = 12)
#'
#' @importFrom OpenSpecy adj_intens subtr_bg
#'
#' @export
library(OpenSpecy)
library(dplyr)

plot_spectrum <- function(pathname, smoothing_factor = NULL, background_factor = NULL) {
  # Read spectral data from the provided file
  spectrum_data <- read_data(pathname)

  # Set default values if smoothing_factor and background_factor are not provided
  if (is.null(smoothing_factor)) {
    smoothing_factor <- 3
  } else {
    if (smoothing_factor < 1 || smoothing_factor > 7) {
      # Show a warning message if the smoothing_factor is outside the valid range
      warning("Intensity factor should be between 1 and 7. Using default factor (1).")
      smoothing_factor <- 1
    }
  }

  if (is.null(background_factor)) {
    background_factor <- 8
  } else {
    if (background_factor < 1 || background_factor > 20) {
      # Show a warning message if the background_factor is outside the valid range
      warning("Background factor should be between 1 and 20. Using default factor (0).")
      background_factor <- 0
    }
  }

  # Apply intensity adjustment by the numerical factor
  spectrum_adj <- spectrum_data %>%
    adj_intens(smoothing_factor)

  # Apply background subtraction by the numerical factor
  spectrum_proc <- spectrum_adj %>%
    subtr_bg(background_factor)

  # Plot the spectrum
  plot(spectrum_proc, main = "Spectral Plot", xlab = "Wavenumber (cm-1)", ylab = "Intensity", type = "l")
}


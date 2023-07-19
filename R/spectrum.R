#' Determine Spectrum Type (Raman or FTIR)
#'
#' This function reads data from a file specified by its pathname, and based on the
#' content of the file, it determines whether the spectrum type is Raman or FTIR.
#' The function uses the `OpenSpecy` package to match the spectrum data with the
#' corresponding library and retrieve meta data. It then compares the R-squared values
#' for Raman and FTIR spectra to determine the spectrum type with the higher R-squared
#' value. If both Raman and FTIR spectra are detected, the function selects the spectrum
#' type with the higher R-squared value.
#'
#' @param pathname A character string specifying the path to the file.
#'
#' @return The function returns a character string indicating the detected spectrum type.
#' The possible values are "Raman", "FTIR", or "Unknown" if the spectrum type cannot be
#' determined from the file content.
#'
#' @importFrom OpenSpecy read_data match_spec
#'
#' @examples
#' # Determine spectrum type for a sample file
#' spectrum_type <- spectrum("testdata.csv")
#'
#' @export

# Fetch FTIR library
get_lib()

# Load FTIR library into global environment
spec_lib <- load_lib()

spectrum <- function(pathname) {
  spec_data <- read_data(pathname)
  testraman <- match_spec(spec_data, library = spec_lib, which = "raman")
  testftir <- match_spec(spec_data, library = spec_lib, which = "ftir")

  testraman <- head(testraman, 1)
  testftir <- head(testftir, 1)

  if (!is.null(testraman) && !is.null(testftir)) {
    if (testraman$rsq > testftir$rsq) {
      spectrum_type <- "Raman"
    } else {
      spectrum_type <- "FTIR"
    }
  } else if (!is.null(testraman)) {
    spectrum_type <- "Raman"
  } else if (!is.null(testftir)) {
    spectrum_type <- "FTIR"
  } else {
    spectrum_type <- "Unknown"
  }
  return(spectrum_type)
}

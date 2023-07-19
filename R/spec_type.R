# Install Packages
library(OpenSpecy)

get_lib()
spec_lib <- load_lib()

# Test if Raman or FTIR
spectrum <- function(pathname) {
  spec_data <- spec_data(pathname)  # Call spec_data function with the provided pathname
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

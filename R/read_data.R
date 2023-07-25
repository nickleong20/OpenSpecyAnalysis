#' Determine File Type and Read Data
#'
#' This function reads data from a file specified by its pathname and automatically
#' determines the appropriate method to read the data based on the file extension.
#' The supported file types are CSV, ASP, JDX, SPC, SPA, and 0. If the file extension
#' is not recognized, the function will raise an error.
#'
#' @param pathname A character string specifying the path to the file.
#'
#' @return The function returns the data read from the file. The data will be returned
#' as a data frame if the file type is CSV, ASP, JDX, SPC, SPA, or 0. If the file type
#' is not supported, the function will raise an error with a message indicating the
#' unsupported file type.
#'
#' @examples
#' # Read a CSV file
#' data <- read_data("testdata.csv")
#'
#' # Read an ASP file
#' data <- read_data("ftir_ldpe_soil.asp")
#'
#' # Read a JDX file
#' data <- read_data("fitr_nitrocellulose.jdx")
#'
#' # Read an unsupported file type (will raise an error)
#' data <- read_data("Nurdle A.txt")
#'
#' @importFrom tools file_ext
#' @importFrom readr read_csv
#' @importFrom OpenSpecy read_asp read_jdx read_spc read_spa read_0
#'
#' @export
library(OpenSpecy)

read_data <- function(pathname) {
  file_extension <- tools::file_ext(pathname)

  if (grepl("\\.csv$", pathname, ignore.case = T)) {
    data <- read.csv(pathname, header = TRUE, stringsAsFactors = FALSE)
  } else if (grepl("\\.asp$", pathname, ignore.case = T)) {
    data <- OpenSpecy::read_asp(pathname)
  } else if (grepl("\\.jdx$", pathname, ignore.case = T)) {
    data <- OpenSpecy::read_jdx(pathname)
  } else if (grepl("\\.spc$", pathname, ignore.case = T)) {
    data <- OpenSpecy::read_spc(pathname)
  } else if (grepl("\\.spa$", pathname, ignore.case = T)) {
    data <- OpenSpecy::read_spa(pathname)
  } else if (grepl("\\.0$", pathname, ignore.case = T)) {
    data <- OpenSpecy::read_0(pathname)
  } else {
    # File type not supported
    stop(paste0("Unsupported file type: ", file_extension))
  }

  return(data)
}

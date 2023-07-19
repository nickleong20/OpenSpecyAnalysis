#' Automated Spectrum Matching
#'
#' This function performs automated spectrum matching based on the spectrum type
#' (Raman or FTIR) determined from the provided file. It reads the data from the file
#' specified by its pathname and performs various data processing steps, such as smoothing
#' and background correction. The function then matches the processed spectrum with the
#' corresponding library using the `OpenSpecy` package. The results are stored in a data frame
#' with information about the smoothing intensity, baseline correction, sample name, spectrum
#' identity, and R-value (which is used for sorting).
#'
#' @param pathname A character string specifying the path to the file.
#'
#' @return The function returns a data frame containing the results of the automated spectrum
#' matching. The data frame includes columns for smoothing intensity, baseline correction,
#' sample name, spectrum identity, and R-value. The results are sorted in descending order
#' based on the R-value.
#'
#' @importFrom OpenSpecy spectrum read_data match_spec
#' @importFrom dplyr rename arrange desc
#'
#' @examples
#' # Perform automated spectrum matching for a sample file
#' automatch_results <- automatch("testdata.csv")
#'
#' @export
automatch <- function(pathname) {
  # Load data
  spectrum_type <- spectrum(pathname)

  if (spectrum_type == "Unknown") {
    stop("Spectrum type is unknown. Unable to perform automatching.")
  }

  adj_data <- read_data(pathname)

  # Create a vector of smoothing factors
  smoothing_factors <- 1:7

  # Create a vector of subtr_bg values
  subtr_bg_values <- 1:20

  # Initialize an empty data frame to store the results
  results <- data.frame(
    smooth_intens = integer(),
    subtr_bg = integer(),
    top_result = character(),
    type = character(),
    stringsAsFactors = FALSE
  )

  for (factor in smoothing_factors) {
    for (subtr_bg_value in subtr_bg_values) {
      # Smooth and background-correct spectrum with current smoothing factor and subtr_bg value
      proc_data <- adj_data %>% smooth_intens(factor) %>% subtr_bg(subtr_bg_value)

      if (spectrum_type == "Raman") {
        # Match spectrum with library and retrieve meta data for Raman
        match_result_raman <- match_spec(proc_data, library = spec_lib, which = "raman")

        # Retrieve the top displayed result for Raman
        top_raman <- head(match_result_raman, 1)

        # Create data frames for each smoothing factor and subtr_bg value
        results_raman <- data.frame(
          smooth_intens = factor,
          subtr_bg = subtr_bg_value,
          top_result = top_raman,
          type = "Raman",
          stringsAsFactors = FALSE
        )

        # Append the data frames to the results data frame
        results <- rbind(results, results_raman)
      } else if (spectrum_type == "FTIR") {
        # Match spectrum with library and retrieve meta data for FTIR
        match_result_ftir <- match_spec(proc_data, library = spec_lib, which = "ftir")

        # Retrieve the top displayed result for FTIR
        top_ftir <- head(match_result_ftir, 1)

        # Create data frames for each smoothing factor and subtr_bg value
        results_ftir <- data.frame(
          smooth_intens = factor,
          subtr_bg = subtr_bg_value,
          top_result = top_ftir,
          type = "FTIR",
          stringsAsFactors = FALSE
        )

        # Append the data frames to the results data frame
        results <- rbind(results, results_ftir)
      }
    }
  }
}

# Adjust column names
results <- results %>%
  rename(
    "Smoothing Intensity" = smooth_intens,
    "Baseline Correction" = subtr_bg,
    "Sample Name" = top_result.sample_name,
    "Spectrum Identity" = top_result.spectrum_identity,
    "R-Value" = top_result.rsq,
    "Organization" = top_result.organization,
    "Spectrum" = type
  )

# Sort by highest to lowest R-Value
results <- results %>%
  arrange(desc(`R-Value`))

return(results)

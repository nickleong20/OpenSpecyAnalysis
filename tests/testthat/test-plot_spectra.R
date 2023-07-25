library(testthat)

# Test read_data function for supported file types
test_that("plot_spectrum function reutrns no error", {
  # Test reading each file type and check for no errors
  expect_no_error(plot_spectrum("data/testdata.csv"))
})

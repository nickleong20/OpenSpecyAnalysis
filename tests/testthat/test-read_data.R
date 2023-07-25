library(testthat)

# Test read_data function with expect_silent
test_that("Test that data reads in correctly", {

  # Test reading each file type and check for silence
  expect_no_error(read_data("data/ftir_ldpe_soil.asp"))

})

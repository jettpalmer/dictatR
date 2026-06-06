test_that("validate_dataset works", {
  data <- load_data()

  expect_invisible(validate_dataset(data))
  expect_error(validate_dataset("not a dataframe"), "data input must be a dataframe")
})



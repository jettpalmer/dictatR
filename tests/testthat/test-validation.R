test_that("validate_dataset works", {
  data <- load_data()

  expect_invisible(validate_dataset(data))
  expect_error(validate_dataset("not a dataframe"), "data input must be a dataframe")
})

test_that("validate_country works", {
  data <- load_data()

  expect_invisible(validate_country("BOL", data))

  expect_error(
    validate_country(123, dat),
    "Country code input must be a string")

  expect_error(
    validate_country("BO", dat),
    "Country code input must three letters")

  expect_error(
    validate_country("ZZZ", dat),
    "Country code not found in the dataset")
})

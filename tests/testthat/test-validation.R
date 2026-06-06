test_that("validate_dataset works", {
  data <- load_data()

  expect_invisible(validate_dataset(data))
  expect_error(validate_dataset("not a dataframe"),
               "Data input must be a dataframe")
})

test_that("validate_country works", {
  data <- load_data()

  expect_invisible(validate_country("BOL", data))

  expect_error(validate_country(123, data),
               "Country code input must be a string")

  expect_error(validate_country("BO", data),
               "Country code input must three letters")

  expect_error(validate_country("ZZZ", data),
               "Country code not found in the dataset")
})

test_that("validate_region works", {
  expect_invisible(validate_region("South Asia"))

  expect_error(validate_region(123),
               "Region input must be a string")

  expect_error(validate_region("Jett's house"),
               "Region must be one of: East Asia & Pacific, Europe & Central Asia,
    Latin America & Caribbean, Middle East & North Africa, North America,
    South Asia, Sub-Saharan Africa.")
})

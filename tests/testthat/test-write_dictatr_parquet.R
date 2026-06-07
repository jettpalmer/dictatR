test_that("write_dictatr_parquet writes parquet files", {
  skip_if_not_installed("arrow")

  out_dir <- tempfile()

  files <- write_dictatr_parquet(out_dir)

  expect_true(file.exists(files[["democracy"]]))
  expect_true(file.exists(files[["coups"]]))
  expect_true(file.exists(files[["world"]]))
})

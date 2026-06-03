test_that("prepare_survival_data works", {
  democracy_data <- load_data()

  result <- prepare_survival_data(democracy_data)

  expect_s3_class(result, "tbl_df")

})

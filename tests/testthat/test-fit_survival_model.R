test_that("fit_survival_model works", {
  democracy_data <- load_data()

  model <- fit_survival_model(democracy_data)

  expect_s3_class(model, "coxph")
})

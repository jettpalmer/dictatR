test_that("plot_country_coups outputs a class:plotly", {
  democracy_data <- load_data()
  coup_data <- load_coup_data()

  plot1 <- plot_country_coups(coup_data, democracy_data)

  expect_s3_class(plot1, c("plotly", "htmlwidget"))

  plot2 <- plot_country_coups(coup_data, democracy_data, country_of_interest="Cuba")

  expect_s3_class(plot2, c("plotly", "htmlwidget"))

  expect_error(plot_country_coups(coup_data, democracy_data, c("Cuba", "Haiti")))

  plot4 <- plot_country_coups(coup_data, democracy_data, coup_code = moreno)

  expect_s3_class(plot4, c("plotly", "htmlwidget"))

  expect_error(plot_country_coups(coup_data, democracy_data, "USA"))
})

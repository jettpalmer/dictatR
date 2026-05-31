test_that("make_regime_map outputs a class:leaflet", {
  democracy_data <- load_data()
  world_data <- load_world_data()

  regime_map <- make_regime_map(democracy_data, world_data)

  # Check object type
  expect_s3_class(regime_map, c("leaflet", "htmlwidget"))

  regime_map_no_markers <- make_regime_map(democracy_data, world_data, include_markers = FALSE)
  expect_s3_class(regime_map_no_markers, c("leaflet", "htmlwidget"))

  expect_error(make_regime_map(democracy_data, world_data, include_markers = c(FALSE, FALSE)))
})

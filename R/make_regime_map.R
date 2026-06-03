#' Gemerate an interactive leaflet map of countries colored by democratic regime, marked with regime history.
#'
#' @param democracy_data Dataset of countries' regimes to map
#' @param world_data Dataset of global country geometries from rnaturalearth package
#' @param include_markers default TRUE; includes clickable map markers with regime history
#'
#' @returns A leaflet map
#' @importFrom dplyr group_by slice_max ungroup select left_join mutate arrange filter lag summarise first
#' @importFrom sf st_transform st_point_on_surface st_coordinates
#' @importFrom leaflet colorFactor leaflet addProviderTiles addPolygons addLegend addCircleMarkers
#' @export
#'
#' @examples
#' dat <- load_data()
#' world_dat <- load_world_data()
#' make_regime_map(dat, world_dat)
make_regime_map <- function(democracy_data, world_data, include_markers=TRUE) {

  stopifnot(is.logical(include_markers), length(include_markers) <= 1)
  stopifnot(is.data.frame(democracy_data), is.data.frame(world_data))

  # Most recent year for each country, for coloring purpose
  recent <- democracy_data |>
    group_by(country_code) |>
    slice_max(year, n = 1, with_ties = FALSE) |>
    ungroup() |>
    select(country_code, year, is_democracy)

  # Combine recent democracy data with global map geometries
  # Important: this creates one row per country, not one row per country-year
  world_recent <- world_data |>
    left_join(recent, by = c("adm0_a3" = "country_code")) |>
    select(name, adm0_a3, year, is_democracy, geometry) |>
    st_transform(4326)

  # color palette for current democracy
  dem_palette <- colorFactor(
    palette = c("FALSE" = "#ee6b6e",
                "TRUE" = "steelblue"),
    domain = c(FALSE, TRUE),
    na.color = "gray"
  )

  # Collect centroids for markers
  suppressWarnings({
    centroids <- st_point_on_surface(world_recent)
    coords <- st_coordinates(centroids)
  })

  markers_coord <- centroids |>
    mutate(
      lng = coords[,1],
      lat = coords[,2]
    )
  if (include_markers) {
    # Regime History markers
    # Keep only years where regime changes
    regime_changes <- democracy_data |>
      arrange(country_code, year) |>
      group_by(country_code) |>
      mutate(prev_regime = lag(regime_category)) |>
      filter(year == min(year) | regime_category != prev_regime) |>
      ungroup()

    # HTML text for markers
    marker_data <- regime_changes |>
      arrange(country_code, year) |>
      group_by(country_code, country_name) |>
      summarise(
        regime_text = paste0(
          "<b>", first(country_name), "</b><br/>",
          paste0(year, ": ", regime_category, collapse = "<br/>")
        ),
        .groups = "drop"
      )

    # join with coords for all marker data
    markers_coord <- markers_coord |>
      left_join(marker_data, by = c("adm0_a3" = "country_code"))

    markers_coord <- markers_coord |>
      filter(!is.na(regime_text))
  }


  # Leaflet interactive Plot
  map <- leaflet(world_recent) |>
    leaflet::addProviderTiles(leaflet::providers$CartoDB.PositronNoLabels) |>
    addPolygons(
      fillColor = ~dem_palette(is_democracy),
      fillOpacity = 0.7,
      color = "white",
      weight = 1
    ) |>
    addLegend(
      position = "bottomright",
      colors = c("#ee6b6e", "steelblue"),
      values = ~is_democracy,
      title = NULL,
      labels = c("Non-Democratic", "Democratic")
    )

  if (include_markers) {
    map <- map |>
      addCircleMarkers(
      data = markers_coord,
      lng = ~lng,
      lat = ~lat,
      radius = 5,
      stroke = TRUE,
      color = "black",
      weight = 1,
      fillColor = "yellow",
      fillOpacity = 0.9,
      popup = ~regime_text
    )
  }


  map
}

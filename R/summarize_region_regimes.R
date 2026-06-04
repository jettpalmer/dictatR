#' Display summary of a region's regimes
#'
#' @param region World Bank region. Options include: "East Asia & Pacific",
#' "Europe & Central Asia",
#' "Latin America & Caribbean",
#' "Middle East & North Africa",
#' "North America",
#' "South Asia",
#' "Sub-Saharan Africa"
#' @param democracy_data Optional dataframe of countries' regimes.
#'
#' @returns A wide tibble with the proportions of regimes the region has add
#' that were of each type of governance.
#' @importFrom dplyr filter summarize n
#' @export
#'
#' @examples
#' summarize_country_regimes("East Asia & Pacific")
summarize_region_regimes <- function(region, democracy_data = load_data()) {

  validate_region(region)

  validate_dataset(democracy_data)

  democracy_data |>
    add_regions() |>
    filter(region == !!region) |>
    # Proportions of each form of governance
    summarize(total = n(),
              Democratic = sum(is_democracy, na.rm = TRUE)/n(),
              Presidential = sum(is_presidential, na.rm = TRUE)/n(),
              Monarch = sum(is_monarchy, na.rm = TRUE)/n(),
              Commonwealth = sum(is_commonwealth, na.rm = TRUE)/n(),
              Colony = sum(is_colony, na.rm = TRUE)/n(),
              Communist = sum(is_communist, na.rm = TRUE)/n()
    )
}

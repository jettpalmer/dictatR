#' Summarize country regimes
#'
#' @param democracy_data Dataset of countries' regimes to summarize from.
#' @param country Country whose regiems should be summarized.
#'
#' @returns A tibble with columns for year and new regime of each regime change.
#' @importFrom dplyr arrange group_by mutate filter lag select
#' @export
#'
#'
#' @examples
#' dat <- load_data()
#' summarize_country_regimes(dat, "United States")
summarize_country_regimes <- function(democracy_data, country = "Bolivia") {
  regime_changes <- democracy_data |>
    filter(country_name == country) |>
    arrange(year) |>
    mutate(prev_regime = lag(regime_category)) |>
    filter(year == min(year) | regime_category != prev_regime) |>
    select(Year = year,
           Regime = regime_category)
  regime_changes
}


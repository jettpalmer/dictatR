#' Display summary of a country's regimes
#'
#' @param country Three letter ISO country code.
#' @param democracy_data Optional dataframe of countries' regimes.
#'
#' @returns A tibble with a row for each regime change the country has had
#' and columns for the year and new regime of the change.
#' @importFrom dplyr arrange group_by mutate filter lag select
#' @export
#'
#' @examples
#' summarize_country_regimes("BOL")
summarize_country_regimes <- function(country, democracy_data = load_data()) {

  validate_country(country, democracy_data)

  validate_dataset(democracy_data)

  democracy_data |>
    filter(country_code == country) |>
    arrange(year) |>
    mutate(prev_regime = lag(regime_category)) |>
    filter(year == min(year) | regime_category != prev_regime) |>
    select(Year = year,
           Regime = regime_category)
}


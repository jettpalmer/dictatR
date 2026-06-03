#' Prepare survival data for democracy analysis
#'
#' Converts country-year democracy data into one row per non-democratic spell,
#' suitable for survival analysis of return to democracy.
#'
#' @param democracy_data A tibble containing democracy and dictatorship data.
#'
#' @return A tibble containing one row per non-democratic spell, including
#' country code, spell identifier, spell duration, whether democracy returned,
#' region, and regime characteristics.
#'
#' @importFrom dplyr arrange group_by mutate lag lead filter select summarize ungroup left_join any_of
#' @export
#'
#' @examples
#' democracy_data <- load_data()
#' survival_data <- prepare_survival_data(democracy_data)
#' head(survival_data)

prepare_survival_data <- function(democracy_data) {
  survival_base <- democracy_data |>
    dplyr::arrange(.data$country_code, .data$year) |>
    dplyr::group_by(.data$country_code) |>
    dplyr::mutate(lost_democracy = .data$is_democracy == FALSE &
                    dplyr::lag(.data$is_democracy, default = TRUE),
                  spell_id = cumsum(.data$lost_democracy),
                  next_is_democracy = dplyr::lead(.data$is_democracy))

  spell_starts <- survival_base |>
    dplyr::filter(.data$lost_democracy == TRUE) |>
    dplyr::select("country_code",
                  "spell_id",
                  "is_communist",
                  "is_multiparty")

  survival <- survival_base |>
    dplyr::filter(.data$is_democracy == FALSE) |>
    dplyr::group_by(.data$country_code, .data$spell_id) |>
    dplyr::summarize(start_year = min(.data$year),
                     end_year = max(.data$year),
                     returned_to_democracy = any(.data$next_is_democracy == TRUE, na.rm = TRUE),
                     time = .data$end_year - .data$start_year + 1,
                     .groups = "drop") |>
    dplyr::left_join(spell_starts,
                     by = c("country_code", "spell_id"))

  survival
}

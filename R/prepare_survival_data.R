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
#' @importFrom dplyr arrange group_by mutate lag cumsum lead filter select summarize ungroup left_join any_of
#' @export
#'
#' @examples
#' democracy_data <- load_data()
#' survival_data <- prepare_survival_data(democracy_data)
#' head(survival_data)
prepare_survival_data <- function(democracy_data) {

}

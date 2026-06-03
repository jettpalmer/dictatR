#' Fit a survival model for return to democracy
#'
#' Fits a Cox proportional hazards model predicting the time until a
#' non-democratic regime returns to democracy. The model includes indicators
#' for communist and multiparty regimes, is stratified by region, and clusters
#' standard errors by country.
#'
#' @param democracy_data A tibble containing democracy and dictatorship data.
#'
#' @return A fitted Cox proportional hazards model object of class `"coxph"`.
#'
#' @importFrom survival Surv coxph
#' @export
#'
#' @examples
#' democracy_data <- load_data()
#' model <- fit_survival_model(democracy_data)
#' summary(model)
fit_survival_model <- function(democracy_data) {

  survival_data <- prepare_survival_data(democracy_data)

  survival::coxph(survival::Surv(time, returned_to_democracy) ~
                    is_communist +
                    is_multiparty +
                    strata(region) +
                    cluster(country_code),
                  data = survival_data)
}

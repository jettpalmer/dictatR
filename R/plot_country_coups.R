#' Create a plotly plot graphing the coup attempts of a certain country.
#'
#' @param coup_data Optional dataframe of coup d'etat data from
#' @param democracy_data Optional dataframe of countries' regimes.
#' @param country_of_interest character value with the full name of the country to plot
#' @param coup_code Optional column name of the coup coding scheme to use. Default is Powell and Thyne. See https://www.uky.edu/~clthyn2/coup_data/Codebook.pdf for more options.
#'
#' @returns A plotly plot
#' @importFrom dplyr filter arrange mutate row_number if_else left_join group_by lead ungroup
#' @importFrom tidyr drop_na
#' @importFrom stringr str_glue
#' @importFrom ggplot2 ggplot aes geom_line geom_point scale_color_manual labs theme_minimal theme
#' @importFrom plotly ggplotly
#' @export
#'
#' @examples
#' dat <- load_data()
#' coup_dat <- load_coup_data()
#' plot_country_coups(coup_dat, dat, country_of_interest="Haiti", coup_code=verified)
plot_country_coups <- function(coup_data = load_coup_data(), democracy_data = load_data(), country_of_interest = "Bolivia", coup_code = verified) {

  stopifnot(is.character(country_of_interest))
  if (!is.character(country_of_interest)) {
    stop("country_of_interest must be a character", call. = TRUE)
  }
  if (length(country_of_interest)!=1) {
    stop("country_of_interest must be only one country", call. = TRUE)
  }
  validate_dataset(coup_data)
  validate_dataset(democracy_data)
  if (!country_of_interest %in% unique(coup_data$country)) {
    stop(paste(
      "Error: Country not found, avaliable countries included:",
      paste(unique(coup_data$country), collapse = ", ")
    ))
  }

  # Prepare data for plotting; join w/ coup data
  plot_data <- coup_data |>
      filter(country == country_of_interest) |>
      drop_na({{ coup_code }}) |>
      arrange(year, month, day) |>
      mutate(coup_number = row_number(),
             coup_result = if_else({{ coup_code }} == 2, "Successful", "Unsuccessful")) |>
      left_join(democracy_data |>
                  arrange(country_name, year) |>
                  group_by(country_name) |>
                  mutate(regime_after = lead(regime_category)) |>
                  ungroup(),
                by = c("country" = "country_name", "year" = "year")) |>
      mutate(hover_text = str_glue("Country: {country}<br>",
                                   "Date: {month}-{day}-{year}<br>",
                                   "Coup Attempt #: {coup_number}<br>",
                                   "Result: {coup_result}<br>",
                                   "Regime Before: {regime_category}<br>",
                                   "Regime After: {regime_after}"))
    # Create plot
    plot <- plot_data |>
      ggplot(aes(x = year,
                 y = coup_number,
                 color = coup_result,
                 text = hover_text,
                 group = 1)) +
      geom_line(color = "gray60") +
      geom_point(size = 3) +
      scale_color_manual(values = c("Successful" = "#ee6b6e",
                                    "Unsuccessful" = "steelblue")) +
      labs(title = paste(country_of_interest, "Coup d'états (<span style='color:#ee6b6e;'>Successful</span> & <span style='color:steelblue;'>Unsuccessful</span>)"),
           y = "Count",
           x = "Year") +
      theme_minimal() +
      theme(legend.position = "none")

    # Plug into plotly
    ggplotly(plot, tooltip = "text")

}

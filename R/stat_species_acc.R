#' @rdname stat_species_acc
#' @format NULL
#' @usage NULL
#' @export

StatSpeciesAcc <- ggplot2::ggproto(
  "StatSpeciesAcc",
  ggplot2::Stat,
  compute_group = function(data, scales) {
    data[sample(nrow(data)), ] |>
      tibble::rowid_to_column(var = "x") |>
      dplyr::select(x, species_key) |>
      dplyr::distinct(species_key, .keep_all = TRUE) |>
      tibble::rowid_to_column(var = "y")
  },

  required_aes = c("species_key")
)

#' Species accumulation curve
#'
#' @description
#' This implements a very simple way of calculating a species accumulation
#' curve. It
#' 1. randomizes the order of the rows in the dataframe
#' 2. numbers each row (column x)
#' 3. removes all rows except the first instance of each species
#' 4. numbers each row again (column y)
#' This gives you the two columns needed to make a species accumulation
#' curve: number of observations (x) and total number of species (y)
#'
#' @importFrom tibble tibble
#' @importFrom dplyr distinct
#' @param geom Override the default geom of "point" with others, like "smooth"
#'
#' @inheritParams ggplot2::geom_point
#'
#' @aesthetics StatSpeciesAcc
#' species_key is the column specifying the species of each observation record (row)
#'
#' @returns A ggplot2 object
#' @export
#'
#' @examples
#' df <-
#' tibble::tibble(
#'   speciesKey = runif(1000, 0, 300) |>
#'     round(),
#'   region = runif(1000, 1, 2) |>
#'     round() |>
#'     factor()
#' )
#' ggplot2::ggplot(df, ggplot2::aes(species_key = speciesKey)) +
#'   stat_species_acc() +
#'   ggplot2::labs(y = "Species", x = "Observations")
#' ggplot2::ggplot(df, ggplot2::aes(species_key = speciesKey, colour = region)) +
#'   stat_species_acc(geom = "smooth") +
#'   ggplot2::labs(y = "Species", x = "Observations")

stat_species_acc <- ggplot2::make_constructor(StatSpeciesAcc, geom = "point")

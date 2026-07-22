test_that("stat_species_acc works", {
  df <-
    tibble::tibble(
      speciesKey = runif(1000, 0, 300) |>
        round()
    )

  sa_plot <-
    ggplot2::ggplot(df, ggplot2::aes(species_key = speciesKey)) +
    stat_species_acc() +
    ggplot2::labs(y = "Species", x = "Observations")

  testthat::expect_s7_class(sa_plot, S7::S7_class(ggplot2::ggplot()))
})

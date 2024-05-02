test_that("kas style can be added to example plot", {
  withr::local_package("ggplot2")
  # plot examples from helper.R
  expect_equal(plot_example() + kas_style(), styled_example())
})

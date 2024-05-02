test_that("correct colour scheme chosen based on n", {
  expect_equal(color_picker(3)[2], "#D67D00")
})

test_that("both n and colour list input resolve to same", {
  expect_equal(
    color_picker(3),
    color_picker(c("series1", "series2", "series3"))
  )
})

test_that("primary colour scheme chosen", {
  expect_equal(color_picker(3, primary_palette = TRUE)[2], "#5D99C6")
})

test_that("primary colour scheme chosen", {
  expect_error(color_picker(15))
})

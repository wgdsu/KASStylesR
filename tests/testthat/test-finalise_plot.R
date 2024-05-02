test_that("can create charts into workspace", {
  # warnings may be created when the package version != R version
  withr::local_package("ggplot2")
  withr::local_package("openxlsx")
  withr::local_package("svglite")
  temp_dir <- tempdir()
  # plot example from helper.R
  expect_silent(save_list_of_charts_to_folder(
    c("chart1", "chart2"),
    list(
      plot_example(),
      plot_example()
    ), temp_dir
  ))

  # checks the above charts have been saved to the correct folder
  expect_equal(length(list.files(paste0(temp_dir, "\\charts"))), 2)

  # succeeds on chart1.svg being created
  expect_true("chart1.svg" %in% list.files(paste0(temp_dir, "\\charts")))
  expect_true("chart2.svg" %in% list.files(paste0(temp_dir, "\\charts")))

  # delete files created in temp_dir
  file.remove(paste0(temp_dir, "\\charts\\chart1.svg"))
  file.remove(paste0(temp_dir, "\\charts\\chart2.svg"))
})

test_that("Can save existing svg files into workbook", {
  # warnings may be created when the package version != R version
  withr::local_package("ggplot2")
  withr::local_package("openxlsx")
  withr::local_package("svglite")
  # resetting environment for following workbook test
  temp_dir <- tempdir()
  ggsave(paste0(temp_dir, "\\charts\\chart1.svg"), plot_example())
  ggsave(paste0(temp_dir, "\\charts\\chart2.svg"), plot_example())

  # function doesn't fail on incomplete/unequal parameters
  expect_silent(chart_folder_to_workbook(
    temp_dir, "chart_workbook", c("chart1", "chart2"), c("title1", "title2"),
    c("source1", "source2"), c("alt text1", "alt text2")
  ))

  # succeeds on chart_workbook existing
  expect_true("chart_workbook.xlsx" %in% list.files(temp_dir))

  wb <- loadWorkbook(paste0(temp_dir, "\\chart_workbook.xlsx"))
  # check both charts created in each tab
  expect_equal(names(wb), c("chart1", "chart2"))

  # succeeds on correct title, source and alt-text
  expect_equal("title1", names(read.xlsx(wb, sheet = "chart1")))
  expect_equal(
    c("source1", "alt text1"),
    c(read.xlsx(wb, sheet = "chart1"))$title1
  )

  # delete files created in temp_dir
  file.remove(paste0(temp_dir, "\\charts\\chart1.svg"))
  file.remove(paste0(temp_dir, "\\charts\\chart2.svg"))
  file.remove(paste0(temp_dir, "\\chart_workbook.xlsx"))
})

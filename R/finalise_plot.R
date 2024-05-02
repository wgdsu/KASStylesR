#' Finalising plots for release, the finalise plot function alone will save a
#' plot in a safe size, with the extension being SVG for accessibility/usability
#'
#' @param plot The plot to save
#' @param name The plot name to save as (no file extension needed)
#' @param path The file path to save the plot on
#' @param width The width of the chart
#' @param height The height of the chart
#' @import ggplot2
#' @export
#'
#' @examples
#' example_chart <- ggplot2::ggplot(data = iris) +
#'   ggplot2::aes(x = Petal.Length, y = Petal.Width) +
#'   ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species))
#'
#' dir.create("./charts")
#' finalise_plot("chart_six", example_chart, "./charts/")
finalise_plot <- function(name, plot, path, width = 17.6, height = 16.5) {
  ggsave(paste0(name, ".svg"), plot,
    device = "svg", path = path, width = width,
    units = "cm", height = height
  )
}


#' Function to create an Excel workbook to save charts to
#' @examples
#' workbook <- build_release_charts_doc("charts")
#' @param workbook_name The name of the excel workbook to create
#' @return initialised Excel workbook
#' @import openxlsx
#' @export
build_release_charts_doc <- function(workbook_name) {
  return(createWorkbook(workbook_name))
}


#' Function to add chart to a release file with all charts in
#'
#' @param workbook The workbook to add chart to
#' @param chart_name The chart name (to use as tab name)
#' @param chart_path The path to the chart
#' @param title The title of the chart
#' @param source The source of the information
#' @param alt_text The alt text to use
#' @param height The height of the chart in cm
#' @import ggplot2
#' @import openxlsx
#' @examples
#'
#' example_chart <- ggplot2::ggplot(data = iris) +
#'   ggplot2::aes(x = Petal.Length, y = Petal.Width) +
#'   ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species))
#'
#' dir.create("./charts")
#' finalise_plot("chart_six", example_chart, "./charts/")
#' workbook <- build_release_charts_doc("./charts_book.xlsx")
#' title_one <- "Chart Six: Life expectancy by year in the United Kingdom,
#' 1952-2007"
#' chart_path_one <- "./charts/chart_six.svg"
#' source_one <- "Gapminder"
#' alt_one <- "The life expectancy in the UK has risen steadily between
#' 1952 and 2007."
#' add_chart_to_release(
#'   workbook, "Chart Six", chart_path_one, title_one,
#'   source_one, alt_one
#' )

#' @export
add_chart_to_release <- function(workbook, chart_name, chart_path, title,
                                 source, alt_text, height = 16.5) {
  # add worksheet for the new chart
  addWorksheet(workbook, chart_name)

  # insert the chart image with the set height
  insertImage(
    workbook,
    chart_name,
    chart_path,
    width = 17.6,
    height = height,
    startRow = 3,
    startCol = 1,
    units = "cm",
    dpi = 300
  )

  # style objects for the title and body elements
  title_style <- createStyle(
    fontName = "Arial", fontSize = 14,
    fontColour = "#000000", textDecoration = "bold"
  )
  body_style <- createStyle(
    fontName = "Arial", fontSize = 12,
    fontColour = "#000000", wrapText = TRUE
  )

  # write the chart title in the first cell
  writeData(
    workbook,
    chart_name,
    title,
    startCol = 1,
    startRow = 1
  )

  # add the title style
  addStyle(workbook, chart_name, title_style, 1, 1)

  # write the alt text below the chart
  writeData(
    workbook,
    chart_name,
    alt_text,
    startCol = 1,
    startRow = round((height / 0.5) + 2) + 1
  )

  # add the body style
  addStyle(workbook, chart_name, body_style, round((height / 0.5) + 2) + 1, 1)

  # add the source and style it
  writeData(
    workbook,
    chart_name,
    source,
    startCol = 1,
    startRow = round((height / 0.5) + 2)
  )


  addStyle(workbook, chart_name, body_style, round((height / 0.5) + 2), 1)
}


#' Function to finalise a workbook saving it on the file path provided
#' @param workbook The workbook object created earlier
#' @param path The path to save the workbook on
#' @import openxlsx
#' @examples
#' workbook <- build_release_charts_doc("/charts_book.xlsx")
#' finalise_workbook(workbook, "charts.xlsx")
#' @export
finalise_workbook <- function(workbook, path) {
  saveWorkbook(workbook, path, overwrite = TRUE, returnValue = FALSE)
}

#' Function to add chart to a release folder with all charts in
#'
#' @param chart_names_list List of the chart names (to use as file name)
#' @param charts_list List of chart objects
#' @param project_area The file path to save charts into (for charts saved in 
#' the current directory use ".")
#' @param width Width of plots
#' @param height Height of plots
#' @import openxlsx
#' @examples
#' chart_one <- ggplot2::ggplot(data = iris) +
#'   ggplot2::aes(x = Petal.Length, y = Petal.Width) +
#'   ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species))
#' chart_two <- ggplot2::ggplot(data = iris) +
#'   ggplot2::aes(x = Petal.Length, y = Petal.Width) +
#'   ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species))
#'
#' chart_names_list <- c("Chart 1", "Chart 2")
#' charts_list <- list(chart_one, chart_two)
#' project_area <- "./"
#' save_list_of_charts_to_folder(chart_names_list, charts_list, project_area)
#' @export
save_list_of_charts_to_folder <- function(chart_names_list, charts_list,
                                          project_area='.', width = 17.6,
                                          height = 16.5) {
  # chart_names_list is a list (create with c()) of ggplot chart objects
  # charts_list is a list of chart names, the charts will be saved by
  # these names as svg files
  # project area is your local file name for this project

  # exit if length chart_names_list /= charts_list
  if (length(chart_names_list) != length(charts_list)) {
    print("The number of chart names and charts selected are not equal. Please
          check these variables.")
    stop()
  }

  # The following creates a chart folder within the project area if
  # one does not already exist
  if (file.exists(paste0(project_area, "/charts")) == FALSE) {
    dir.create(file.path(project_area, "charts", fsep = "\\"))
  }


  for (index in seq(length(chart_names_list))) {
    name <- chart_names_list[index]
    # double square brackets are necessary
    plot <- charts_list[[index]]
    path <- paste0(project_area, "/charts\\")

    finalise_plot(name, plot, path, width, height)
  }
}


#' Function to add chart to a release file with all charts in
#'
#' @param project_area The filepath to save the work in a charts folder (for 
#' charts saved in current directory use ".")
#' @param workbook_name Name of Excel workbook to save charts in
#' @param chart_names_list List of the chart names (to use as Tab name)
#' @param titles_list List of titles use as chart titles in order
#' @param sources_list List of chart sources in order
#' @param alt_texts_list List of alt text in order for the plots
#' @import openxlsx
#' @examples
#'
#' colors <- color_picker(3)
#' example_chart <- ggplot2::ggplot(data = iris) +
#'   ggplot2::aes(x = Petal.Length, y = Petal.Width) +
#'   ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species)) +
#'   kas_style()
#' dir.create("./charts")
#' finalise_plot("chart_six", example_chart, "./charts/")
#'
#' title_one <- "Petal length and width by species"
#' chart_path_one <- "./charts/chart_six.svg"
#' source_one <- "Iris"
#' alt_one <- "Petal length and width has a positive association"

#' chart_folder_to_workbook(
#'   "./", "charts.xlsx", c("chart_six"),
#'   c(title_one), c(source_one), c(alt_one)
#' )
#' @export
chart_folder_to_workbook <- function(project_area, workbook_name,
                                     chart_names_list, titles_list,
                                     sources_list, alt_texts_list) {
  # charts_folder_path is the 'charts' folder created in
  # save_list_of_charts_to_folder
  charts_folder_path <- paste0(project_area, "/charts")
  workbook <- build_release_charts_doc(workbook_name)


  # take number and names of png objects in charts folder (index is int),
  # then loop through
  for (chart_name in chart_names_list) {
    index <- match(chart_name, chart_names_list)
    file_path <- paste0(charts_folder_path, "\\", chart_name, ".svg")
    title <- titles_list[index]
    source <- sources_list[index]
    alt_text <- alt_texts_list[index]
    add_chart_to_release(
      workbook, chart_name, file_path, title, source,
      alt_text
    )
    finalise_workbook(workbook, paste0(
      dirname(charts_folder_path), "/",
      workbook_name, ".xlsx"
    ))
  }
}

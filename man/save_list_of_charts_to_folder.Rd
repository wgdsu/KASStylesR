% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/finalise_plot.R
\name{save_list_of_charts_to_folder}
\alias{save_list_of_charts_to_folder}
\title{Function to add chart to a release folder with all charts in}
\usage{
save_list_of_charts_to_folder(
  chart_names_list,
  charts_list,
  project_area = ".",
  width = 17.6,
  height = 16.5
)
}
\arguments{
\item{chart_names_list}{List of the chart names (to use as file name)}

\item{charts_list}{List of chart objects}

\item{project_area}{The file path to save charts into (for charts saved in
the current directory use ".")}

\item{width}{Width of plots}

\item{height}{Height of plots}
}
\description{
Function to add chart to a release folder with all charts in
}
\examples{
chart_one <- ggplot2::ggplot(data = iris) +
  ggplot2::aes(x = Petal.Length, y = Petal.Width) +
  ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species))
chart_two <- ggplot2::ggplot(data = iris) +
  ggplot2::aes(x = Petal.Length, y = Petal.Width) +
  ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species))

chart_names_list <- c("Chart 1", "Chart 2")
charts_list <- list(chart_one, chart_two)
project_area <- "./"
save_list_of_charts_to_folder(chart_names_list, charts_list, project_area)
}

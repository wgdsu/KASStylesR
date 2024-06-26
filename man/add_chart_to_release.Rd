% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/finalise_plot.R
\name{add_chart_to_release}
\alias{add_chart_to_release}
\title{Function to add chart to a release file with all charts in}
\usage{
add_chart_to_release(
  workbook,
  chart_name,
  chart_path,
  title,
  source,
  alt_text,
  height = 16.5
)
}
\arguments{
\item{workbook}{The workbook to add chart to}

\item{chart_name}{The chart name (to use as tab name)}

\item{chart_path}{The path to the chart}

\item{title}{The title of the chart}

\item{source}{The source of the information}

\item{alt_text}{The alt text to use}

\item{height}{The height of the chart in cm}
}
\description{
Function to add chart to a release file with all charts in
}
\examples{

example_chart <- ggplot2::ggplot(data = iris) +
  ggplot2::aes(x = Petal.Length, y = Petal.Width) +
  ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species))

dir.create("./charts")
finalise_plot("chart_six", example_chart, "./charts/")
workbook <- build_release_charts_doc("./charts_book.xlsx")
title_one <- "Chart Six: Life expectancy by year in the United Kingdom,
1952-2007"
chart_path_one <- "./charts/chart_six.svg"
source_one <- "Gapminder"
alt_one <- "The life expectancy in the UK has risen steadily between
1952 and 2007."
add_chart_to_release(
  workbook, "Chart Six", chart_path_one, title_one,
  source_one, alt_one
)
}

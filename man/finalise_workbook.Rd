% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/finalise_plot.R
\name{finalise_workbook}
\alias{finalise_workbook}
\title{Function to finalise a workbook saving it on the file path provided}
\usage{
finalise_workbook(workbook, path)
}
\arguments{
\item{workbook}{The workbook object created earlier}

\item{path}{The path to save the workbook on}
}
\description{
Function to finalise a workbook saving it on the file path provided
}
\examples{
workbook <- build_release_charts_doc("/charts_book.xlsx")
finalise_workbook(workbook, "charts.xlsx")
}

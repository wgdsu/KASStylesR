#' Function returns a list of colors to use in a chart bound to a category. With
#' error handling to warn users if too many colours are
#' being used with a certain
#' palette.
#' @param categories The list of categories in to assign colors to for the chart
#' @param primary_palette Boolean indicator of whether to use the primary colour
#' palette or not (T/F)
#' @return list of colours matched to a category
#' @examples
#' color_picker(3)
#' color_picker(c("series1", "series2", "series3"), primary_palette = TRUE)
#' @export

color_picker <- function(categories, primary_palette = FALSE) {
  multi_colors <- list(
    "#003D6B",
    "#D67D00",
    "#850018",
    "#57A0A2",
    "#310B4A",
    "#B154AC",
    "#18150C",
    "#89966D"
  )
  primary_colors <- list(
    "#003D6B",
    "#5D99C6",
    "#071527"
  )

  # matches categories, whether integer or actual categories passed, to the
  # number of colours required
  to <- ifelse(is.numeric(categories), categories, length(categories))


  # error handle more than 8 categories
  if (to > 8) {
    print("Error only 8 categories can be used in accordance with best practice.
          To override this more colours need to be added to the color_picker.R
          script and used manually. Alternatively, visualisations using facet
          columns/rows could be more accessible.")
    stop()
  }

  colors <- if (primary_palette == FALSE) {
    # Give warning (not an error) if more than 3 categories selected
    # (best practice), still returns colours
    if (to > 4) {
      warning("Best practice warning: More than 4 colours selected.
              Colours still added")
    }
    multi_colors[1:to]
  } else {
    # If primary colour theme and more than 3 items to colour, output switches
    # to multicolour theme
    if (to > 3) {
      warning("More than 3 items selected with Primary theme,
              returning chart with the multicolour theme")
      multi_colors[1:to]
    } else {
      # Primary colour theme is used
      primary_colors[1:to]
    }
  }

  return(unlist(colors))
}

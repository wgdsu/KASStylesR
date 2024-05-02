#' Add KAS theme to ggplot chart
#'
#' This function allows you to add the KAS theme to your ggplot graphics.
#' @keywords kas_style
#' @import ggplot2
#' @examples
#' example_chart <- ggplot2::ggplot(data = iris) +
#'   ggplot2::aes(x = Petal.Length, y = Petal.Width) +
#'   ggplot2::geom_point(ggplot2::aes(color = Species, shape = Species)) +
#'   kas_style()
#' @export

kas_style <- function() {
  font <- "sans"
  base_size <- 12
  half_line <- base_size / 2

  ggplot2::theme(

    # Text format:
    # This sets the font, size, type and colour of text for the chart's title
    plot.title = ggplot2::element_text(
      family = font,
      size = 18,
      face = "bold",
      color = "#000000"
    ),
    plot.title.position = "panel",
    
    # This sets the font, size, type and colour of text for the chart's
    # subtitle, as well as setting a margin between the title and the subtitle
    plot.subtitle = ggplot2::element_text(
      family = font,
      size = 12,
      margin = ggplot2::margin(9, 0, 9, 0)
    ),
    plot.caption = ggplot2::element_blank(),
    plot.margin = margin(half_line, half_line, half_line, half_line),
    
    
    # This leaves the caption text element empty, because it is set elsewhere
    # in the finalise plot function
    text = element_text(
      face = "plain", # Can be plain, italic, bold, bold.italic
      colour = "black",
      lineheight = 0.9,
      hjust = 0.5, # Determine x-axis label position
      vjust = 0.5, # determines y-axis label position
      angle = 0,
      margin = margin(),
      debug = FALSE
    ),
    
    # Legend format
    # This sets the position and alignment of the legend, removes a title
    # and backround for it and sets the requirements for any text within the
    # legend. The legend may often need some more manual tweaking when it comes
    # to its exact position based on the plot coordinates.
    legend.position = "right",
    legend.text.align = 0,
    legend.background = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(
      family = font,
      size = 12,
      color = "#000000"
    ),

    # Axis format
    # This sets the text font, size and colour for the axis test,
    # as well as setting the margins and removes lines and ticks.
    # In some cases, axis lines and axis ticks are things we would want to
    # have in the chart - the cookbook shows examples of how to do so.
    axis.text = ggplot2::element_text(
      family = font,
      size = 12,
      color = "#000000"
    ),
    axis.text.x = element_text(
      margin = margin(t = 0.8 * half_line / 4),
      vjust = 1
    ),
    axis.text.x.top = element_text(
      margin = margin(b = 0.8 * half_line / 4),
      vjust = 0
    ),
    axis.text.y = element_text(
      margin = margin(r = 0.8 * half_line / 4),
      hjust = 1
    ),
    axis.text.y.right = element_text(
      margin = margin(l = 0.8 * half_line / 4),
      hjust = 0
    ),

    # now setting small ticks for x axis
    axis.ticks = element_line(colour = "black"), # "grey85"
    axis.ticks.length = unit(half_line / 2, "pt"),

  
    axis.line = element_blank(),
    axis.title.x = element_text(
      margin = margin(t = half_line / 2),
      vjust = 1, face = "bold"
    ),
    axis.title.x.top = element_text(
      margin = margin(b = half_line / 2),
      vjust = 0
    ),
    axis.title.y = element_text(
      angle = 90, margin = margin(r = half_line / 2),
      vjust = 1, face = "bold"
    ),
    axis.title.y.right = element_text(
      angle = -90,
      margin = margin(l = half_line / 2),
      vjust = 0
    ),

    # Grid lines
    # This removes all minor gridlines and adds major y gridlines.
    # In many cases you will want to change this to remove y gridlines and
    # add x gridlines. The cookbook shows you examples for doing so
    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(
      linewidth = rel(0.5),
      color = "gray85"
    ),
    panel.grid.major.x = ggplot2::element_blank(),
    panel.spacing = unit(half_line, "pt"),
    panel.ontop = FALSE,

    # Blank background
    # This sets the panel background as blank,
    # removing the standard grey ggplot background colour from the plot
    panel.background = element_rect(fill = "white", colour = NA),

    # Strip background (This sets the panel background for
    # facet-wrapped plots to white, removing the standard grey ggplot background
    # colour and sets the title size of the facet-wrap title to font size 22)
    strip.background = element_rect(fill = "grey85", colour = NA),
    strip.text = ggplot2::element_text(
      size = 12, hjust = 0,
      margin = margin(0.8 * half_line, 0.8 * half_line, 0.8 * half_line, 0.8
      * half_line)
    ),
    strip.text.y = element_text(angle = -90),
    strip.text.y.left = element_text(angle = 90),
    strip.placement = "inside",
    strip.switch.pad.grid = unit(half_line / 2, "pt"),
    strip.switch.pad.wrap = unit(half_line / 2, "pt"),
    plot.background = element_rect(colour = "white"),
  )
}

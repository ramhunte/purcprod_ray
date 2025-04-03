# setting aesthetics of plot

# line colors
line_col <- c(
  "All production" = "black",
  "Groundfish production" = '#C1052F',
  "Pacific whiting" = '#D89B2C',
  "Non-whiting groundfish" = '#C0CB81',
  "Sablefish" = '#648C1C',
  "Rockfish" = '#6FB1C9',
  "Dover sole" = '#001B70',
  "Petrale sole" = '#595478',
  "Thornyheads" = '#C0B3B6',
  "Other groundfish species" = '#B56C97',
  "Other species production" = '#C1052F',
  "Crab" = '#D89B2C',
  "Shrimp" = '#C0CB81',
  "Salmon" = '#648C1C',
  "Tuna" = '#6FB1C9',
  "Coastal pelagics" = '#001B70',
  "Other shellfish" = '#595478',
  "Other species" = '#C0B3B6',
  "California" = '#001B70',
  "Washington and Oregon" = '#C1052F',
  "Small" = '#001B70',
  "Medium" = '#C1052F',
  "Large" = '#648C1C',
  "Non-processor" = '#D89B2C'
)

# line type
line_ty <- c(
  "California" = 'solid',
  "Washington and Oregon" = 'solid',
  "Small" = 'solid',
  "Medium" = 'solid',
  "Large" = 'solid',
  "Non-processor" = 'solid',
  "All production" = "solid",
  "Groundfish production" = 'solid',
  "Pacific whiting" = 'solid',
  "Non-whiting groundfish" = 'solid',
  "Sablefish" = 'solid',
  "Rockfish" = 'solid',
  "Dover sole" = 'solid',
  "Petrale sole" = 'solid',
  "Thornyheads" = 'solid',
  "Other groundfish species" = 'solid',
  "Other species production" = 'dashed',
  "Crab" = 'dashed',
  "Shrimp" = 'dashed',
  "Salmon" = 'dashed',
  "Tuna" = 'dashed',
  "Coastal pelagics" = 'dashed',
  "Other shellfish" = 'dashed',
  "Other species" = 'dashed'
)

##Defining standard plot elements
point_size <- 4
line_size <- 0.75

# function for making gggplot
plot_func <- function(data, lab) {
  # return nothing if plot is Null
  if (is.null(data)) {
    return()
  }

  # ggplot code
  ggplot(data, aes(x = year, y = value, group = variable)) +
    scale_fill_manual(values = line_col) +
    scale_color_manual(values = line_col) +
    scale_linetype_manual(values = line_ty) +
    theme_minimal() +
    theme(
      text = element_text(size = 14),
      axis.text = element_text(size = 12),
      strip.text = element_text(size = 14)
    ) +
    geom_point(aes(color = variable), size = point_size) +
    geom_line(
      aes(color = variable, linetype = variable),
      size = line_size
    ) +
    geom_ribbon(
      aes(ymax = upper, ymin = lower, fill = variable),
      alpha = .25
    ) +
    facet_wrap(~ylab, scales = 'free_y', ncol = 2) +
    labs(y = lab) +
    scale_x_continuous(breaks = pretty_breaks())
}

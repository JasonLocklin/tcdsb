# TCDSB Diverging Plots - Other A function to create plots of other responses (i.e. Missing, Neutral) to pair with TCDSB Diverging Plots

TCDSB Diverging Plots - Other A function to create plots of other
responses (i.e. Missing, Neutral) to pair with TCDSB Diverging Plots

## Usage

``` r
tcdsb_diverge_plot_other_function(
  df,
  group_col,
  response_col,
  percent_col,
  label,
  font = "Century Gothic",
  bar_color = "grey70",
  label_width = 30,
  legend_width = 10,
  x_max = 1,
  font_size = 1,
  bar_width = 0.75
)
```

## Arguments

- df:

  Data frame in long format

- group_col:

  Column with groups

- response_col:

  Column with responses

- percent_col:

  Column with percentages

- label:

  Label for chart

- font:

  Font

- bar_color:

  Bar color (defaults to grey)

- label_width:

  Width of labels

- legend_width:

  Width of legend

- x_max:

  Max of x-axis. Can be adjusted for appearance

- font_size:

  Font size scale - base is 1

- bar_width:

  Width of bars

## Value

A ggplot to be paired with tcdsb_diverge_plot

## Examples

``` r
# Not run
# df |>
#   dplyr::filter(response == "Neutral") |>
#   tcdsb_diverge_plot_other_function(
#     group_col = Question,
#     response_col = response,
#     percent_col = percent,
#     label = "Neutral"
#     )
```

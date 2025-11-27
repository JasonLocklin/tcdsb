# TCDSB Diverging Plots A function that creates a diverging bar chart, using 2, 4 or 6 factor levels.

TCDSB Diverging Plots A function that creates a diverging bar chart,
using 2, 4 or 6 factor levels.

## Usage

``` r
tcdsb_diverge_plot_function(
  df,
  group_col,
  response_col,
  fct_levels,
  percent_col = percent,
  label_width = 30,
  font = "Century Gothic",
  low_colour = "#8EB8C2",
  high_colour = "#d2a940",
  font_size = 1,
  left_label = "Left Label",
  right_label = "Right Label",
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

- fct_levels:

  Factor levels

- percent_col:

  Column with percentages

- label_width:

  Width of labels

- font:

  Font

- low_colour:

  Low end colour

- high_colour:

  High end colour

- font_size:

  Font size scale - base is 1

- left_label:

  Left hand label

- right_label:

  Right hand label

- bar_width:

  Width of bars

## Value

A ggplot object

## Examples

``` r
# Not run
# df |>
#   tcdsb_diverge_plot_function(
#     group_col = Question,
#     response_col = response,
#     percent_col = percent,
#     fct_levels = c("Strongly Disagree", "Disagree", "Agree", "Strongly Agree"))
```

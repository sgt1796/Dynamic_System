# Visualization of Function `f(a, b, c)` Mapping from R^3 to R

This directory contains a script to generate and visualize the behavior of an unknown function `f(a, b, c)` that maps from R^3 to R. The script computes the values of the function for a range of parameters and visualizes the results using `ggplot2` and `plotly`.

## Requirements

- R
- `ggplot2` package for static plotting
- `plotly` package for interactive plotting
- `dplyr` package for data manipulation
- `tibble` package for creating data frames
- `reshape2` package for reshaping data
- `tidyr` package for tidying data

You can install the required packages using:
```R
install.packages(c("ggplot2", "plotly", "dplyr", "tibble", "reshape2", "tidyr"))
```

## Usage

To run the script, simply execute it in your R environment. The script performs the following tasks:

1. Defines the range of parameters `a`, `b`, and `c`.
2. Computes the values of the function `f(a, b, c)` over the specified range.
3. Stores the computed values in a data frame.
4. Visualizes the results using `ggplot2` and `plotly`.

## Script Details

### Parameters

- `a.max`: Maximum value of parameter `a` (default: 1000).
- `b`: Range of parameter `b` (default: 1 to 20).
- `c`: Range of parameter `c` (default: 1 to 20).

### Function Calculation

The script calculates the function values using the formula:
`f(a, b, c) = (a^2 * b - b) mod c`

### Data Frame Construction

The computed values are stored in a data frame with columns for `a`, `b`, `c`, and the computed function value.

### Visualization

#### Interactive Visualization

The script uses `ggplot2` to create a static plot and `plotly` to convert it into an interactive plot. The plot shows the values of the function with `b` and `c` on the axes, and the function value as the fill color.

#### Long-term Behavior Analysis

The script analyzes the long-term behavior of the function by fixing different parameters and plotting the results:
- Fixing `a` and varying `b` and `c`.
- Fixing `b` and varying `a` and `c`.
- Fixing `c` and varying `a` and `b`.


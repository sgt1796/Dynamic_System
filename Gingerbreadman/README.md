# Gingerbreadman Map

This directory contains a script implementation to generate and visualize the Gingerbreadman map, a type of chaotic map from \( \mathbb{R}^2 \) to \( \mathbb{R}^2 \). The script visualizes the orbits of the mapping using a set of randomly generated starting points (uniform distribution) and evaluates the map at each iteration on those points.

## Requirements

- R
- `latex2exp` package for rendering LaTeX expressions in plot titles

You can install the required package using:
```R
install.packages("latex2exp")
```

## Usage

To run the script, simply execute it in your R environment. The script performs the following tasks:

1. Defines the function `gingerbreadman` to generate the 2D mapping.
2. Generates a number of random starting points within a defined range.
3. Iterates each starting point through the map formula for a given number of iterations.
4. Plots the orbits with varying colors and transparency for visualization.

## Script Details

### Function: `gingerbreadman`

The `gingerbreadman` function computes the orbit of a point `(x0, y0)` over a specified number of iterations.

**Arguments:**
- `x0`: Initial x-coordinate
- `y0`: Initial y-coordinate
- `iterations`: Number of iterations to compute

**Returns:**
- A list containing the x and y coordinates of the orbit.

### Parameters

- `num_points`: Number of starting points to generate (default: 5000).
- `x_range`: Range for initial x-coordinates (default: `c(-8, 8)`).
- `y_range`: Range for initial y-coordinates (default: `c(-8, 8)`).

### Plotting

The script sets up a plot with an equal aspect ratio and iterates through each starting point to plot its orbit with a unique color. The transparency of the colors is managed using the `rgb` function to provide a clear visualization of overlapping points.

### Example Plot

Below is a snapshot of the code, including the function definition and plotting section.

```r
# Load the required package
library(latex2exp)

# Function to generate Gingerbreadman map
gingerbreadman <- function(x0, y0, iterations) {
  x <- x0
  y <- y0
  xpoints <- numeric(iterations)
  ypoints <- numeric(iterations)
  
  for (i in 1:iterations) {
    xnew <- 1 - y + abs(x)
    ynew <- x
    x <- xnew
    y <- ynew
    xpoints[i] <- x
    ypoints[i] <- y
  }
  
  return(list(xpoints = xpoints, ypoints = ypoints))
}

# Number of starting points
num_points <- 5000

# Set the range for x and y
x_range <- c(-8, 8)
y_range <- c(-8, 8)

# Generate starting points randomly
#set.seed(1233)  # for reproducibility
start_points <- cbind(runif(num_points, x_range[1], x_range[2]), runif(num_points, y_range[1], y_range[2]))

# Define a color palette with transparency
colors <- rainbow(num_points)
colors_transparent <- sapply(colors, function(col) { rgb(t(col2rgb(col)/255), alpha=0.6) })

title_text = TeX(paste0("Orbit of Gingerbreadman Map from $\\Re^2 \\rightarrow \\Re^2$ with", 
                        "$(x,y) \\in \\[",x_range[1],", ",x_range[2],"\\]\\times\\[",y_range[1],", ",y_range[2],"\\]$"))

# Plot setup with equal aspect ratio
plot(NA, NA, xlim = c(-13, 19), ylim = c(-13, 19), xlab = "X", ylab = "Y", 
     main = title_text, asp = 1)

# Iterate through each starting point and plot orbits with different colors and transparency
for (i in 1:num_points) {
  orbit <- gingerbreadman(start_points[i, 1], start_points[i, 2], iterations = 300)
  points(orbit$xpoints, orbit$ypoints, col = colors_transparent[i], pch = ".")
}
```

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
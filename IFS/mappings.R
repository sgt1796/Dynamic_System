# mappings.R

# Define your mapping functions here
## ! parameter "n" is reserved, do not use


# Gingerbreadman map function
gingerbreadman <- function(x, y) {
  xnew <- 1 - y + abs(x)
  ynew <- x
  return(list(x = xnew, y = ynew))
}

# Simple rotation function
rotation <- function(x, y, angle = pi / 4) {
  xnew <- x * cos(angle) - y * sin(angle)
  ynew <- x * sin(angle) + y * cos(angle)
  return(list(x = xnew, y = ynew))
}

# Henon map function
henon <- function(x, y, a = 1.4, b = 0.3) {
  xnew <- 1 - a * x^2 + y
  ynew <- b * x
  return(list(x = xnew, y = ynew))
}

# Logistic map function
logistic <- function(x, r = 3.8) {
  xnew <- r * x * (1 - x)
  return(list(x = xnew))
}

# Arnold's cat map function
arnold_cat <- function(x, y) {
  xnew <- (2 * x + y) %% 1
  ynew <- (x + y) %% 1
  return(list(x = xnew, y = ynew))
}

# De Jong attractor function
dejong <- function(x, y, a = 1.4, b = -2.3, c = 2.4, d = -2.1) {
  xnew <- sin(a * y) - cos(b * x)
  ynew <- sin(c * x) - cos(d * y)
  return(list(x = xnew, y = ynew))
}

# Clifford attractor function
clifford <- function(x, y, a = -1.4, b = 1.6, c = 1.0, d = 0.7) {
  xnew <- sin(a * y) + c * cos(a * x)
  ynew <- sin(b * x) + d * cos(b * y)
  return(list(x = xnew, y = ynew))
}

# Lorenz attractor function
lorenz <- function(x, y, z, sigma = 10, rho = 28, beta = 8/3) {
  dx <- sigma * (y - x)
  dy <- x * (rho - z) - y
  dz <- x * y - beta * z
  return(list(dx = dx, dy = dy, dz = dz))
}

# Rossler attractor function
rossler <- function(x, y, z, a = 0.2, b = 0.2, c = 5.7) {
  dx <- -y - z
  dy <- x + a * y
  dz <- b + z * (x - c)
  return(list(dx = dx, dy = dy, dz = dz))
}




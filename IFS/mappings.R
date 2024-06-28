# mappings.R

# Gingerbreadman map function
gingerbreadman <- function(x, y) {
  xnew <- 1 - y + abs(x)
  ynew <- x
  return(list(x = xnew, y = ynew))
}

# Another example mapping: a simple rotation
rotation <- function(x, y) {
  angle <- pi / 4
  xnew <- x * cos(angle) - y * sin(angle)
  ynew <- x * sin(angle) + y * cos(angle)
  return(list(x = xnew, y = ynew))
}

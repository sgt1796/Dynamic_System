suppressWarnings(suppressPackageStartupMessages(source("IFS.R")))
library(ggplot2)
library(plotly)

## ====================================
## Define your mappings here

# test_mapping_names = "test1"
# test_mapping_list = list(
#   function(x, y) {
#     xnew <- sin(y)
#     ynew <- -cos(x)
#     return(list(x = xnew, y = ynew))
#   }
# )
# names(test_mapping_list) = test_mapping_names
## ====================================

# Initial values
num_points <- 10
iterations <- 1000
mapping_names = "lorenz_discrete"
mapping_list = load_functions(mapping_names)


initial_points <- tibble(
  x = runif(num_points, max=20, min=-20),
  y = runif(num_points, max=20, min=-20),
  z = runif(num_points, max=20, min=-20),
)

result <- iterate_functions(initial_points, iterations, mapping_list)

## result.diff

# result_list = split(result, result$mapping)
# result_diff = result_list$dejong %>%
#   mutate(x = x - result_list$gingerbreadman$x,
#          y = y - result_list$gingerbreadman$y)

# Plot the result
# ==============================================================
# # Adjust the plot with higher contrast and larger dots
# if (length(unique(result$mapping)) == 1) {
#   p <- ggplot(result, aes(x = x, y = y, color = factor(n), group = interaction(n, iteration)))
# } else {
#   p <- ggplot(result, aes(x = x, y = y, color = mapping, group = interaction(mapping, iteration)))
# }
# 
# p +
#   geom_point(size = 2, alpha = 0.8) + 
#   theme_minimal() + 
#   ggtitle("Iterated Function System") +
#   theme(legend.position = "none")
#   #xlim(c(-20,20)) +
#   #ylim(c(-20,20))
# ==============================================================
bound = 30


ggplot(result, aes(x = x, y = y, color = n)) + # or color = factor(n), depends
  geom_point(alpha = 0.7, size = 0.4) +
  xlim(-bound,bound) +
  ylim(-bound,bound) +
  theme_minimal() +
  theme(legend.position = "none")


result_small = result %>%
  filter(abs(x) < bound & abs(y) < bound & abs(z) < bound)



plot_ly(result,
        x=~x, y=~y, z=~z,
        type = "scatter3d",
        mode = "markers",
        marker = list(size = 3, color = ~factor(n), colorscale = 'Viridis'))


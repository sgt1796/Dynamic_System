suppressWarnings(suppressPackageStartupMessages(source("IFS.R")))
library(ggplot2)

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
num_points <- 100
iterations <- 200
mapping_names = "dejong"
mapping_list = load_functions(mapping_names)


initial_points <- tibble(
  x = runif(num_points, max=8, min=-8),
  y = runif(num_points, max=8, min=-8),
  z = runif(num_points, max=8, min=-8),
)

result <- iterate_functions(initial_points, iterations, mapping_list)

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
ggplot(result, aes(x = x, y = y, color = factor(n))) +
  geom_point(alpha = 0.7, size = 0.3) +
  xlim(-2,2) +
  ylim(-2,2) +
  theme_minimal() +
  theme(legend.position = "none")




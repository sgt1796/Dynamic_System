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

# Initial value (Logistic)
## ~90 sec per 1 num_points * iterations * r_interval (402million data pts)
# num_points <- 5
# iterations <- 200
# r_interval <- 0.01
# r_max <- 4
# if (r_interval > 1) {r_interval = 1}
# n_r <- ceiling(1/r_interval)
# 
# mapping_names = "logistic"
# mapping_list = load_functions(mapping_names)
# 
# initial_points = tibble(x = runif((r_max/r_interval+1)* num_points, max=1, min=0),
#                         r = rep(seq(0,r_max,by=r_interval), each = num_points))


# Initial values (2D)
num_points <- 10
iterations <- 5000
mapping_names = "lorenz_discrete"
mapping_list = load_functions(mapping_names)


initial_points <- tibble(
  x = runif(num_points, max=2, min=-2),
  y = runif(num_points, max=2, min=-2),
  z = runif(num_points, max=2, min=-2),
)
# start_time <- Sys.time()
result <- iterate_functions(initial_points, iterations, mapping_list)
# print(Sys.time() - start_time)

# bound = 4
# ggplot(result, aes(x = r, y = x)) + # or color = factor(n), depends
#   geom_point(alpha = 0.01, size = 0.4) +
#   xlim(0,bound) +
#   ylim(0,1) +
#   theme_minimal() +
#   theme(legend.position = "none")

# 
# 
# result_small = result %>%
#   filter(abs(x) < bound & abs(y) < bound & abs(z) < bound)



plot_ly(result,
        x=~x, y=~y, z=~z,
        type = "scatter3d",
        mode = "markers",
        marker = list(size = 1.5, color = ~factor(n), colorscale = 'Viridis'))



# plot_ly(result,
#         x=~x, y=~y, z=~z,
#         type = "scatter3d",
#         mode = "lines",
#         line = list(width = 0.7, color = ~factor(n), colorscale = 'Viridis'))

        
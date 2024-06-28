## Load specific functions from a file
load_functions <- function(func_names, file = "mappings.R") {
  # Source the file in a local environment
  env <- new.env()
  source(file, local = env)
  
  # Load all functions if "ALL" is specified
  if ("ALL" %in% func_names) {
    func_list <- as.list(env)
    names(func_list) <- func_names
    return(func_list)
  }
  
  # Handle single function name
  if (is.character(func_names) && length(func_names) == 1) {
    if (exists(func_names, envir = env)) {
      func_list <- list(get(func_names, envir = env))
      names(func_list) <- func_names
      return(func_list)
    } else {
      stop(paste("Function", func_names, "not found in", file))
    }
  }
  
  # Initialize a list to store the functions
  func_list <- list()
  
  # Get each function from the environment
  for (func_name in func_names) {
    if (exists(func_name, envir = env)) {
      func_list[[func_name]] <- get(func_name, envir = env)
    } else {
      stop(paste("Function", func_name, "not found in", file))
    }
  }
  # Set names of the list elements to the function names
  names(func_list) <- func_names
  return(func_list)
}
# Apply each function in the list to each (x, y) pair in the data list
apply_functions <- function(data_list, functions) {
  if (is.function(functions)) {
    functions <- list(functions)
  }
  
  results <- list()
  
  for (func_name in names(functions)) {
    if (func_name %in% names(data_list)) {
      current_data <- data_list[[func_name]]
      func <- functions[[func_name]]
      result <- lapply(current_data, function(data) func(data$x, data$y))
      results[[func_name]] <- result
    }
  }
  
  return(results)
}

# Function to apply a list of mapping functions iteratively
iterate_mappings <- function(x0, y0, iterations, mappings) {
  # Initialize the data_list with initial points
  data_list <- list()
  for (func_name in names(mappings)) {
    data_list[[func_name]] <- lapply(seq_along(x0), function(i) list(x = x0[i], y = y0[i], n = i))
  }
  
  # Initialize a data frame to store the results
  results <- data.frame()
  
  for (iter in 1:iterations) {
    data_list <- apply_functions(data_list, mappings)
    
    # Flatten the data_list and add to results
    for (func_name in names(data_list)) {
      for (i in seq_along(data_list[[func_name]])) {
        results <- rbind(results, data.frame(
          x = data_list[[func_name]][[i]]$x,
          y = data_list[[func_name]][[i]]$y,
          n = i,
          mapping = func_name,
          iteration = iter,
          stringsAsFactors = FALSE
        ))
      }
    }
  }
  
  return(results)
}


# Example usage

# Initial values
x0 = runif(40, -8, 8)
y0 <- runif(40, -8, 8)
iterations <- 300

# List of mapping function names
mapping_names <- c("gingerbreadman", "rotation")
# mapping_names = "rotation"

# File containing the mapping functions
file <- "mappings.R"

# Load the mapping functions
mappings <- load_functions(mapping_names, file)

# Apply the mappings
result <- iterate_mappings(x0, y0, iterations, mappings)

# Plot the result
library(ggplot2)
# Adjust the plot with higher contrast and larger dots
if (length(unique(result$mapping)) == 1) {
  p <- ggplot(result, aes(x = x, y = y, color = factor(n), group = interaction(n, iteration)))
} else {
  p <- ggplot(result, aes(x = x, y = y, color = mapping, group = interaction(mapping, iteration)))
}

p +
  geom_point(size = 2, alpha = 0.8) + 
  theme_minimal() + 
  ggtitle("Iterated Function System") +
  theme(legend.position = "none")


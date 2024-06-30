library(tidyverse)

# Load specific functions from a file
load_functions <- function(func_names, file = "mappings.R") {
  env <- new.env()
  source(file, local = env)
  func_list <- as.list(env) %>%
    keep(is.function)
  
  if ("ALL" %in% func_names) {
    return(func_list)
  }
  
  func_list <- func_list[func_names]
  
  if (any(sapply(func_list, is.null))) {
    missing_funcs <- func_names[is.na(match(func_names, names(func_list)))]
    stop(paste("Function(s)", paste(missing_funcs, collapse = ", "), "not found in", file))
  }
  
  return(func_list)
}

# Apply each function in the list to each n-dimensional point in the data list
apply_functions <- function(data_list, functions) {
  results <- data.frame()
  
  for (func_name in names(functions)) {
    if (func_name %in% unique(data_list$mapping)) {
      current_data <- data_list %>% filter(mapping == func_name)
      func <- functions[[func_name]]
      
      ## Need to change this one to a better way later
      func_params <- intersect(names(formals(func)), c("x","y","z")) # Get the parameter names of the function
      
      result <- current_data %>%
        rowwise() %>%
        mutate(new_coords = list(do.call(func, as.list(across(all_of(func_params)))))) %>%
        select(new_coords, mapping, n)%>%
        unnest_wider(new_coords)
      
      results <- bind_rows(results, result)
    }
  }
  
  return(results)
}

# Function to apply a list of mapping functions iteratively to n-dimensional points
iterate_functions <- function(initial_points, iterations, mapping_list) {
  print("start iterating functions...")
  
  data_list <- map_dfr(names(mapping_list), function(mapping_name) {
        mutate(initial_points, mapping = mapping_name, n = row_number())
    })

  init <- data_list %>%
    mutate(iteration = 0L) %>%
    select(mapping, n, everything())
  
  results = tibble()
  for (iter in seq_len(iterations)) {
    data_list <- apply_functions(data_list, mapping_list)
    data_list <- data_list %>%
      mutate(iteration = iter)
    results <- bind_rows(results, data_list)
  }
  param <- colnames(results)
  init <- select(init, all_of(param))
  results <- rbind(init, results)
  print("IFS done.")
  return(results)
}

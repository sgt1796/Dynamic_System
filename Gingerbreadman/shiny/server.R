library(shiny)
library(shinyjs)
library(plotly)
library(dplyr)
library(purrr)
library(RColorBrewer)

# Helper function to parse interval strings
parse_interval <- function(interval_str) {
  matches <- regmatches(interval_str, gregexpr("[-+]?[0-9]*\\.?[0-9]+", interval_str))
  if (length(matches[[1]]) >= 2) {
    values <- as.numeric(matches[[1]])
    return(values)
  } else {
    return(c(-8, 8))  # Default range if parsing fails
  }
}

# Gingerbreadman map function
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
  
  return(data.frame(x = xpoints, y = ypoints))
}

server <- function(input, output, session) {
  points <- reactiveVal(data.frame(
    x = runif(6, -8, 8),
    y = runif(6, -8, 8),
    id = 1:6,
    color = brewer.pal(6, "Set1")
  ))
  
  observeEvent(input$reset, {
    n_points <- input$n_points
    max_colors <- 9
    colors <- if (n_points >= 3) {
      if (n_points > max_colors) {
        rep(brewer.pal(max_colors, "Set1"), length.out = n_points)
      } else {
        brewer.pal(n_points, "Set1")
      }
    } else {
      brewer.pal(3, "Set1")[1:n_points]
    }
    
    # Parse the input ranges
    x_range <- parse_interval(input$x_range)
    y_range <- parse_interval(input$y_range)
    
    # Update the points
    points(data.frame(
      x = runif(n_points, x_range[1], x_range[2]),
      y = runif(n_points, y_range[1], y_range[2]),
      id = 1:n_points,
      color = colors
    ))
  })
  
  output$orbitPlot <- renderPlotly({
    points_data <- points()
    plot <- plot_ly()
    
    for (i in 1:nrow(points_data)) {
      orbit <- gingerbreadman(points_data$x[i], points_data$y[i], iterations = input$iterations)
      if (input$plot_method == "trace") {
        plot <- add_trace(
          plot,
          data = orbit,
          x = ~x,
          y = ~y,
          type = 'scatter',
          mode = 'lines',
          line = list(color = points_data$color[i]),
          name = paste("Orbit", i)
        )
      } else if (input$plot_method == "scatter") {
        plot <- add_trace(
          plot,
          data = orbit,
          x = ~x,
          y = ~y,
          type = 'scatter',
          mode = 'markers',
          marker = list(size = 2, color = points_data$color[i]),
          name = paste("Orbit", i)
        )
      }
    }
    
    shapes <- map2(points_data$x, points_data$y, ~list(
      type = "circle",
      x0 = .x - 0.2, x1 = .x + 0.2,
      y0 = .y - 0.2, y1 = .y + 0.2,
      fillcolor = "transparent",
      line = list(color = points_data$color[which(points_data$x == .x & points_data$y == .y)], width = 2),
      xref = "x", yref = "y",
      editable = TRUE
    ))
    
    plot <- add_trace(
      plot,
      data = points_data,
      x = ~x,
      y = ~y,
      type = 'scatter',
      mode = 'markers',
      marker = list(size = 10, color = ~color),
      key = ~id
    ) %>%
      layout(
        shapes = shapes,
        xaxis = list(scaleanchor = "y", scaleratio = 1),
        yaxis = list(scaleanchor = "x", scaleratio = 1)
      ) %>%
      config(edits = list(shapePosition = TRUE))
    
    plot
  })
  
  
  observe({
    ed <- event_data("plotly_relayout")
    if (is.null(ed)) return()
    
    
    shape_indices <- grep("^shapes\\[.*\\]\\.x0$", names(ed))
    if (length(shape_indices) == 0) return()
    
    new_x <- as.numeric(unlist(ed[shape_indices])) + 0.2
    new_y <- as.numeric(unlist(ed[shape_indices + 1])) + 0.2
    ids <- gsub("shapes\\[|\\]\\.x0$", "", names(ed)[shape_indices])
    ids <- as.numeric(ids) + 1  # Convert to numeric and adjust index
    
    ## known bug: removing isolate() causing the reset to keep the last orbit of the point dragged
    points_data <- isolate(points())
    for (i in seq_along(new_x)) {
      points_data$x[ids[i]] <- new_x[i]
      points_data$y[ids[i]] <- new_y[i]
    }
    points(points_data)
  })
  
  # Add this block to output the current fixed points:
  output$debugOutput <- renderPrint({
    print(points())
    print(event_data("plotly_relayout"))
  })
}

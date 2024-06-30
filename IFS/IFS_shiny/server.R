server <- function(input, output, session) {
  observeEvent(input$plot, {
    pts <- tibble(
      x = runif(input$n_points, max=2, min=-2),
      y = runif(input$n_points, max=2, min=-2),
      z = runif(input$n_points, max=2, min=-2),
    )
    iter <- input$iterations
    mapping_name <- input$map_function
    map_func <- load_functions(mapping_name, file_path)
    
    orbits <- iterate_functions(pts, iter, map_func)
    
    
    
    is_support_3d = all(c("x", "y", "z") %in% names(formals(map_func[[1]])))
    
    output$ifsPlot <- renderPlotly({
      if (input$is_3d){
        if (is_support_3d) {
          plot_ly(orbits, x = ~x, y = ~y, z = ~z, color = ~as.factor(n), 
                  type = 'scatter3d', mode = 'markers',
                  marker = list(size = 3, colorscale = 'Viridis')) %>%
            layout(scene = list(xaxis = list(title = 'X'),
                                yaxis = list(title = 'Y'),
                                zaxis = list(title = 'Z')),
                   showlegend = FALSE)
        } else {
          updateCheckboxInput(session, "is_3d", value = FALSE)
          output$plotMessage <- renderText({
            "3D plot cannot be drawn for this mapping"
          })
        }
      } else {
        plot_ly(orbits, x = ~x, y = ~y, color = ~as.factor(n), 
                type = 'scatter', mode = 'markers') %>%
          layout(
            xaxis = list(scaleanchor = "y", scaleratio = 1),
            yaxis = list(scaleanchor = "x", scaleratio = 1),
            showlegend = FALSE
          )
      }
    })
    
    # output$debugOutput <- renderPrint({})
    
    output$selectedMapping <- renderText({
      paste("Selected mapping function:", mapping_name)
    })
  })
}
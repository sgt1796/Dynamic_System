library(plotly)

ui <- fluidPage(
  titlePanel("Interactive Orbits of Dynamic Systems"),
  sidebarLayout(
    sidebarPanel(
      numericInput("n_points", "Number of Points:", 6, min = 1, max = 20),
      sliderInput("iterations", "Number of Iterations:", min = 10, max = 2000, value = 1500),
      selectInput("plot_method", "Plotting Method:",
                  choices = list("Scatter" = "scatter", "Trace" = "trace")),
      textInput("x_range", "X Range:", placeholder = "[a,b]"),
      textInput("y_range", "Y Range:", placeholder = "[a,b]"),
      actionButton("reset", "Reset Points")
    ),
    mainPanel(
      plotlyOutput("orbitPlot"),
      verbatimTextOutput("debugOutput")
    )
  )
)

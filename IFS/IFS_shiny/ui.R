ui <- fluidPage(
  titlePanel("Interactive IFS Systems"),
  sidebarLayout(
    sidebarPanel(
      numericInput("n_points", "Number of Points:", 10, min = 1, max = 1000),
      sliderInput("iterations", "Number of Iterations:", min = 10, max = 2000, value = 100),
      selectInput("map_function", "Choose Mapping:",
                  choices = list("Gingerbreadman Map" = "gingerbreadman", 
                                 "Simple Rotation" = "rotation",
                                 "Arnold Cat Mapping" = "arnold_cat",
                                 "Clifford attractor" = "clifford",
                                 "Peter de Jong Attractors" = "dejong",
                                 "Henon Map" = "henon",
                                 "Discrete Lorenz attractor" = "lorenz_discrete",
                                 "Rossler attractor" = "rossler_discrete")),
      checkboxInput("is_3d", "3D Plot", value = FALSE),
      actionButton("plot", "Plot")
    ),
    mainPanel(
      plotlyOutput("ifsPlot"),
      verbatimTextOutput("debugOutput"),
      verbatimTextOutput("selectedMapping"),
      verbatimTextOutput("plotMessage")
    )
  )
)

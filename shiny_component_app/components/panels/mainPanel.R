mainPanel <- tabItem(
      tabName = "dashboard",
      fluidRow(
        
        # CONTROLS
        box(
          
          title = "Controls",
          
          # Choose a column
          selectInput(
            "columnChoice",
            "Choose a column:",
            choices = colnames(df),
            selected = "n"
          ),
          
          sliderInput("slider", "Number of observations:", 1, 100, 50),
          
          # Create an eventReactive element
          actionButton(
            inputId = "submit",
            label = "Submit column"
          )
          
        ),
        # PLOT
        box(
          
          plotOutput("histPlot")
          
        )
      )
    )
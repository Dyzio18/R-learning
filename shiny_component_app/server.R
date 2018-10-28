###################
# server.R
# 
# For all your server needs 
###################
library(shinydashboard)

source('./server/loadFile.R')



server <- function(input, output, session) {
  


  dataFileReact <- reactive({
    result <- df
    if (!is.null(input$dataFile$datapath)) {
      tryCatch({
          result <- read.csv(input$dataFile$datapath,
                        header = input$header,
                        sep = input$sep,
                        quote = input$quote)
      }, error = function(e) {
        stop(safeError(e))
      })
    }
    return(result)
  })
  
  
  output$headers <- renderTable({
    colnames(dataFileReact())
  })
  
  output$uiBoxDetail <- renderUI({
    if(is.null(input$dataFile$datapath)) return()
    box(
      title = "More info",
      width = NULL,
      solidHeader = TRUE, 
      status = "primary",
      tabsetPanel(
        type = "tabs", 
        # Panel headers
        tabPanel("Headers",
          h4("Headers"),
          div(style = 'overflow-x: scroll', tableOutput('headers'))),
        # Panel histogram
        tabPanel("Histogram", 
            selectInput(
            "datasetSelectColumn",
            "Choose a column:",
            choices = colnames(dataFileReact())
          ),
          sliderInput("datasetHistSlider", "Number of observations:", 1, 36, 10),
          actionButton(
            inputId = "datasetHistSubmit",
            label = "Submit column"
          ),
          plotOutput("datasetHistPlot")
          
        ),
        # Panel other
        tabPanel("Table",   
          h4(icon("glyphicon-list-alt"), "Details:")
        )
      )
    )
  })

  # ------------------------

  
  histPlotDataFile <- eventReactive(
    input$datasetHistSubmit,
    {
      dataFileReact()[[ input$datasetSelectColumn ]]
    }
  )
  
  output$datasetHistPlot <- renderPlot({
    data <- histPlotDataFile()[]
    hist(data, breaks = input$datasetHistSlider)
  })
  
  
  # ------------------------------

  output$contents <- renderTable({
    # req(input$dataFile)

    if (input$disp == "head") {
      return(head(dataFileReact()))
    }
    else {
      return(dataFileReact())
    }
  })




  # -----------------------
  # -----------------------
  # mainPanel

  histPlot_df <- eventReactive(
    input$submit,
    {
      df[[ input$columnChoice ]]
    }
  )
  
  output$histPlot <- renderPlot({
    data <- histPlot_df()[ seq_len(input$slider) ]
    hist(data)
  })

  # -----------------------
  # -----------------------
  # widgetPanel
   # display 10 rows initially
  output$ex1 <- DT::renderDataTable(
    DT::datatable(
      dataFileReact(),
      filter = 'top',
      extensions = 'Buttons',
      options = list(pageLength = 10, buttons = I('colvis'))
    )
  )

  # write literal JS code in JS()
  # output$ex5 <- DT::renderDataTable(DT::datatable(
  #   dataFileReact(),
  #   options = list(rowCallback = DT::JS(
  #     'function(row, data) {
  #       // Bold cells for those >= 5 in the first column
  #       if (parseFloat(data[1]) >= 5.0)
  #         $("td:eq(1)", row).css("font-weight", "bold");
  #     }'
  #   ))
  # ))

  
}

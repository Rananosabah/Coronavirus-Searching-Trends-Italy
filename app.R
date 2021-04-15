library(shiny)
library(ggplot2)
Italy=read.csv("data/Italy.csv")
ui <- fluidPage(
  titlePanel = "Searching Trends",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "Italy"',
        checkboxGroupInput("show_vars", "Columns in Italy to show:",
                           names(Italy), selected = names(Italy))
      ),
      conditionalPanel(
        helpText("Click the column header to sort a column.")
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'data',
        tabPanel("Italy", DT::dataTableOutput("mytable1"))
        
      )
    )
  )
)
server <- function(input, output) {
  Italy2 = Italy[sample(nrow(Italy), 101), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(Italy2[, input$show_vars,drop = FALSE])
  
  })
  
}

shinyApp(ui, server)

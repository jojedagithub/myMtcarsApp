library(shiny)

shinyUI(fluidPage(
  titlePanel("Ejemplo Shiny App: análisis mtcars"),
  sidebarLayout(
    position="left",
    sidebarPanel(
      selectInput("selecF", label="Seleciona una variable discreta:",
                  choices=c("Ninguna", "cyl", "vs", "am", "gear", "carb" )
      ),
      selectInput("selecX", label="Seleciona la variable continua X:",
                  choices=c("Ninguna", "mpg", "disp", "hp", "drat", "wt", "qsec")
      ),
      selectInput("selecY", label="Seleciona una variable continua Y:",
                  choices=c("Ninguna", "mpg", "disp", "hp", "drat", "wt", "qsec")
      ),
      selectInput("selecTec", label="Seleciona una técnica",
                  choices=c("Ninguna","Diag. Dispersión","Histograma","Tabla","Boxplot")
      )
    ),

    mainPanel(
      p("Se trata de analizar los datos de mtcars según las variables y 
        técnicas seleccionadas."),
      br(),      
      br(),
      p("Tabla:"),
      p(tableOutput("table")),
      br(),
      p("Gráfico:"),
      plotOutput("graph"),
      br(),
      p("STATUS:",textOutput("status"))
    )
  )
))
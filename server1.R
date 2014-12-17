library(shiny)


load("data/myMtcars.RDat")


shinyServer(
  function(input, output) {
    ##  ...hacer que responda a los cambios del usuario
    uiDataSel <- reactive({ input$selecTec })
    uiDataF <- reactive({ input$selecF })
    uiDataX <- reactive({ input$selecX })
    uiDataY <- reactive({ input$selecY })
    ##  
    ##  Desarrollar la salida
    output$status <- renderText({    
      auxStatus <- paste("Has selecionado: '",uiDataSel(),":\n",
                         "\t\tF=",uiDataF(),"X=",uiDataX(),"Y=",uiDataY(),"\n")
      cat(auxStatus) 
      auxStatus
    })
  }
)
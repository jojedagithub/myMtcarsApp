library(shiny)


load("data/myMtcars.RDat")


shinyServer(
  function(input, output) {
    ##  ...hacer que responda a los cambios del usuario
    uiDataSel <- reactive({ input$selecTec })
    uiDataF <- reactive({ input$selecF })
    uiDataX <- reactive({ input$selecX })
    uiDataY <- reactive({ input$selecY })
    ##  set status object
    status <- ""
    ##  Desarrollar la salida
    output$table <- renderTable({ 
        if( uiDataSel()=="Tabla" )
          if(uiDataF()=="Ninguna") {
            status <- paste(status,"</p><emph>Faltan variables !!</emph>")
            NULL
          } else 
            table( myMtcars[,uiDataF()] ) 
        else
          NULL
      })
    output$graph <- renderPlot({
      sel <- uiDataSel()
      F <- uiDataF()
      X <- uiDataX()
      Y <- uiDataY()
      switch( sel,
              "Diag. Dispersión"={
                if( X=="Ninguna" || Y=="Ninguna" ) {
                  status <- paste(status,"</p><emph>Faltan variables !!</emph>")
                  NULL
                } else {
                  cat("cmd: diagDisp",X,Y,"\n")   
                  NULL# diagDisp( myMtcars[,c(X,Y)])
                }
              },
              "Histograma"={
                if( X=="Ninguna" || Y=="Ninguna" ) {
                  status <- paste(status,"</p><emph>Faltan variables !!</emph>")
                  NULL
                } else {
                  cat("cmd: miHist",X,"\n")
                  NULL# miHist(X)
                }
              },
              "Boxplot"={
                if( X=="Ninguna" || F=="Ninguna" ) {
                  status <- paste(status,"</p><emph>Faltan variables !!</emph>")
                  NULL
                } else {
                  cat("cmd: miBoxplot",X,F,"\n")    
                  NULL# miBoxplot(( paste(X,Y,coll="~"),myMtcars) })
                }
              },
             NULL
      )
    })
    output$status <- renderText({  
      auxStatus <- paste("Has selecionado: '",uiDataSel(),":\n",
                         "\t\tF=",uiDataF(),"X=",uiDataX(),"Y=",uiDataY(),"\n",
                         status)
        cat(auxStatus) 
        auxStatus
        })
  }
)
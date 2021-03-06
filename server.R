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
                  plot.new()
                } else {
                  cat("cmd: diagDisp",X,Y,"\n")   
                  plot( myMtcars[,c(X,Y)],xlab=X,ylab=Y,
                        col=if(F=="Ninguna") "black" else myMtcars[,F] )
                }
              },
              "Histograma"={
                if( X=="Ninguna" || Y=="Ninguna" ) {
                  status <- paste(status,"</p><emph>Faltan variables !!</emph>")
                  plot.new()
                } else {
                  cat("cmd: miHist",X,"\n")
                  hist(myMtcars[,X],main=X)
                }
              },
              "Boxplot"={
                if( X=="Ninguna" || F=="Ninguna" ) {
                  status <- paste(status,"</p><emph>Faltan variables !!</emph>")
                  plot.new()
                } else {
                  cat("cmd: miBoxplot",X,F,"\n")    
                  boxplot( paste(X,Y,coll="~"),myMtcars)
                }
              },
             plot.new()
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
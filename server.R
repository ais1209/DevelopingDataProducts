library(shiny)
library(ggplot2)
library(pracma)
source("project.R")

shinyServer(    
    function(input, output) {
      
        output$downloadData <- downloadHandler(
              filename = function() {
                paste('data-', Sys.Date(), '.csv', sep='')
              },
              content = function(file) {
                write.csv(Dataset(), file, row.names = FALSE)
              }
            )
     
        Dataset <- reactive({
            N <- input$N
            T <- input$T
            C <- input$C
            
            # Fundamental frequency
            w0 <- 2*pi/T
            
            # time vector
            t <- c(0:(C *100*T))/100
            
            # Fourier series reconstruction
            v <- 0
            for(n in 0:(N -1)) {
                v <- v + 1/(2*n+1)*sin((2*n+1)*w0*t)
            }
            v <- v*4/pi
            
            # Save signal for plotting and exporting
            Dataset <- data.frame(time = t, value = v)
            
            # isolate(df)
            return(Dataset)  
        })
        
        output$sqWave <- renderPlot({   
            df <- Dataset()
            
            # this is the magnitude of the spectrum
            signal <- abs(fftshift(fft(df[,2])))
            M <- length(signal)
            
            dt <- df[2,1] - df[1,2]
            
            freq <- c((-M/2+1):(M/2))
            freq <- freq/(M*dt)
            
            # Plot the right half of the spectrum, since the two halves are mirror images of each other.
            selectHalf <- freq >=0
            
            q1 <- qplot(df[,1], df[,2]) + xlab('Time') + ylab("")
            q1 <- q1 + labs(title = "Reconstruction of A Square Wave") + geom_line()
            q2 <- qplot(freq[selectHalf], signal[selectHalf]/max(signal))
            q2 <- q2 + xlab('Frequency (Hz)') +ylab("Amplitude")
            q2 <- q2 + labs(title = 'Normalized Magnitude of Spectrum') + geom_line()

            multiplot(q1, q2, cols = 2)
            
        })      
        }
)

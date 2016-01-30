
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(pageWithSidebar(  
    headerPanel("Signal Reconstruction with the Fourier Theorem"),  
    sidebarPanel( 
        h3('Input parameters'),
        sliderInput('T', 'Select cycle length (period) -- T',value = 1, min = 1, max = 5, step = 0.5), 
        sliderInput('N', 'Number of terms for Fourier reconstruction -- N', 2, min = 1, max = 100, step = 1),
        
        numericInput('C', 'Number of cycles to display -- C', 2, min = 1, max = 5, step = 1),
        submitButton('Submit'),
        h3('Dowload square wave data'),
        downloadButton('downloadData', 'Download')
    ),
    mainPanel( 
      h3('Output'),
      plotOutput('sqWave'),
      h3('Description'),
      helpText("According to Fourier theory, almost any signal (function) can be converted to a periodic signal and represented 
                 as a sum of ever-decreasing sinusoidal components."),
      #helpText("More details on Fourier Series here.", href = "http://mathworld.wolfram.com/FourierSeries.html", target="_blank"),
      helpText("This application uses a Fourier series to approximate a square wave of amplitude equal to 1 and period T, 
                 using a user-defined number of Fourier terms. It displays the reconstruction of the square wave and its frequency spectrum. 
                 The user has the option to download a CSV file containing the approximation of the square wave calculated at equidistant 
                 time steps along the user-defined number of cycles (periods)."),
      h4('Input Parameters'),
      p('T = period (cycle length) of the square wave, N = number of Fourier terms used in the reconstruction, i.e., sine or cosine functions,
             C = number of cycles'),
      h4('Instructions'),
      p('Select desired values for T, N, and C and then click the Submit button to apply the changes. 
          The more terms are used, the closer the reconstruction is to a square wave. The frequency plot will adjust to show 
          a number of peaks equal to the number of terms N. Click the Submit button upon making a selection for the input parameters.'),
      p('If you wish to export the data, click the Download button. The name of the file will automatically contain the current 
          system date stamp.')
        
    )
))
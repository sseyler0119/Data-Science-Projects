# load libraries
library(shiny)
library(shinyWidgets)
library(ggplot2)
library(dplyr)
library(corrplot)

source("helpers.R") # source helpers file


data(iris) # load iris data set
head(iris) # examine the data


# Define user interface object ----
ui <- fluidPage(
  includeCSS("www/style.css"),
  
  # App title ----
  titlePanel(h1(class="title", "Shiny App: Iris Dataset")),
  
  fluidRow(
    sidebarPanel(class="inputs",
      h3("Interactive Scatter Plot"),
      br(),
             selectInput(inputId = "x",
                         label = "x-axis",
                         vars),
             
             selectInput(inputId = "y", 
                         label = "y-axis",
                         vars),
      br()
    ),
    mainPanel(class="displayContainer",
      column(8,
             plotOutput("scatter")))
    ), # end row
    
  hr(),
  
  fluidRow(
    sidebarPanel(class="inputs",
      radioButtons("species", h3("Species"),
                   choices = c("Iris-setosa", "Iris-versicolor", "Iris-virginica"))
      
      ), # end sidebar panel
    
    mainPanel(class="displayContainer",
      column(6,
             imageOutput("image"),
             br(),
             br()
      ),
      column(6,
             h3("Summary of Averages by Species"),
             br(),
             tableOutput("table")      
      )
    ), # end main panel
      
   hr()
  ), # end row
   
  hr(),
  
  fluidRow(
    sidebarPanel(class="inputs", id="slider",
      setSliderColor("#cddc39", 1), #4caf50
      sliderInput("bins", "Number of bins:", min = 10, max = 35, value = 15)
    ),
    column(8,class="displayContainer",
           
#           h3("Histogram"),
           plotOutput("hist")
    )
  ), # end row
  
  hr(),
  fluidRow(
    column(6,
           class="plotContainer",
           h3("Sepal Length Boxplot"),
           plotOutput("boxplot"),
           br(),
           br(),
    ),
    column(6,
           class="plotContainer",
           h3("Correlation Heatmap"),
           plotOutput("correlation"), 
    )
   
  ) # end row
  
)


# Define server logic ----
server <- function(input, output) {
  
  # render box plot
  output$boxplot <- renderPlot({
    boxplot(Sepal.Length ~ Species, 
            data = irisData, main = "Sepal Length", 
            xlab="Species", ylab="Sepal Length",
            col="steelblue", border="black")
  
  })
  
  # correlation map
  output$correlation <- renderPlot({
    corrplot(corr, method = 'square', diag=FALSE, order = "hclust",
             addrect = 3, rect.col = 'blue', rect.lwd = 3, tl.pos = 'd', col = COL2('PRGn', 10))
      
  })

  # histogram
  output$hist <- renderPlot({
    hist (iris$Sepal.Length, freq = FALSE, 
          breaks = input$bins,
    col=c("grey", "lightblue"),
    main="Distribution of Sepal Length",
    xlab= "Sepal Length", las =1)
 
    lines(density(iris$Sepal.Length), lwd = 3, col = "#c60f3f")
  })
  
  # summary table of average data
  output$table <- renderTable({
    iris_sum
    }) 
  
  # Interactive Scatter Plot
  output$scatter <- renderPlot({
    title(main = "Scatterplot")
    data <- iris[, c(input$x, input$y)]
 
    ggplot(
      data = data, aes(x = data[,1], y = data[,2]),fig(6,5)) +
      geom_point(aes(col = iris$Species), size = 4)  + 
      scale_color_brewer(palette = "Spectral") +
      xlab(input$x) +
      ylab(input$y) +
      geom_smooth(method='lm', se = FALSE, color = "#0072B2", linetype = "dotted")
      
  })
  
  # render species image
  output$image <- renderImage({
    if (is.null(input$species))
      return(NULL)
    
    if (input$species == "Iris-setosa") {
      return(list(
        src = "www/images/setosa.png",
        contentType = "image/png",
        alt = "Iris Setosa",
        width="400",
        height="400"
      ))
    } else if (input$species == "Iris-versicolor") {
      return(list(
        src = "www/images/versicolor.png",
        filetype = "image/png",
        alt = "Iris Versicolor",
        width="400",
        height="400"
      ))
    } else if (input$species == "Iris-virginica") {
      return(list(
        src = "www/images/virginica.png",
        filetype = "image/png",
        alt = "Iris Virginica",
        width="400",
        height="400"
      ))
    }
    
  }, deleteFile = FALSE)
 
}

# Call to the shinyApp function, run the app
shinyApp(ui = ui, server = server)
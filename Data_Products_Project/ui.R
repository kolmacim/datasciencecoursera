#############################################################################
#install.packages("shiny")
#install.packages("shinythemes")

library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cerulean"),

  pageWithSidebar(
  headerPanel("CO2 Emission Prediction"),
  sidebarPanel(
    h3('Car data'),
    numericInput('year', 'Year of production: ', 2010, min = 1990, max = 2016, step = 1),
    uiOutput("manufacturers"),
    numericInput('engine_capacity', 'Engine Capacity (cc):', 1700, min = 1000, max = 6000, step = 50),
    uiOutput("fuel_types")
  ),
  mainPanel(
    #h3('Illustrating outputs'),
    #h4('You entered'),
    #verbatimTextOutput("year"),
    #h4('You entered'),
    #verbatimTextOutput("manufacturer"),
    #h4('You entered'),
    #verbatimTextOutput("engine_capacity"),
    #h4('You entered'),
    #verbatimTextOutput("fuel_type"),
    h4('Predicted g CO2/km'),
    verbatimTextOutput("prediction"),
    uiOutput('logo'),
    h4(' '),
    tabsetPanel(
      tabPanel("Documentation",
               h4('Summary'),
               "This application predicts the CO2 emissions based on several input variables.",
               tags$p(href="a"),
               h4('Dataset'),
               "To build prediction model, dataset from",
               tags$a(href="http://frictionlessdata.io/", "frictionlessdata"),
               " has been used.",
               tags$p(href="a"),
               "You can access the dataset ",
               tags$a(href="http://data.okfn.org/data/amercader/car-fuel-and-emissions", "here"),
               ".",
               h4('Input variables'),
               "Original dataset contains many columns for user input so it has been reduced to several input variables only.",
               tags$p(href="a"),
               uiOutput(outputId = "text"),
               tags$p(href="a"),
               h4('Prediction'),
               "Linear model has been used for prediction."
               ),
      tabPanel("Source",
               tags$p(href="a"),
               "Source code can be accessed on GitHub ",
               tags$a(href="https://github.com/kolmacim/datasciencecoursera/tree/master/Data_Products_Project", "here")
               )
    )
  )
)))

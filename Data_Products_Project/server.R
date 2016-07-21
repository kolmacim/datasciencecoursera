#load libraries
library(caret)
library(dplyr)
library(shiny)
library(shinyapps)

#rm(list = ls())

shinyServer(
  function(input, output){
    #output values
    output$year             <- renderPrint({input$year})
    output$manufacturer     <- renderPrint({input$manufacturer})
    output$engine_capacity  <- renderPrint({input$engine_capacity})
    output$fuel_type        <- renderPrint({input$fuel_type})
    #uiOutput
    output$manufacturers    <- renderUI({selectInput('manufacturer', 'Manufacturer: ', manufacturers())})
    output$fuel_types       <- renderUI({selectInput('fuel_type', 'Fuel types: ', fuel_types())})
    #prediction
    output$prediction       <- renderText({predict_co2()})

    output$logo <- renderUI({
      img(src = "co2_emission_banner2.gif", width = "590")
    })

    output$text <- renderText({
      HTML(paste0("<b>","Year of production","</b>", " - suggested values are in range 1990. - 2016.","<br>",
                  "<b>","Manufacturer","</b>", " - producer, dropdown input fetched from dataset.","<br>",
                  "<b>","Engine capacity","</b>", " - volume in cubic centimetres. Suggested values 1000 - 6000.","<br>",
                  "<b>","Fuel type","</b>", " - type of fuel, dropdown fetched from dataset.","<br>"))
    })

    #fuel data input from file
    if(file.exists("fuel_data.rda")) {
      load("fuel_data.rda")
    } else {
      fuel_data <- read.csv("fuel_data.csv")
      fuel_data <- fuel_data %>% select(year, manufacturer, engine_capacity, fuel_type, co2)
      fuel_data <- na.omit(fuel_data)
      save(fuel_data, file = "fuel_data.rda")
    }

    #reactive output of unique Car manufacturers
    manufacturers <- reactive({
      fuel_data <- unique(fuel_data$manufacturer)
      as.vector(fuel_data)
    })

    #reactive output of unique Car fuel types
    fuel_types <- reactive({
      fuel_data <- unique(fuel_data$fuel_type)
      as.vector(fuel_data)
    })

    #Partioning the training set into two
    set.seed(933)
    inTrain  <- createDataPartition(y = fuel_data$co2, p=0.7, list=FALSE)
    testing  <- fuel_data[-inTrain,]
    training <- fuel_data[ inTrain,]


    if(file.exists("modFitAll.rda")) {
      ## load model
      load("modFitAll.rda")
    } else {
      modFitAll <- train(co2 ~ ., method = "lm", data = training)
      save(modFitAll, file = "modFitAll.rda")
    }

    #modFitAll <- train(co2 ~ ., method = "lm", data = training)
    #save(modFitAll, file = "modFitAll.rda")

    #predict
    predict_co2 <- reactive({
      user_input <- data.frame("year" = input$year, "manufacturer" = input$manufacturer, "engine_capacity" = input$engine_capacity, "fuel_type" = input$fuel_type)
      user_input2 <- predict(modFitAll, user_input)
      as.vector(user_input2)
    })

  }
)

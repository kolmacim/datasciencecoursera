---
title: "Prediction of CO2 emissions"
author: "Mario Kolmacic"
highlighter: highlight.js
output: pdf_document
job: null
knit: slidify::knit2slides
mode: selfcontained
hitheme: tomorrow
subtitle: Coursera - Data Products
framework: io2012
widgets: []
---

## Introduction


CO2 emission is current trend in automotive industry

Emission is going down each year with new, inovative and environment friendly engines.

With developed R application, you are able to predict CO2 emission for specific engine

--- .class #id

## Dataset

For dataset we used frictionlessdata source with emissions of engines produced between 2000. and 2013. Dataset is available [here](http://data.okfn.org/data/amercader/car-fuel-and-emissions).

For purposes of our prediction, only four (Year of production, Manufacturer, Engine capacity, Fuel type) out of many variables has been used

```r
    set.seed(933)
    inTrain  <- createDataPartition(y = fuel_data$co2, p=0.7, list=FALSE)
    testing  <- fuel_data[-inTrain,]
    training <- fuel_data[ inTrain,]
```

Linear model has been used for prediction

```r
modFitAll <- train(co2 ~ ., method = "lm", data = training)
```

--- .class #id

## Results

To get the result of specific manufacturer, we have to fill the form with 4 inputs.

![Data Input](https://s32.postimg.org/5ih6nelr9/Capture1.png)

Result is displayed on the right.

![Prediction result](https://s31.postimg.org/6j6g2thhn/Capture2.png)

--- .class #id

## Conclusion

With our prediction model, we confirmed that emission per km is less harmful for the environment every year.

Development of electric and hybrid cars will make even better impact and narrow emissions to nearly 0 grams per km.

Application is available [here](https://markolmac.shinyapps.io/data_products_project/).

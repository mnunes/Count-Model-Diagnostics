# Count Model Diagnostics

## Introduction

The function `autoplot.countreg.R` uses results from package `countreg` to create diagnostics plots for count models. This function depends on `countreg` and `ggplot2` packages.

## Usage

Put file `autoplot.countreg.R` and the code for your analysis in the folder. Run `source(autoplot.countreg.R)` to load the function in your environment. Below you can find an example on how to use the function.

    source(autoplot.countreg.R)
    library(MASS)
    
    # example from MASS::glm
    
    counts <- c(18,17,15,20,10,20,25,13,12)
    outcome <- gl(3,1,9)
    treatment <- gl(3,3)
    print(d.AD <- data.frame(treatment, outcome, counts))
    glm.D93 <- glm(counts ~ outcome + treatment, family = "poisson")
    
    autoplot.countreg(glm.D93)
    
![alt text](Rplot.png)

## References

Kleiber, C. and Zeileis, A. (2016), "Visualizing Count Data Regressions Using Rootograms", _The American Statistician_, **70** (6) 296-303. URL: [https://www.tandfonline.com/doi/ref/10.1080/00031305.2016.1173590?scroll=top](https://www.tandfonline.com/doi/ref/10.1080/00031305.2016.1173590?scroll=top)
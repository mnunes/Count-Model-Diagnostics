require(countreg)
require(ggplot2)

autoplot.countreg <- function(object){
  
  ###########
  # rootogram
  
  rootogram.plot <- rootogram(object, style = "hanging", plot = FALSE)
  
  g1 <- autoplot(rootogram.plot) +
    #labs(x=all.vars(object$formula)[1], y=expression(sqrt(Frequency)))
    labs(x="Counts", y=expression(sqrt(Frequency)))
  
  
  
  #########
  # qq plot
  
  qres <- qresiduals(object)
  q2q <- function(y) qnorm(ppoints(length(y)))[order(order(y))]
  qnor <- q2q(qres)
  
  plot.res <- data.frame(theoretical=qnor, residuals=qres)
  
  g2 <- ggplot(plot.res, aes(x=theoretical, y=residuals)) +
    geom_point() +
    labs(x="Theoretical Quantiles", y="Quantile Residuals") +
    geom_abline(slope=1, intercept = 0, lty="dashed")
  
  
  
  ############################
  # expected and actual counts
  
  expected.observed <- rootogram(object, style = "hanging", plot = FALSE)
  
  expected.observed <- data.frame(x=rep(expected.observed$x, 2),
                                  y=c(expected.observed$observed, expected.observed$expected),
                                  group=factor(c(rep("Observed", length(expected.observed$observed)), rep("Expected", length(expected.observed$expected))), levels=c("Observed", "Expected")))
  
  g3 <- ggplot(expected.observed[expected.observed$x <= 20, ], aes(x=x, y=y, fill=group)) +
    geom_col(position = "dodge") +
    labs(x="Counts", y="Frequency", fill="") +
    scale_fill_grey() +
    theme(legend.justification=c(1, 1), legend.position=c(0.95, 0.95))
  
  ####################################
  # pearson residuals vs fitted values
  
  g4 <- ggplot(data.frame(x=object$fitted.values, 
                    y=residuals(object, type="pearson")), 
         aes(x=x, y=y)) +
    geom_point() +
    labs(x="Fitted Values", y="Pearson Residuals")
  
  # combine all plots in one grid
  
  grid.arrange(g1, g2, g3, g4)
  
}




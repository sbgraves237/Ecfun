tableCountAverage <- function(x, y, data, useNA = c("no", "ifany", "always"), 
                              na.rm=TRUE, decreasing=TRUE, ...){
##
## 1. table 
##
  xTab <- table(data[, x], useNA=useNA, ...)
## 
## 2. sort? 
##
  if(!is.na(decreasing)){
    xTab <- sort(xTab, decreasing)
  }
##
## 3. compute means for each level of x 
##
  Mean <- function(dat){
    dt <- dat[, y, drop=TRUE]
    mean(dt, na.rm=na.rm)
  }
  yMeans <- by(data, data[, x, drop=TRUE], Mean)
##
## 4. Done 
##
  out <- data.frame(x = names(xTab), n=as.numeric(xTab), 
                    p=as.numeric(xTab/sum(xTab)), 
                    mean=as.numeric(yMeans[names(xTab)]) )
  xNA <- which(is.na(out[, 'x']))
  if(length(xNA)>0){
    inNA <- which(is.na(data[, x]))
    out[xNA, 'mean'] <- mean(data[inNA, y], na.rm=na.rm) 
  }
  names(out) <- c(x, 'n', 'p', y)
  out
}
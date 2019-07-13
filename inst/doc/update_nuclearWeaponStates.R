## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----export--------------------------------------------------------------
library(Ecdat)
availInPkg <- objects(2, pattern='nuclearWeaponStates')
canWrite <- FALSE 
if('nuclearWeaponStates' %in% availInPkg){
  data(nuclearWeaponStates)
  canWr <- try(write.csv(nuclearWeaponStates, 
            'nuclearWeaponStates.csv', 
            row.names=FALSE))
  if(!inherits(canWr, 'try-error')){
    canWrite <- TRUE
  }
} 
getwd()

## ----readCSV-------------------------------------------------------------
library(Ecfun)
if(canWrite){
  nWS <- read.csv(
    'nuclearWeaponStates.csv', 
    stringsAsFactors = FALSE)
  nuclearWeaponStates <-
    asNumericDF(nWS, 
          ignore=1:2, Dates=3) 
}

## ----chk1----------------------------------------------------------------
if(canWrite){
  nmsNucWeapSt <- names(nuclearWeaponStates)
  if('firstTest' %in% nmsNucWeapSt){
    dDays <- diff(
      nuclearWeaponStates[,
                    'firstTest'])
  } else {
    print(nmsNucWeapSt)
    stop("'firstTest' not in names(nuclearWeaponStates)")
  }
  dYrs <- (dDays / 365.25)

  if('yearsSinceLastFirstTest' %in% nmsNucWeapSt){
    edYrs <- (nuclearWeaponStates[-1,
        'yearsSinceLastFirstTest'] 
          - dYrs)
    cbind(dDays, dYrs, edYrs)

    oopsDifYrs <- which(abs(
      nuclearWeaponStates[-1,
        'yearsSinceLastFirstTest'] - 
            dYrs)>.005)
  }
  if(length(oopsDifYrs)>1){
    cat('difftime compute errors. ', 
        ' bad rows = ')
    print(oopsDifYrs)
    oopsi <- unique(c(oopsDifYrs, 
              oopsDifYrs+1))
    cbind(oopsi, nuclearWeaponStates[oopsi, 
        1:3])
  }
}

## ----nukes---------------------------------------------------------------
if(canWrite){
  nukes <- rowSums(nuclearWeaponStates[, 
    c('nYieldNA', 'nLowYield', 'nMidYield',
      'nHighYield')])
  dnuk <- (nuclearWeaponStates[,
      'nuclearWeapons'] - nukes)
  if(length(oopsNuk <- which(dnuk != 0))>0){
    cat('count errors.  bad rows =')
    print(oopsNuk)
    cbind(oopsi, nuclearWeaponStates[, -(2:3)])
  }
}

## ----plot----------------------------------------------------------------
if(canWrite){
  data(nuclearWeaponStates)
  plot(yearsSinceLastFirstTest~firstTest,
       nuclearWeaponStates, las=1, 
       type='h', xlab='', ylab='')
  with(nuclearWeaponStates, 
    text(firstTest, yearsSinceLastFirstTest, ctry))
}

## ----svg-----------------------------------------------------------------
if(canWrite){
  svg('Time2nextNuclearState.svg')
  cex. <- 1.5
  plot(yearsSinceLastFirstTest~firstTest,
       nuclearWeaponStates, las=1, 
       type='h', xlab='', ylab='', cex.axis=cex.)
  with(nuclearWeaponStates, 
    text(firstTest, yearsSinceLastFirstTest, ctry, 
         cex=cex.))
  dev.off()
}

## ----save----------------------------------------------------------------
if(canWrite){
  save(nuclearWeaponStates, 
       file='nuclearWeaponStates.rda')
}


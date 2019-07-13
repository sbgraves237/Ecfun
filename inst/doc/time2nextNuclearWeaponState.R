## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----plot----------------------------------------------------------------
library(Ecdat)
data(nuclearWeaponStates)
plot(yearsSinceLastFirstTest~firstTest, 
     nuclearWeaponStates, type='h', 
     xlab='', ylab='', las=1, 
     bty='n')
title(
  'Figure 1. Time between\nnew nuclear nations')
mtext('Note: The US is not on this plot,\nbecause it had no predecessors.', 1, 3)
mtext('years from the\nprevious "first test"',
      2, 2)
with(nuclearWeaponStates, 
  text(firstTest, yearsSinceLastFirstTest,
       ctry, xpd=TRUE))

## ----ploty---------------------------------------------------------------
library(Ecdat)
plot(yearsSinceLastFirstTest~firstTest, 
     nuclearWeaponStates, type='n', 
     xlab='', ylab='', las=1, log='y',
     bty='n')
title(
  'Figure 2. Time between\nnew nuclear nations')
mtext('Note: The US is not on this plot,\nbecause it had no predecessors.', 1, 3)
mtext('years from the\nprevious "first test"', 2, 2)

with(nuclearWeaponStates, 
  text(firstTest, yearsSinceLastFirstTest,
       ctry, xpd=TRUE))

## ----ngssm---------------------------------------------------------------
daysSinceFirstTest <- difftime(Sys.Date(), 
        nuclearWeaponStates$firstTest[1], 
        units='days')
y_firstTests <- rep(0, daysSinceFirstTest)



## ----png-----------------------------------------------------------------
if(FALSE){
  png('nuclearProliferation.png', 1440, 1200)
  par(mar=c(15, 12, 4, 2)+.1)
  plot(yearsSinceLastFirstTest~firstTest, 
     nuclearWeaponStates, type='h', 
     xlab='', ylab='', las=1, cex.axis=4, 
     bty='n', axes=FALSE, lwd=2)
  xyr <- seq(1950, 2000, 10)
  xt. <- paste0(xyr, '-01-01')
  xticks <- as.Date(xt.)
  axis(1, xticks, labels=FALSE, lwd=2)
  axis(1, xticks, xyr, cex.axis=4, lwd=0, line=2)
#axis(1, seq(1950, 2000, by=10), cex.axis=4, lwd=0, line=1)
  axis(2, cex.axis=4, las=1, lwd=2)
  title('Time between new nuclear nations', 
      cex.main=4)
  mtext(paste0(
    'Note: The US is not on this plot,', 
    '\nbecause it had no predecessors.'), 
        1, 12, cex=4)
  mtext('years from the\nprevious "first test"',
      2, 5, cex=4)
  with(nuclearWeaponStates, 
    text(firstTest, yearsSinceLastFirstTest,
       ctry, xpd=TRUE, cex=4))
  dev.off()
}

## ----svg-----------------------------------------------------------------
if(FALSE){
  svg('nuclearProliferation.svg', 14, 11)
  par(mar=c(9, 8, 4, 2)+.1)
  plot(yearsSinceLastFirstTest~firstTest, 
     nuclearWeaponStates, type='h', 
     xlab='', ylab='', las=1, cex.axis=2, 
     bty='n')
  title('Time between new nuclear nations', 
      cex.main=2)
  mtext(paste0(
    'Note: The US is not on this plot,', 
    '\nbecause it had no predecessors.'), 
        1, 6, cex=2)
  mtext('years from the\nprevious "first test"',
      2, 4, cex=2)
  with(nuclearWeaponStates, 
  text(firstTest, yearsSinceLastFirstTest,
       ctry, xpd=TRUE, cex=2))
  dev.off()
}


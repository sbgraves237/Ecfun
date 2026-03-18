test_that("getMaddisonSources", {
  Dat <- data.frame(cat=c('g', 'h', 'a', NA, 'a', 'g', 'g'), 
                    num=c( NA,  1,   2,   3,   4,   5,  6))
  catTabDecr <- tableCountAverage('cat', 'num', Dat, na.rm=FALSE)
  catTabIncr <- tableCountAverage('cat', 'num', Dat, useNA='ifany', 
                                  decreasing=FALSE)
  catTab <- tableCountAverage('cat', 'num', Dat[-4, ], useNA='always', 
                              decreasing=NA)

  cTd <- data.frame(cat = c('g', 'a', 'h'), 
                    count=c( 3,   2,   1), 
                    num = c( NA,  3,   1))
  cTi <- data.frame(cat = c('h', NA, 'a', 'g'), 
                    count=c( 1,  1,   2,   3), 
                    num = c( 1,  3,   3, 5.5))
  cT <- data.frame(cat = c('a', 'g', 'h', NA), 
                   count=c( 2,   3,   1,   0), 
                   num =c(  3, 5.5,   1,  NaN))
  
  expect_identical(catTabDecr, cTd)

  expect_identical(catTabIncr, cTi)
  
  expect_identical(catTab, cT)
})

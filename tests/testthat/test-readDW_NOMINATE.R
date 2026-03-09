test_that("getMaddisonSources", {
  # Wrap in try(...) so it won't throw an error 
  # if the Voteview website is not available. 
  
  Nominate <- try(readDW_NOMINATE())
#
  if(!inherits(Nominate, "try-error")){
    expect_identical(inherits(Nominate, 'data.frame'), TRUE)
    expect_identical(ncol(Nominate), 25L) 
    expect_gt(length(unique(Nominate$party_code)), 52L)
    expect_gt(length(unique(Nominate$Party)), 50L)
    #col24 = 'party' ordered
    #col25 = 'Dem', 'Rep', 'other', recoding Fedseralists and Whigs as Rep
    expect_identical(levels(Nominate$Party2), c('Dem', 'Rep', 'other'))
  }
})

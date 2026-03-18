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
    expect_identical(length(unique(Nominate$Party2)), 3L)
  }
})

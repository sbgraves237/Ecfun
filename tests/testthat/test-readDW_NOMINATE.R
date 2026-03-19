test_that("getMaddisonSources", {
  # Wrap in try(...) so it won't throw an error 
  # if the Voteview website is not available. 
  
  Nominate <- try(readDW_NOMINATE())
#
  if(!inherits(Nominate, "try-error")){
#   Nominate    
    expect_identical(inherits(Nominate, 'data.frame'), TRUE)
    expect_identical(ncol(Nominate), 25L) 
    expect_gt(length(unique(Nominate$party_code)), 52L)
    expect_gt(length(unique(Nominate$Party)), 50L)
    expect_identical(length(unique(Nominate$Party2)), 3L)
    
#   CongressMembers    
    CongressMembers <- attr(Nominate, "CongressMembers")
    expect_true(inherits(CongressMembers, 'data.frame'))
    expect_gt(nrow(CongressMembers), 118L)
    expect_identical(names(CongressMembers), 
                      c('congress', 'Year', 'n') )

#   CongrssParty        
    CongressParty <- attr(Nominate, "CongressParty")
    expect_true(inherits(CongressParty, 'data.frame'))
    expect_gt(nrow(CongressParty), 428L)
    expect_identical(names(CongressParty), 
          c('congress', 'Year', 'Party', 'n', 'p', 'meanNominate_dim1') )
    
# Percent in top two parties in each Congress? 
    top2 <- with(Nominate, by(Party, Year, function(x){
      tabx <- sort(table(x, useNA="ifany"), decreasing=TRUE)
      tot <- sum(tabx)
      p2 <- (c(tabx[1:2], other=tot-sum(tabx[1:2]))/tot)
    })) 
    p2 <- sapply(top2, function(x)sum(x[1:2]))


    # The top 2 parties in the Congress that began in 1823 were
    # the "Adams-Clay Republican Party" and the "Crawford Republican Party".
  }
})

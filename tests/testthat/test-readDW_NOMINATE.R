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

#   CongressParty        
    CongressParty <- attr(Nominate, "CongressParty")
    expect_true(inherits(CongressParty, 'data.frame'))
    expect_gt(nrow(CongressParty), 428L)
    expect_identical(names(CongressParty), 
          c('congress', 'Year', 'Party', 'n', 'p', 'meanNominate_dim1') )
    
# Check party_code, etc.   
    PartyCodes <- with(Nominate, by(party_code, Party, table))
    table(nPartyCodes <- sapply(PartyCodes, length))
    PartyCodes[nPartyCodes>1]
    # 'Constitutional Unionist Party' and 'Union Labor Party' have 2 codes each
    # total 18 member-Congress pairs. 
    # All other 'Party' names have only one 'party_code'
    
    # Percent in top two parties in each Congress? 
    top2 <- with(Nominate, by(Party, Year, function(x){
      tabx <- sort(table(x, useNA="ifany"), decreasing=TRUE)
      tot <- sum(tabx)
      p2 <- (c(tabx[1:2], other=tot-sum(tabx[1:2]))/tot)
    })) 
    p2 <- sapply(top2, function(x)sum(x[1:2]))
    top2[p2<.8]
    (mostDiverse <- as.integer(names(top2[p2<.8])))
    # The top 2 parties in the Congress that began in 1823 were
    # the "Adams-Clay Republican Party" and the "Crawford Republican Party".
    mostDiverseCong <- subset(CongressParty, Year==mostDiverse)
#   On 2026-03-19 this returned:     
    #   congress Year                       Party  n           p meanNominate_dim1
    #35       18 1823 Adams-Clay Republican Party 86 0.312727273        0.30736471
    #36       18 1823   Crawford Republican Party 78 0.283636364       -0.10872727
    #37       18 1823          Jackson Republican 77 0.280000000       -0.02653947
    #38       18 1823 Adams-Clay Federalist Party 20 0.072727273        0.31430000
    #39       18 1823    Jackson Federalist Party  7 0.025454545        0.13185714
    #40       18 1823 Democratic-Republican Party  5 0.018181818        0.29000000
    #41       18 1823   Crawford Federalist Party  2 0.007272727        0.20200000
    # On the basis of this, we classify the Adams-Clay Republican Party, 
    # Adams-Clay Federalist Party, Jackson Federalist Party, and  
    # Crawford Federalist Party with Fed_Whig_Rep, and the 
    # Crawford Republican Party with DemRep_Jackson_Dem. 
    # For this year, the Democratic-Republican Party seems to also belong 
    # with Fed_Whig_Rep. However, its record in other yeas is more like 
    # the DemRep_Jackson_Dem cluster and will be left that way. 
    
    # What about all the "Independents" = 
    # "Independent", "Independent Democrat", "Independent Republican", "other", 
    # and "Independent Whig"? 
    
    Indep <- subset(CongressParty, startsWith(Party, 'Independent') )
  }
})

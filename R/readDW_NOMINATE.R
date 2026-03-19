readDW_NOMINATE <- function(file=
  "https://voteview.com/static/data/out/members/HSall_members.csv", 
  PartyNames = matrix( c(
    "100", "Democratic Party", "DemRep_Jackson_Dem", 
    "200", "Republican Party", "Fed_Whig_Rep", 
    "1", "Federalist Party", "Fed_Whig_Rep", 
    "13", "Democratic-Republican Party", "DemRep_Jackson_Dem", 
    "22", "Adams Party", "Fed_Whig_Rep", 
    "26", "Anti Masonic Party", "other", 
    "29", "Whig Party", "Fed_Whig_Rep", 
    "37", "Constitutional Unionist Party", "other", 
    "44", "Nullifier Party", "other", 
    "46", "States Rights Party", "other", 
    "108", "Anti-Lecompton Democrats", "other", 
    "112", "Conservative Party", "other", 
    "114", "Readjuster Party", "other", 
    "117", "Readjuster Democrats", "other", 
    "203", "Unconditional Unionist Party", "other", 
    "206", "Unionist Party", "other", 
    "208", "Liberal Republican Party", "other", 
    "213", "Progressive Republican Party", "other", 
    "300", "Free Soil Party", "other", 
    "310", "American Party", "other", 
    "326", "National Greenbacker Party", "other", 
    "340", "Populist PARTY", "other", 
    "347", "Prohibitionist Party", "other", 
    "354", "Silver Republican Party", "other", 
    "355", "Union Labor Party", "other", 
    "356", "Union Labor Party", "other", 
    "370", "Progressive Party", "other", 
    "380", "Socialist Party", "other", 
    "402", "Liberal Party", "other", 
    "403", "Law and Order Party", "other", 
    "522", "American Labor Party", "other", 
    "523", "American Labor Party (La Guardia)", "other", 
    "537", "Farmer-Labor Party", "other", 
    "555", "Jackson Party", "DemRep_Jackson_Dem", 
    "1060", "Silver Party", "other", 
    "1111", "Liberty Party", "other", 
    "1116", "Conservative Republicans", "other", 
    "1275", "Anti-Jacksonians", "Fed_Whig_Rep", 
    "1346", "Jackson Republican", "other", 
    "3333", "Opposition Party", "Fed_Whig_Rep", 
    "3334", "Opposition Party (36th)", "other", 
    "4000", "Anti-Administration Party", "DemRep_Jackson_Dem", 
    "4444", "Constitutional Unionist Party", "other", 
    "5000", "Pro-Administration Party", "Fed_Whig_Rep", 
    "6000", "Crawford Federalist Party", "other", 
    "7000", "Jackson Federalist Party", "other", 
    "7777", "Crawford Republican Party", "other", 
    "8000", "Adams-Clay Federalist Party", "other", 
    "8888", "Adams-Clay Republican Party", "other", 
    "328", "Independent", "other", 
    "329", "Independent Democrat", "other", 
    "331", "Independent Republican", "other", 
    "603", "Independent Whig", "other"), 
    byrow=TRUE, ncol=3, dimnames=list(NULL, 
          c('party_code', 'Party', 'Party2')) ), ...){
##
## 1. read
##   
  dwn <- readr::read_csv(file, ...)
  readNames <- colnames(dwn) 
  if(is.null(readNames)){
    warning('File read does not have colnames; file = ', file, 
            '; dim of file read = ', paste(dim(dwn), collapse=', '))
  }
  if('Year' %in% readNames){
    warning("'Year' in colnames of file read,", 
      "unlike previous files read with this function.")
  } else {
    dwn$Year <- (2*dwn$congress + 1787)
  }
##
## 2. check colnames(PartyNames)
##
  codeNms <- colnames(PartyNames)
  if(is.null(codeNms)){
    stop('No colnames with PartyNames')
  }
  codeNm <- codeNms[1]
  if(!(codeNm %in% readNames)){
    stop('colnames(PartyNames)[1] = ', codeNm, 
         ' not in colnames of the file read = ', 
         paste(readNames, collapse=', '))
  }
  oops2 <- which(is.na(PartyNames[, 1, drop=TRUE]))
  if(length(oops2)>0){
    stop('NA(s) found in row(s) ', paste(oops2, collapse=', '), 
         ' of PartyNames')
  }
  oops3 <- which(!(dwn[, codeNm, drop=TRUE] %in% PartyNames[, 1]))
  if(length(oops3)>0){
    stop(codeNm, ' = ', dwn[oops3, codeNm], 
         ' not found in PartyNames[, 1]')
  }
  oops4 <- which(codeNms[-1] %in% readNames)
  if(length(oops4)>0){
    warning(paste(codeNms[oops4+1], collapse=', '), 
            'are in colnames of the file read = ', 
            paste(readNames, collapse=', '), 
            '. They will be overwritten.')
  }
## 
## 3. add PartyNames columns
## 
  for(newCol in codeNms[-1]){
    newCds <- PartyNames[, newCol]
    names(newCds) <- PartyNames[, 1]
    newC <- newCds[as.character(dwn[, codeNm, drop=TRUE])]
    dwn[, newCol] <- as.character(newC)
  }
##
## 4, Add CongressParty attribute
##
  cp <- by(dwn, dwn$Year, function(x){
    tableCountAverage('Party', 'nominate_dim1', data=x, useNA = "ifany")
  })
  Ncp <- length(cp)
  ncp <- sapply(cp, nrow)
  Yr <- as.integer(names(cp))

  CPdat <- NULL
  for(icp in 1:Ncp){
    CPdat <- rbind(CPdat, cp[[icp]])
  }
  
  CP <- cbind(congress=rep((Yr-1787)/2L, ncp), 
              Year = rep(Yr, ncp), CPdat)
  names(CP)[6] <- 'meanNominate_dim1'
  attr(dwn, 'CongressParty') <- CP 
##
## 5. Add CongressMembers attribute
##
  cm <- table(dwn$congress)
  cng <- as.integer(names(cm))
  CM <- data.frame(congress=cng, Year=1787L+2L*cng, n=as.integer(cm))
  attr(dwn, 'CongressMembers') <- CM
##
## 6. Done  
##  
  dwn
}

readDW_NOMINATE <- function(file=
  "https://voteview.com/static/data/out/members/HSall_members.csv", 
  PartyNames = matrix( c(
    "100", "Democratic Party", "DemRep_Jackson_Dem", "DemRep_Jackson_Dem_", 
    "200", "Republican Party", "Fed_Whig_Rep", "Fed_Whig_Rep_", 
    "1", "Federalist Party", "Fed_Whig_Rep", "Fed_Whig_Rep_", 
    "13", "Democratic-Republican Party", "DemRep_Jackson_Dem", 
          "DemRep_Jackson_Dem_", 
    "22", "Adams Party", "Fed_Whig_Rep", "Fed_Whig_Rep_", 
    "26", "Anti Masonic Party", "other", "other_", 
    "29", "Whig Party", "Fed_Whig_Rep", "Fed_Whig_Rep_", 
    "37", "Constitutional Unionist Party", "other", "other_", 
    "44", "Nullifier Party", "other", "other_", 
    "46", "States Rights Party", "other", "other_", 
    "108", "Anti-Lecompton Democrats", "other", "other_", 
    "112", "Conservative Party", "other", "other_", 
    "114", "Readjuster Party", "other", "other_", 
    "117", "Readjuster Democrats", "other", "other_", 
    "203", "Unconditional Unionist Party", "other", "other_", 
    "206", "Unionist Party", "other", "other_", 
    "208", "Liberal Republican Party", "other", "other_", 
    "213", "Progressive Republican Party", "other", "other_", 
    "300", "Free Soil Party", "other", "other_", 
    "310", "American Party", "other", "other_", 
    "326", "National Greenbacker Party", "other", "other_", 
    "340", "Populist PARTY", "other", "other_", 
    "347", "Prohibitionist Party", "other", "other_", 
    "354", "Silver Republican Party", "other", "other_", 
    "355", "Union Labor Party", "other", "other_", 
    "356", "Union Labor Party", "other", "other_", 
    "370", "Progressive Party", "other", "other_", 
    "380", "Socialist Party", "other", "other_", 
    "402", "Liberal Party", "other", "other_", 
    "403", "Law and Order Party", "other", "other_", 
    "522", "American Labor Party", "other", "other_", 
    "523", "American Labor Party (La Guardia)", "other", "other_", 
    "537", "Farmer-Labor Party", "other", "other_", 
    "555", "Jackson Party", "DemRep_Jackson_Dem", "DemRep_Jackson_Dem_", 
    "1060", "Silver Party", "other", "other_", 
    "1111", "Liberty Party", "other", "other_", 
    "1116", "Conservative Republicans", "other", "other_", 
    "1275", "Anti-Jacksonians", "other", "Fed_Whig_Rep_", 
    "1346", "Jackson Republican", "other", "other_", 
    "3333", "Opposition Party", "other", "Fed_Whig_Rep_", 
    "3334", "Opposition Party (36th)", "other", "other_", 
    "4000", "Anti-Administration Party", "other", "DemRep_Jackson_Dem_", 
    "4444", "Constitutional Unionist Party", "other", "other_", 
    "5000", "Pro-Administration Party", "other", "Fed_Whig_Rep_", 
    "6000", "Crawford Federalist Party", "other", "other_", 
    "7000", "Jackson Federalist Party", "other", "other_", 
    "7777", "Crawford Republican Party", "other", "other_", 
    "8000", "Adams-Clay Federalist Party", "other", "other_", 
    "8888", "Adams-Clay Republican Party", "other", "other_", 
    "328", "Independent", "other", "other_", 
    "329", "Independent Democrat", "other", "other_", 
    "331", "Independent Republican", "other", "other_", 
    "603", "Independent Whig", "other", "other_"), 
    byrow=TRUE, ncol=4, dimnames=list(NULL, 
          c('party_code', 'Party', 'Party2', 'Party3')) ), ...){
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
    dwn[, newCol] <- newCds[as.character(dwn[, codeNm, drop=TRUE])]
  }
##
## 4. done  
##  
  dwn
}

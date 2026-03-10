readDW_NOMINATE <- function(file=
  "https://voteview.com/static/data/out/members/HSall_members.csv", 
  ...){
##
## 1. read
##   
  dwn <- readr::read_csv(file, ...)
  dwn$Year <- (2*dwn$congress + 1787)
##
## 2. Convert party_code to ordered  
##  
# Recode party_code == 356 to 355
#  Dwn <- dwn
  p_c <- dwn$party_code
  p_c[p_c==356] <- 355
  p_c[p_c==37] <- 4444
  #  Dwn$party_code <- p_c
# Party from https://voteview.com/articles/data_help_parties
# without 356 = duplicate "Union Labor Party"  
  pty <- c("
    100 	Democratic Party
    200 	Republican Party
    1 	Federalist Party
    13 	Democratic-Republican Party
    22 	Adams Party
    26 	Anti Masonic Party
    29 	Whig Party
    44 	Nullifier Party
    46 	States Rights Party
    108 	Anti-Lecompton Democrats
    112 	Conservative Party
    114 	Readjuster Party
    117 	Readjuster Democrats
    203 	Unconditional Unionist Party
    206 	Unionist Party
    208 	Liberal Republican Party
    213 	Progressive Republican Party
    300 	Free Soil Party
    310 	American Party
    326 	National Greenbacker Party
    340 	Populist PARTY
    347 	Prohibitionist Party
    354 	Silver Republican Party
    355 	Union Labor Party
    370 	Progressive Party
    380 	Socialist Party
    402 	Liberal Party
    403 	Law and Order Party
    522 	American Labor Party
    523 	American Labor Party (La Guardia)
    537 	Farmer-Labor Party
    555 	Jackson Party
    1060 	Silver Party
    1111 	Liberty Party
    1116 	Conservative Republicans
    1275 	Anti-Jacksonians
    1346 	Jackson Republican
    3333 	Opposition Party
    3334 	Opposition Party (36th)
    4000 	Anti-Administration Party
    4444 	Constitutional Unionist Party
    5000 	Pro-Administration Party
    6000 	Crawford Federalist Party
    7000 	Jackson Federalist Party
    7777 	Crawford Republican Party
    8000 	Adams-Clay Federalist Party
    8888 	Adams-Clay Republican Party
    328 	Independent
    329 	Independent Democrat
    331 	Independent Republican
    603 	Independent Whig
    ")
  Pty <- strsplit(pty, '\n')[[1]]
  Pty1 <- tail(Pty, -1)
  Pty2 <- strsplit(Pty1, '\t')
  Pty2h <- head(Pty2, -1)
  Pty2u <- unlist(Pty2h)
  Pty2t <- matrix(Pty2u, ncol=2, byrow=TRUE)
  Pty2t[, 1] <- gsub(' ', '', Pty2t[, 1])
  PtyVec <- Pty2t[,2]
  names(PtyVec) <- Pty2t[, 1]
  P_C <- PtyVec[as.character(p_c)]
  P_Ctbl <- table(P_C)
  P_Ctbls <- sort(P_Ctbl, TRUE)
  PtyOd <- ordered(as.character(P_C), levels=names(P_Ctbls))
  dwn$Party <- PtyOd
##
## 3. Collapse Party to 'Dem', 'Rep', and 'other', 
##    including Federalists, Whigs, etc. with Rep, etc. 
  DemCds <- c(100, 13, 555, 4000) 
  RepCds <- c(200, 29,   1, 1275, 22, 5000, 333)
  Party2 <- rep('other', nrow(dwn))
  Party2[p_c %in% DemCds] <- 'Dem'
  Party2[p_c %in% RepCds] <- 'Rep'
  dwn$Party2 <- ordered(Party2, c('Dem', 'Rep', 'other'))
##
## 4. done  
##  
  dwn
}

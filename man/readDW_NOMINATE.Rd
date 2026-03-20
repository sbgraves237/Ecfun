\name{readDW_NOMINATE}
\alias{readDW_NOMINATE}
\title{
  Read the DW-NOMINATE data from their website. 
}
\description{
  Read \href{https://voteview.com/static/data/out/members/HSall_members.csv}{the DW-NOMINATE data} 
  from their website using \code{\link[readr]{read_csv}}, 
  adding a \code{Year} = \code{2*congress+1787}, which is the 
  first year of each 2-year congress. 
  
  NOTE: If you use any of this in a publication, please cite the data source as 
  described at \href{https://voteview.com/data}{voteview.com}. As of 
  2026-03-09, this page said: 
  
  Please cite the dataset as:
  Lewis, Jeffrey B., Keith Poole, Howard Rosenthal, Adam Boche, Aaron Rudkin, 
  and Luke Sonnet (2026). Voteview: Congressional Roll-Call Votes Database. 
  https://voteview.com/
}
\usage{
readDW_NOMINATE(file=
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
    "6000", "Crawford Federalist Party", "Fed_Whig_Rep", 
    "7000", "Jackson Federalist Party", "Fed_Whig_Rep", 
    "7777", "Crawford Republican Party", "DemRep_Jackson_Dem", 
    "8000", "Adams-Clay Federalist Party", "Fed_Whig_Rep", 
    "8888", "Adams-Clay Republican Party", "Fed_Whig_Rep", 
    "328", "Independent", "other", 
    "329", "Independent Democrat", "DemRep_Jackson_Dem", 
    "331", "Independent Republican", "Fed_Whig_Rep", 
    "603", "Independent Whig", "other"), 
    byrow=TRUE, ncol=3, dimnames=list(NULL, 
          c('party_code', 'Party', 'Party2')) ), ...)
}
\arguments{
  \item{file}{
    \code{file} argument passed to \code{\link[readr]{read_csv}}.
  }
  \item{PartyNames}{
    \code{\link{matrix}} or \code{\link{data.frame}}, with 
    \code{\link{colnames}} starting with the name of a column of the 
    \code{\link{data.frame}} read as the first step of this function. The rest
    of \code{colnames} are names of columns to add to the \code{data.frame} 
    read. By default, the first column is \code{party_code}. The second is 
    \code{Party} with contents translating \code{party_code} into the English 
    names of the parties in 
    \href{https://voteview.com/articles/data_help_parties}{\code{data_help_parties} 
    on \code{voteview.com}}. The third and fourth columns of \code{PartyNames} 
    are \code{Party2} and \code{Party3}, to support translating the parties 
    into groups two slightly different ways. \code{Party2} creates 
    \code{Fed_Whig_Rep}, \code{DemRep_Jackson_Dem}, and \code{other} in 
    including only the parties named in the two main groups. \code{Party3} 
    aggregates some but not all minor and shortlived parties with the two main 
    groups, leaving only slightly over 2 percent of the members of Congress in 
    \code{other} as of 2026-03-09. 
    
    Thus, by default, \code{Party2} and \code{Party3} each create three similar 
    but slightly different combinations of historical parties. 
    
    The three levels of \code{Party2} are \code{DemRep_Jackson_Dem}, 
    \code{Fed_Whig_Rep}, and \code{other}: \code{DemRep_Jackson_Dem} combines 
    100 = modern Democratic party with 13 = Democratic-Republican Party and 
    555 = Jackson Party. \code{Fed_Whig_Rep} combines 200 = modern Republican 
    party with 29 = Whig and 1 = Federalists. As of 2026-03-16, \code{other} 
    is less than 4 percent of all individuals in the \code{DW_NOMINATE} 
    database. 
    
    The three levels of \code{Party3} are \code{DemRep_Jackson_Dem_}, 
    \code{Fed_Whig_Rep_}, and \code{other_}; note that "_" is apended to the 
    names of the default levels of \code{Party2}. \code{DemRep_Jackson_Dem_} 
    adds 4000 = anti-administration to the three combined into 
    \code{DemRep_Jackson_Dem}. \code{Fed_Whig_Rep_} adds 1275 = 
    Anti-Jacksonians + 22 = Adams + 5000 = pro-administration + 
    3333 = Opposition Party to those combined into \code{Fed_Whig_Rep}. As of 
    2026-03-16, this leaves just over 2 percent in \code{other_}. 
    
    NOTE: As of 2026-03-09, names "Union Labor Party" and "Constitutional 
    Unionist Party" had two different codes each: \code{party_code} = 355 and 
    366 both mapped to "Union Labor Party" and \code{party_code} = 37 and 4444
    both mapped to "Constitutional Unionist Party". The first included 14 
    officials in the US Congress in the 1851 and 1961 sessions combined. The 
    second had 4 officials in the US Congress between 1887 and 1919. (Both 
    are coded "other" in \code{Party2} and \code{Party4}.)
  }
  \item{\dots}{
    optional arguments for \code{\link[readr]{read_csv}}.
  }
}
\details{
  This is written to make it easy for users to 
  download the \code{DW-NOMINATE} data from their 
  website, assuming it should be easier to remember 
  \code{readDW_NOMINATE} than 
  
  \code{readr::read_csv("https://voteview.com/static/data/out/members/HSall_members.csv")}. 
}
\source{
Embedded in an 
\href{https://github.com/voteview/articles/blob/master/docs/party_polarization/party_polarization.Rmd}{R Markdown vignette} 
by 
\href{https://polisci.ucla.edu/person/jeffrey-b-lewis/}{UCLA political science professor Jeff Lewis} 
in the \href{https://github.com/voteview}{\code{voteview}} project on `GitHub`. 
}
\value{
  This returns a \code{\link[tibble]{tibble}} read from \code{file} with 
  additional columns specified by \code{PartyNames} and with 
  \code{CongressMembers} and \code{CongressParty} attributes.
  
  With the default \code{file} and \code{PartyNames}, the \code{tibble} 
  returned has the following columns: 
  \item{congress}{
    \code{number} of the Congress starting with 1 in 1789.
  }
  \item{chamber}{
    \code{character} 'House', 'Senate' or 'President'
  }
  \item{icpsr}{
    \code{number} \code{icpsr} (\href{https://en.wikipedia.org/wiki/Inter-university_Consortium_for_Political_and_Social_Research}{number assigned by the Inter-university Consortium for Political and Social Research (ICPSR)}).
  }
  \item{state_icpsr}{
    \code{number} for the state used by ICPSR. 
  }
  \item{district_code}{
    \code{number} between 0 and 99 indicating the district number 
    within the state. This is 0 when (chamber \%in\% 
    c('President', 'Senate') and occasionally when (chamber
    == 'House'). "At-large" members of the US House are coded
    98 or 99. There were some before 1970. However, as of 
    2024-10-01, but there have been none since 1970. 
  }
  \item{state_abbrev}{
    Either 'USA' or a 2-letter abbreviation for this state in the US. 
  }
  \item{party_code}{
    positive \code{numeric}. As of 2024-09-30, over 80 percent 
    of the members of Congress since 1857 have been either 
    100 (Democrats) or 200 (Republicans), and since 1943, less 
    than 1 percent of the US Congress has not been either 100 
    or 200. 
  }
  \item{occupancy, last_means}{
    \code{numeric} = 0:7 or `NA` with all `NA`s prior to 2017. 
  }
  \item{bioname}{
    \code{character} name of politician, starting with 
    "WASHINGTON, George". 
  }
  \item{bioguide_id}{
    \code{character} The ID code used by the 
    \href{https://bioguide.congress.gov/}{Biographical directory of the United States Congress}, 
    being the first character of the last name of the person
    followed by a 6-digit number or `NA` for US Presidents who 
    were never members of Congress. 
  }
  \item{born, died}{
    \code{numeric} 4-digit birth year or `NA`
  }
  \item{nominate_dim1, nominate_dim2}{
    \code{numeric} between -1 or 1 or `NA` described
    in Poole (2005). 
  }
  \item{nominate_log_likelihood}{
    \code{numeric} negative number or `NA`
  }
  \item{nominate_goe_mean_probabilty}{
    \code{numeric} number between 0 and 1 or `NA`
  }
  \item{nominate_number_of_votes}{
    \code{numeric} positive number or `NA`
  }
  \item{nominate_number_of_errors}{
    \code{numeric} nonnegative number or `NA`
  }
  \item{conditional}{ \code{logical} or `NA`}
  \item{nokken_poole_dim1, nokken_poole_dim2}{
    \code{numeric} between -1 or 1 or `NA` 
    described by Nokken and Poole (2004). 
  }
  \item{Year}{
    If Year \%in\% names(tblOfFile <- readr::read_csv(file, ...)), keep 
    whatever is read. Else, replace with tblOfFile[, 'congress']+1787. 
    (The latter is the default as of 2026-03-13.) 
  }
  \item{Party}{
    as described above with the argument \code{party_code}. 
  }
  \item{Party2}{
    as described above with the argument \code{party_code}. 
  }

  The \code{CongressMembers} attribute is a \code{data.frame} with the 
  following columns: 
  
  \item{congress}{
    integer starting with 1 for the first Congress, which met from 1789 to 
    1791. 
  }
  \item{Year}{
    integer year for the start of each Congress. 
  }
  \item{n}{
    integer number of members of the US House and Senate plus 1 for the 
    president.
  }
  
  The \code{CongressParty} attribute is a \code{data.frame} with the following 
  columns: 
  
  \item{Congress}{ Integer number of the Congress.} 
  \item{Year}{
    Integer first year of the Congress = 1789 for Congress 1, 1791 for 
    Congress 2, etc. 
  }
  \item{Party}{
    Character string giving the name of the party. 
  }
  \item{n}{
    number of members in that \code{Party} in that \code{Congress}.
  }
  \item{p}{
    Proportion of that \code{Congress} in that \code{Party}.
  }
  \item{meanNominate_dim1}{
    \code{mean(nominate_dim1, na.rm=TRUE)} for that \code{Party} in that 
    \code{Congress}. 
  }
}
\references{
\href{https://legacy.voteview.com}{\code{Voteview.com} website}. 

Timothy P. Nokken and Keith T. Poole (2004) 
"Congressional Party Defection in American History." 
Legislative Studies Quarterly, 29:545-568,. 

Keith T. Poole (2005) Spatial models of parliamentary voting 
(Cambridge U. Pr.). 

\href{https://voteview.com/}{Jeffrey B. Lewis, Keith Poole, Howard Rosenthal, 
Adam Boche, Aaron Rudkin, and Luke Sonnet (2026) "Voteview: Congressional 
Roll-Call Votes Database}, 

}
\author{Spencer Graves}
\seealso{
  \code{\link[readr]{read_csv}}
}
\examples{
# Wrap in try(...) so it won't throw an error 
# if the Voteview website is not available. 

Nominate <- try(readDW_NOMINATE())

if(inherits(Nominate, 'tbl')){

  CongressMembers <- attr(Nominate, "CongressMembers")
  plot(n~Year, CongressMembers, type='b')
  
  CongressParty <- attr(Nominate, "CongressParty")
  MaddisonData::ggplotPath('Year', 'meanNominate_dim1', 'Party', 
        CongressParty, logy=FALSE, legend.position='none')
        
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
  plot(as.numeric(names(p2)), p2, type='l')
  top2[p2<.8]
  (mostDiverse <- as.integer(names(top2[p2<.8])))
  abline(v=mostDiverse, col='grey', lty='dotted')
# The top 2 parties in the Congress that began in 1823 were
# the "Adams-Clay Republican Party" and the "Crawford Republican Party".
  (mostDiverseCong <- subset(CongressParty, Year==mostDiverse))
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
  MaddisonData::ggplotPath('Year', 'meanNominate_dim1', 'Party', 
        Indep, logy=FALSE, legend.position='none')
  head(Indep)
  tail(Indep)
# "Independent" runs 1837 to 2025. Prior to 1950, most were closer to 
# Fed_Whig_Rep. Since 1950, most were closer to DemRep_Jackson_Dem. 
# Leave them with "other". 
# Independent Democrat can be clusered with DemRep_Jackson_Dem. 
# Independent Whig appears only between 1843 and 1851 and are in the middle. 
# Leave with "other". 
# That leaves "Independent Republican", which can be clustered with 
# Fed_Whig_Rep. 
  }
}
\keyword{IO}
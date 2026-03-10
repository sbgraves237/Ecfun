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
...)
}
\arguments{
  \item{file}{
    \code{file} argument passed to \code{\link[readr]{read_csv}}.
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
  a \code{\link[tibble]{tibble}} with columns 
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
    \code{numeric} First year of each 2-year computed 
    from \code{congress} as (2*congress+1787).
  }
  \item{Party}{
    \code{ordered} giving the names for each numeric \code{party_code} per 
    \href{https://voteview.com/articles/data_help_parties}{\code{data_help_parties} on \code{voteview.com}}
    ordered by number of members in the Congress. 
    
    NOTE: As of 2026-03-09, names "Union Labor Party" and "Constitutional 
    Unionist Party" had two different codes each: \code{party_code} = 355 and 
    366 both mapped to "Union Labor Party" and \code{party_code} = 37 and 4444
    both mapped to "Constitutional Unionist Party". The first included 14 
    officials in the US Congress in the 1851 and 1961 sessions combined. The 
    second had 4 officials in the US Congress between 1887 and 1919. (Both 
    are coded "other" in \code{Party2}.)
  }
  \item{Party2}{
    \code{link{ordered}} collapsing all to 'Dem', 'Rep', and 'other'. 

    'Dem' include 100 = modern Democratic party + 
    13 = Democratic-Republican Party + 555 = Jackson Party + 
    4000 = anti-administration
    
    'Rep' include 200 = modern Republican party + 29 = Whig + 1 = Federalists 
    + 1275 = Anti-Jacksonians + 22 = Adams + 5000 = pro-administration + 
    3333 = Opposition Party. 
    
    'other' = 42 other parties, which cumulatively have held just over 2 
    percent of the seats in all the congresses in US history. 
  }
}
\references{
\href{https://legacy.voteview.com}{\code{Voteview.com} website}. 

Timothy P. Nokken and Keith T. Poole (2004) 
"Congressional Party Defection in American History." 
Legislative Studies Quarterly, 29:545-568,. 

Keith T. Poole (2005) Spatial models of parliamentary voting 
(Cambridge U. Pr.). 
}
\author{Spencer Graves}
\seealso{
  \code{\link[readr]{read_csv}}
}
\examples{
# Wrap in try(...) so it won't throw an error 
# if the Voteview website is not available. 

Nominate <- try(readDW_NOMINATE())
}
\keyword{IO}
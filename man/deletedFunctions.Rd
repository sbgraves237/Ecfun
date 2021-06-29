\name{deletedFunctions}
\alias{deletedFunctions}
\alias{readFinancialCrisisFiles}
\alias{readCookPVI}
\alias{readCookPVI.}
\alias{readUShouse}
\alias{readUSsenate}
\alias{readUSstateAbbreviations}
\title{
  Functions deleted from the Ecfun package
}
\description{
  Several functions were deleted from Ecfun 
  0.2-5, because they no longer worked, and 
  it was not clear if there was demand for 
  them.  
  
  If you need them, you can get the 
  documentation and code for them from CRAN 
  > Packages > Archive (near the bottom 
  center) > Ecfun > Ecfun_0.2-0.tar.gz.  
  I don't expect the code to work.  
  However, I might be willing to 
  collaborate in restoring the 
  functionality to sos.  
  
  \code{readFinancialCrisisFiles}
  was a companion to a book.  This 
  function required the \code{gdata}
  package, which was scheduled to be 
  removed from CRAN.  
  
  The other functions did web scraping, 
  and the web sites from which they 
  scraped information changed, and 
  it did not seem worth the work 
  required to continue to 
  maintain them.  
}
\keyword{misc}

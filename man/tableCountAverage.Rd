\name{tableCountAverage}
\alias{tableCountAverage}
\title{
Table occurrences of levels of a factor with the average of a variable
}
\description{
  Table the occurrences of the levels of a factor with the average of a 
  variable, sorted by the occurrences. 
}
\usage{
tableCountAverage(x, y, data, useNA = c("no", "ifany", "always"), na.rm=TRUE, 
                  decreasing=TRUE, ...)
}
\arguments{
  \item{x}{
    Name of a column of \code{data} to treat as a categorical variable, 
    count occurrences of it, sort by occurrences, and compute the average of 
    \code{y} for each level of \code{x}. 
  }
  \item{y}{
    Name of a colum of \code{data} to average within each level of \code{x}. 
  }
  \item{data}{
    \code{\link{data.frame}} with columns \code{x} and \code{y}. 
  }
  \item{useNA}{
    as with \code{\link{table}}. 
  }
  \item{na.rm}{
    Argument to pass to \code{mean(data[, y])} for each level of \code{x}. 
  }
  \item{decreasing}{
    Should the \code{data.frame} returned be sorted with the count decreasing 
    (if \code{TRUE}) or increasing (if \code{FALSE}) or returned in the order 
    returned by \code{\link{table}} (if \code{NA}). 
  }
  \item{\dots}{
    Optional arguments to pass to \code{table}. 
  }
}
\details{
  1.  \code{xTab <- table(data[, x], useNA=useNA, ...)}

  2.  \code{if(!is.na(decreasing)) xTab <- sort(xTab, decreasing)}
  
  3. Call \code{mean(data[, y])} for each level of \code{x}
}
\value{
  \code{data.frame} with columns \code{x, n, p, mean}. 
}
\author{
  Spencer Graves
}
\seealso{
    \code{\link{table}}, \code{\link{sort}}, \code{\link{mean}}
}
%\references{}
\examples{
  Dat <- data.frame(cat=c('g', 'h', 'a', NA, 'a', 'g', 'g'), 
                    num=c( NA,  1,   2,   3,   4,   5,  6))
  catTabDecr <- tableCountAverage('cat', 'num', Dat, na.rm=FALSE)
  catTabIncr <- tableCountAverage('cat', 'num', Dat, useNA='ifany', 
                                  decreasing=FALSE)
# Make sure it also works with a tibble                                   
  catTab <- tableCountAverage('cat', 'num', tibble::as_tibble(Dat)[-4, ], 
                              useNA='always', decreasing=NA)

  cTd <- data.frame(cat = c('g', 'a', 'h'), 
                    n   = c( 3,   2,   1), 
                    p   = c( 3,   2,   1)/6, 
                    num = c( NA,  3,   1))
  cTi <- data.frame(cat = c('h', NA, 'a', 'g'), 
                    n   = c( 1,  1,   2,   3), 
                    p   = c( 1,  1,   2,   3)/7, 
                    num = c( 1,  3,   3, 5.5))
  cT <- data.frame(cat = c('a', 'g', 'h', NA), 
                   n   = c( 2,   3,   1,   0), 
                   p   = c( 2,   3,   1,   0)/6, 
                   num =c(  3, 5.5,   1,  NaN))

\dontshow{stopifnot(}
all.equal(catTabDecr, cTd)
\dontshow{)}

\dontshow{stopifnot(}
all.equal(catTabIncr, cTi)
\dontshow{)}

\dontshow{stopifnot(}
all.equal(catTab, cT)
\dontshow{)}
}
\keyword{array}

\name{simulate.bic.glm}
\alias{simulate.bic.glm}
\title{
  A "simulate" method for a BMA::bic.glm object
}
\description{
  Compute predictions for \code{newdata} for a
  model of class \code{\link[BMA]{bic.glm}}.  

NOTES:  
1.  THIS FUNCTION IS A PRELIMINARY VERSION OF A COMPANION TO 
THE BMA PACKAGE AND COULD MIGRATE TO BMA OR DISAPPEAR 
ENTIRELY IN THE FUTURE.  
2.  help(simulate, stats) says "Package \strong{stats} has a 
method for "\code{lm}" objects which is used for 
\code{\link{lm}} and \code{\link{glm}} objects.  ... 
\strong{Value}:  Typically a list of length 
\code{nsim} of simulated responses.  Where appropriate the 
result can be a data frame".  
\code{simulate.glm(glm(yb1~x, family=binomial), nsim=4)} 
returns a data.frame with nsim "columns" with names 
\code{paste0("sim_", 1:nsim)}.  If NCOL(yb1) > 1, each 
"column" of the data.frame is a numeric matrix with 
NCOL(yb1) columns.  Note that \code{simulate.lm} 
returned simulated data.  The present function does 
NOT return simulated data but rather simulated values 
on the 'link' or 'response' scales or both.  It may be 
desired to add an option to this present function for 
\code{type = "data"} for compatibility with 
\code{simulate.lm}.  
}
\usage{
\method{simulate}{bic.glm}(object, nsim = 1, 
    seed = NULL, newdata=NULL, 
    type = c("link", "response"), ...)
}
\arguments{
  \item{object}{
    an object representing a fitted model 
    of class \code{\link[BMA]{bic.glm}}.  
  }
  \item{nsim}{
    	number of response vectors to simulate. 
    	Defaults to 1.
  }
  \item{seed}{
    Argument passed as the first argument to 
    \code{\link{set.seed}} if not NULL.  
  }
  \item{newdata}{
    optionally, a \code{\link{data.frame}} 
    in which to look for variables with 
    which to predict. If omitted, predictors 
    used in fitting are used.  
  }
  \item{type}{
    the type of simulations required. 
    \itemize{
      \item{link}{
        The default \code{type='link'} is on the 
        scale of the linear predictors using 
        \code{\link[mvtnorm]{rmvnorm}} applied  
        to randomly selected components of the 
        mixture with \code{mean} = 
        \code{\link{coef}} and \code{sigma} = 
        \code{\link{vcov}} for that component.  
        For a default binomial model, these are 
        of log-odds (probabilities on logit 
        scale).
      }
      \item{response}{
        \code{object[['linkinv']]} of \code{
        type = 'link'}.  For a binomial model, 
        these are predicted probabilities.  
      }
    }
  }
  \item{...}{
    further arguments passed to or from other methods.
  }
}
\details{
  1.  Save current \code{seed} and optionally set it using
  code copied from \code{stats:::simulate.lm}.  
  
  2.  \code{postprob <- object[['postprob']]; 
  x <- object[['x']]; y <- object[['y']]; 
  mle <- object[['mle']]; 
  linkinv <- object[['linkinv']]}.
  
  3.  \code{cl <- as.list(object[['call']]);  wt <- cl[['wt']]; 
  fam <- cl[['glm.family']]}

  4.  \code{if(is.null(newdata))newdata <- x else ensure that 
  all levels of factors of newdata match x.}
  
  5.  \code{xMat <- model.matrix(~., x);  
  newMat <- model.matrix(~., newdata)}
  
  6.  \code{nComponents <- length(postprob);  
  nobs <- NROW(newdata)}
  
  7.  \code{sims <- matrix(NA, nobs, nsim)}
  
  8.  \code{rmdl <- sample(1:nComponents, nsims, TRUE, 
  postprob)}
  
  9.  \code{for(Comp in 1:nComponents)
  nsimComp <- sum(rmdl==Comp); 
  refitComp <- glm.fit(xMat[, mle[Comp,]!=0], y, wt,
  mle[Comp, mle[Comp,]!=0], family=fam); 
  simCoef <- mvtnorm::rmvnorm(nsimComp, coef(refitComp), 
  vcov(rfitComp)); 
  sims[rmdl==Comp, ] <- tcrossprod(newMat[, mle[Comp,]!=0], 
  simCoef)}
  
  10.  If \code{length(type)} == 1:  return a \code{\link{data.frame}} 
  with one column for each desired simulation, consistent with the 
  behavior of the generic \code{\link{simulate}} applied to objects 
  of class \code{lm} or \code{glm}.  Otherwise, return a list of 
  \code{\link{data.frame}}s of the desired types.  
}
\value{
  Returns either a \code{\link{data.frame}} or a list of 
  \code{\link{data.frame}}s depending on 'type':  
  
  \item{link}{
    a \code{\link{data.frame}} with \code{nsim} columns 
    of \code{nobs} values each giving the simulations on the 
    \code{link} scale.  
  }
  \item{response}{
    a \code{\link{data.frame}} with \code{nsim} columns 
    of \code{nobs} values each giving the simulations on the 
    \code{response} scale, being \code{linkinv} of the 
    simulations on the \code{link} scale.  
  }
  \item{for length(type)>1}{
    a list with simulations on the desired scales.  
  }
  
  The value also has an attribute "\code{seed}". 
  If argument \code{seed} is NULL, the attribute os the 
  value of \code{\link{.Random.seed}} before the 
  simulation started.  Otherwise it is the value of 
  the argument with a "kind" attribuate with value 
  \code{as.list(RNGkind())}.  
  
  NOTE:  This fuction currently may not work
  with a model fit that involves a multivariate 
  \code{link} or \code{response}.  
}
\author{
  Spencer Graves
}
\seealso{
  \code{\link{simulate}}
  \code{\link[BMA]{bic.glm}}
  \code{\link[BMA]{predict.bic.glm}}
  \code{\link{set.seed}}
  \code{\link[mvtnorm]{rmvnorm}}
}
%\references{}
\examples{
library(BMA)
library(mvtnorm)
##
## 1.  a factor and a numeric 
##
PoisReg2 <- data.frame(
  x=factor(rep(0:2, 2)), x1=rep(1:2, e=3))
bicGLM2 <- bic.glm(PoisReg2, y=1:6, poisson)

newDat2 <- data.frame(
  x=factor(rep(c(0, 2), 2), levels=0:2), 
  x1=3:6)
# NOTE:  Force newDat2['x'] to have the same levels
# as PoisReg2['x']

bicGLMsim2n <- simulate(bicGLM2, nsim=3, seed=2,
  newdata=newDat2)

##
## 2.  One variable:  BMA returns
##     a mixture of constant & linear models
##
PoisRegDat <- data.frame(x=1:2, y=c(5, 10))
bicGLMex <- bic.glm(PoisRegDat['x'], 
                         PoisRegDat[, 'y'], poisson)
(postprob <- bicGLMex[['postprob']])
bicGLMex['mle']

# Simulate for the model data 
bicGLMsim <- simulate(bicGLMex, nsim=2, seed=1)  

# Simulate for new data
newDat <- data.frame(x=3:4, 
      row.names=paste0('f', 3:4))
bicGLMsin <- simulate(bicGLMex, nsim=3, seed=2, 
                      newdata=newDat)
                      
# Refit with bic.glm.matrix and confirm 
# that simulate returns the same answers

bicGLMat <- bic.glm(as.matrix(PoisRegDat['x']), 
                         PoisRegDat[, 'y'], poisson)
bicGLMatsim <- simulate(bicGLMat, nsim=3, seed=2, 
                      newdata=newDat)
\dontshow{stopifnot(}                      
all.equal(bicGLMsin, bicGLMatsim)                      
\dontshow{)}

# The same problem using bic.glm.formula                  
bicGLMfmla <- bic.glm(y ~ x, PoisRegDat, poisson)
bicGLMfmlsim <- simulate(bicGLMfmla, nsim=3, seed=2, 
                      newdata=newDat)
\dontshow{stopifnot(}                      
all.equal(bicGLMsin, bicGLMfmlsim)                      
\dontshow{)}
                      
##
## 2a.  Compute the correct answers manually 
##
GLMex1 <- glm(y~x, poisson, PoisRegDat)
GLMex0 <- glm(y~1, poisson, PoisRegDat)

postProb <- bicGLMfmla$postprob
nComp <- length(postProb)
newMat <- model.matrix(~., newDat)
set.seed(2)
(rmdl <- sample(1:nComp, 3, TRUE, 
          postprob))
GLMsim. <- matrix(NA, 2, 3)
dimnames(GLMsim.) <- list(
  rownames(newMat), 
  paste0('sim_', 1:3) )
          
sim1 <- mvtnorm::rmvnorm(2, coef(GLMex1), 
                         vcov(GLMex1))
sim0 <- mvtnorm::rmvnorm(1, coef(GLMex0), 
                         vcov(GLMex0))
GLMsim.[, rmdl==1] <- tcrossprod(newMat, sim1)
GLMsim.[, rmdl==2] <- tcrossprod(
          newMat[, 1, drop=FALSE], sim0)
                      
\dontshow{stopifnot(}
all.equal(bicGLMsin[[1]], data.frame(GLMsim.), 
    tolerance=4*sqrt(.Machine$double.eps))
# tcrossprod numeric precision is mediocre 
# for the constant model in this example.  
\dontshow{)}
}
\keyword{datagen}

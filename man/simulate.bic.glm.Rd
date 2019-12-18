\name{simulate.bic.glm}
\alias{simulate.bic.glm}
\title{
  A "simulate" method for a BMA::bic.glm object
}
\description{
  Compute predictions for \code{newdata} for a
  model of class \code{\link[BMA]{bic.glm}}.  

NOTES:  THIS FUNCTION IS A PRELIMINARY VERSION OF A COMPANION TO THE BMA PACKAGE AND COULD MIGRATE TO BMA OR DISAPPEAR ENTIRELY IN THE FUTURE.  
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
    the type of prediction required. The default 
    is on the scale of the linear predictors; the
    alternative "response" is on the scale of the 
    response variable. Thus for a default binomial 
    model the default predictions are of log-odds
    (probabilities on logit scale) and type = 
    "response" gives the predicted probabilities. 
  }
  \item{...}{
    further arguments passed to or from other methods.
  }
}
\details{
  1.  \code{if(!is.null(seed))set.seed(seed)}.
  
  2.  \code{postprob <- object[['postprob']]; x <- object[['x']]; y <- object[['y']]; mle <- object[['mle']]; linkinv <- object[['linkinv']]}.
  
  3.  \code{cl <- as.list(object[['call']]);  wt <- cl[['wt']]; fam <- cl[['glm.family']]}

  4.  \code{if(is.null(newdata))newdata <- x else ensure that all levels of factors of newdata match x.}
  
  5.  \code{xMat <- model.matrix(~., x);  newMat <- model.matrix(~., newdata)}
  
  6.  \code{nComponents <- length(postprob);  nobs <- NROW(newdata)}
  
  7.  \code{sims <- matrix(NA, nobs, nsim)}
  
  8.  \code{rmdl <- sample(1:nComponents, nsims, TRUE, 
  postprob)}
  
  9.  \code{for(Comp in 1:nComponents)
  nsimComp <- sum(rmdl==Comp); 
  refitComp <- glm.fit(xMat[, mle[Comp,]!=0], y, wt,
  mle[Comp, mle[Comp,]!=0], family=fam); 
  simCoef <- mvtnorm::rmvnorm(nsimComp, coef(refitComp), vcov(rfitComp)); sims[rmdl==Comp, ] <- tcrossprod(simCoef, newMat[, mle[Comp,]!=0])}
  
  10.  \code{if(type=='link')return(sims) else if(type=='response')return(linkinv(sims) else list(link=sims, 
  response = linkinv(sims))}
}
\value{
  Returns either a matrix or a list of matrices depending on 'type':  
  
  \item{link}{
    a numeric matrix \code{nsims} by \code{nobs}
    giving the simulations on the 'link' scale.  
  }
  \item{response}{
    a numeric matrix \code{nsims} by \code{nobs} 
    giving the simulations on the 'response' scale, 
    being \code{linkinv} of the simulations on the 
    'link' scale.  
  }
  \item{c('link', 'response')}{
    a \code{list} with simulations on both 
    the 'link' and 'response' scales, respectively.  
  }
}
\author{
  Spencer Graves
}
\seealso{
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
                      
# compute the correct answers manually 
GLMex1 <- glm(y~x, poisson, PoisRegDat)
GLMex0 <- glm(y~1, poisson, PoisRegDat)

postProb <- bicGLMfmla$postprob
nComp <- length(postProb)
newMat <- model.matrix(~., newDat)
set.seed(2)
(rmdl <- sample(1:nComp, 3, TRUE, 
               postprob))
GLMsim. <- matrix(NA, 3, 2)
colnames(GLMsim.) <- rownames(newMat)

sim1 <- mvtnorm::rmvnorm(2, coef(GLMex1), 
                         vcov(GLMex1))
sim0 <- mvtnorm::rmvnorm(1, coef(GLMex0), 
                         vcov(GLMex0))
GLMsim.[rmdl==1, ] <- tcrossprod(sim1, newMat)
GLMsim.[rmdl==2, ] <- tcrossprod(sim0, 
                      newMat[, 1, drop=FALSE])

\dontshow{stopifnot(}
all.equal(bicGLMsin[[1]], GLMsim.)
\dontshow{)}
}
\keyword{datagen}

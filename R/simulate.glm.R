simulate.glm <- function(object, nsim = 1, 
        seed = NULL, newdata=NULL, 
        type = c("link", "response"), ...){
##  
## 1.  seed?
##  
# copy code from stats:::simulate.lm  
  if (!exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE)) 
    runif(1)
  if (is.null(seed)){ 
    RNGstate <- get(".Random.seed", envir = .GlobalEnv)
  } else {
    R.seed <- get(".Random.seed", envir = .GlobalEnv)
    set.seed(seed)
    RNGstate <- structure(seed, kind = as.list(RNGkind()))
    on.exit(assign(".Random.seed", R.seed, envir = .GlobalEnv))
  }
##
## 2.  newdata?  
##  
  cl <- as.list(object[['call']])
  if(is.null(newdata)){
    if('x' %in% names(object)){
      newMat <- object$x 
    } else {
      if(is.null(cl$data)){
        newMat <- model.matrix(cl$formula, 
                data = environment(object), ...)
      } else {
        fmla <- eval(cl$formula)
        dat <- eval(cl$data)
        newMat <- model.matrix(fmla, data = dat, ...) 
      }
    }
  } else newMat <- model.matrix(~., newdata)
##
## 3.  simCoef
##
  nobs <- NROW(newdata)
  vc <- vcov(object)
  simCoef <- mvtnorm::rmvnorm(nsim, 
          coef(object), vc)
  sims <- tcrossprod(newMat, simCoef)
  colnames(sims) <- paste0('sim_', 1:nsim)
## 
## 9.  return type(s) desired 
##
# if('response' %in% type){
  if(any(!is.na(pmatch(type, 'response')))){
    fam <- cl$family
    if(is.character(fam)){
      fam <- get(fam, mode = "function", 
                 envir = parent.frame())
    }
    if(class(fam) %in% c('call', 'name')) fam <- eval(fam)
    if(is.function(fam)) 
      fam <- fam()
    if(is.null(fam$family)) {
      print(fam)
      stop("'family' not recognized")
    }
    linkinv <- fam$linkinv
    if(!is.function(linkinv)){
      print(fam)
      stop("linkinv from 'family' is not a function.")
    }
  }
  if(length(type)>1){
    if(all(is.na(pmatch(type, 'response')))){
      print(type)
      stop("length(type)>1 but 'response' is not in type")
    }
    out <- list(link=data.frame(sims), 
        response = data.frame(linkinv(sims)))
  } else {
    tp <- match.arg(type)
    if(tp=="link"){
      out <- data.frame(sims)
    } else {
      if(all(is.na(pmatch(type, 'response')))){
        print(type)
        stop("length(type)>1 but 'response' is not in type")
      }
      out <- data.frame(linkinv(sims))
    }
  }
  attr(out, 'seed') <- RNGstate
#  cat('print(type)\n')
#  print(type)
  out
}
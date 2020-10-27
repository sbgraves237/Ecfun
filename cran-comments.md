## Test environments
* local macOS 10.15.6, R 4.0.3:  OK. 
* ubuntu 16.04.6 LTS (on travis-ci), R 4.0.2 (2020-10-26):
Packages unavailable to check Rd xrefs: EnvStats, drc, zoo, prodlim, TRAMPR


* win-builder (devel and release)
2020-10-26
* R-hub builder: 
Windows Server 2008 R2 SP1, R-devel, 32/64 bit
Packages required but not available:
  'fda', 'RCurl', 'XML', 'tis', 'jpeg', 'TeachingDemos', 'stringi',
  'xml2', 'BMA'

Packages suggested but not available:
  'rmarkdown', 'invgamma', 'ipumsr', 'lubridate', 'bayesplot', 'bssm',
  'ggplot2', 'tibble', 'kableExtra', 'openxlsx', 'fitdistrplus',
  'car', 'DescTools', 'Ecdat', 'maps', 'gridBase', 'pryr', 'knitr',
  'purrr', 'markdown'

VignetteBuilder package required for checking but not installed: 'knitr'

** Earlier R-hub issues that I believe should be ignored:
  Found the following (possibly) invalid URLs:
    https://www.bls.gov/cps/
    https://www.r-bloggers.com/2012/01/scr    
  Both work for me when I try them.  
  
  - Ubuntu Linux 16.04 LTS, R-release, GCC
    URL: https://cookpolitical.com/
    URL: https://www.measuringworth.com/
      	SSL certificate problem ... 
      	(Status without verification: OK)
    >> These are in Rd and Rmd files that 
    discuss reading and processing data 
    from these web sites.  
    
* Fedora Linux, R-devel, clang, gfortran also complained about measuringworth, which I've used many times without problems.   

   

# Ecfun 0.2-4 on Win10 on 2020-09-23:
# Note:  unable to verify current time
# https://stackoverflow.com/questions/63613301/r-cmd-check-note-unable-to-verify-current-time#comment112489969_63613301
# says: "this requires a fix in the check function by the R development team ... or the web-resource coming online again."




# prior to 2020-03:

# NOTEs on check_rhub: 

#> Packages unavailable to check Rd xrefs: 
# 'EnvStats', 'drc', 'zoo', 'prodlim', 'TRAMPR'
# I hope I can safely ignore this NOTE, 
# because it's a deficiency on rhub, not with Ecfun.  


#  NO ERRORS OR WARNINGS.  
#  
#   Found the following (possibly) invalid URLs:
#   https://www.measuringworth.com/
#   ** THIS IS A VALID URL 
#   ** but is occasionally slow in responding. 
#   ** It's a very important source 
#   ** macroeconomic data.
#   ** It's cited but not read in the package, 
#   ** and I'd prefer not to have to mangle the URL

## Downstream dependencies
# OK on revdepcheck::revdep_check 
# on both macOS and Win10 2020-02-01
# (Ecfun 0.2-2;  
# No changes to code, only documentation 
# between that 0.2-2 and 0.2-3, 
# so I didn't rerun revdep_check.  


## CRAN checks problems 


## Test environments
* local macOS 10.15.2, R 3.6.2
* local Windows 10, R 3.6.2 
* ubuntu 12.04 (on travis-ci), R 3.6.2
* win-builder (devel and release)

## R CMD check results

# OK on macOS 2020-02-01
# OK on Travis-CI 2020-01-23; 
#    Travis hasn't worked for me since.  
# OK on win-bilder devel 2020-02-01
# NOTEs on check_rhub: 

#> Packages unavailable to check Rd xrefs: 
# 'EnvStats', 'drc', 'zoo', 'prodlim', 'TRAMPR'
# I hope I can safely ignore this NOTE.   

#   Found the following (possibly) invalid URLs:
#   https://www.measuringworth.com/
#   ** THIS IS A VALID URL 
#   ** but is occasionally slow in responding. 
#   ** It's a very important source 
#   ** macroeconomic data.
#   ** It's cited but not read in the package, 
#   ** and I'd prefer not to have to mangle the URL
#
#  It also found that 
#  http://www.reinhartandrogoff.com/
#  was invalid.  This has disappeared from the web. 
#  Those links have been redirected to the 
#  Internet Archive.  

## Downstream dependencies
# OK on revdepcheck::revdep_check 
# on both macOS and Win10 2020-02-01

## CRAN checks problems 
## noted in email from Prof. Ripley 2020-01-20
# *1. read.testURLs that generated 
#     errors from internet access 
#  was removed with test.URLs, 
#  because they were marked as provisional
#  and could be removed at any time, 
#  it wasn't clear that anyone was using them,
#  and more modern tools are available from:
#  http://www.measurementlab.net/

# *2.  readDates3to1.Rd:  
#  The file that was written 
#  to a user's computer 
#  is now written to a temp file 
#  and removed in \dontshow{}
#  at the end of examples.  
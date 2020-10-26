## Test environments
* local macOS 10.15.6, R 4.0.3
* ubuntu 16.04.6 LTS (on travis-ci), R 4.0.2
* win-builder (devel and release)

* R-hub builder: 
 - Windows Server 2008 R2 SP1, R-devel, 32/64 bit
   >> Error: No package 'utf8' [but it's on CRAN]
   >> Warning in min(nuclearWeaponStates$startNucPgm):
      "no non-missing arguments": 
      I cannot replicate:  
      nuclearWeaponStates is a dataset in Ecdat
      with a column startNucPgm with no NAs 
      and min is 1942-01-19 when I try it.  
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
   
## R CMD check results

# Ecfun 0.2-4 on macOS 2020-09-23:
# A doc directory of 4.8Mb is created
# on mac but not Ubuntu or Win10.  
# I don't recall having seen this previously.
# Might it be a result of some change in 
# Rtools on Mac that is different 
# from other platforms?  

# Ecrun 0.2-4 on Win10 on 2020-09-23:
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


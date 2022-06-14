# 2022-06-13:
# Winbuilder-oldrel:  identified two "(possibly) invalid URLs":  
# https://www.measuringworth.com/ 
# and 
# https://www.stat.cmu.edu/~cshalizi/rmarkdown/#math-in-r-markdown
#** Both work for me.  
#
# Also, Winbuilder-devel 


## Test environments
* local macOS 11.4, R 4.1.0:  OK. 
* GitHub Actions: Win, macOS, ubuntu-20.04 (release & devel): OK
* R-hub builder <support@rhub.io>: 
** Debian Linux, R-devel, GCC
--> Error and Note reported, but I don't see anything I can fix:  Bioconductor not available and Packages unavailable to check Rd xrefs.  
** Windows Server 2008 R2 SP1, R-devel, 32/64 bit
--> Same Bioconductor error as for Debian.  

* Winbuilder:  
** using R Under development (unstable) (2021-06-27 r80567) on x86_64-w64-mingw32:  
Found the following (possibly) invalid URLs:
  URL: https://www.measuringworth.com/
    From: inst/doc/UpdatingUSGDPpresidents.html
    Status: Error
    Message: SSL certificate problem: unable to get local issuer certificate
** NOTE:  I just checked:  It looks the same as the last time I visited it.  It's an important source for GDP data.  

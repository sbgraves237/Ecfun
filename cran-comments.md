## Test environments
* local macOS 10.15.6, R 4.0.3:  OK. 
* winbuilder:  x86_64-w64-mingw32 (64-bit):  OK.  
* Travis CI:  Ubuntu 16.04.6 LTS:  OK.  
* R-hub:   	Windows Server 2008 R2 SP1, R-devel, 32/64 bit: (possibly) invalid URLs:https://www.bls.gov/cps/
# NOTE:  This works when I test it manually. 
# It's the Bureau of Labor Statustics of the US government;-)  

* One CRAN TEST on Ecfun 0.2-2 
https://www.r-project.org/nosvn/R.check/r-devel-linux-x86_64-fedora-clang/Ecfun-00check.html
# complains: 
 Undeclared packages ‘EnvStats’, ‘drc’, ‘zoo’, ‘openxlsx’, ‘prodlim’, ‘plyr’, ‘TRAMPR’, ‘raster’ in Rd xrefs
# I'm not getting this on any other platform. 
# These are links from my Rd file to 
# help pages in other packages 
# Ecfun 0.2-4 suggests: "openxlsx"
# None of the others are mentioned in my DESCRIPTION

# Ecfun 0.2-8 (2022-07-20)
* No errors, warnings or Notes on 5 platforms on GitHub Action (Windows, macOS, and Ubuntu with R 4.2.1 plus Ubuntu with R-devel and R-old) and Winbuilder (mingw but not linux)
* Winbuilder (linux) and Rhub (Fedora and Ubuntu): 
Found the following (possibly) invalid URLs:
  URL: https://www.measuringworth.com/
    From: inst/doc/UpdatingUSGDPpresidents.html
    Status: Error
    Message: SSL certificate problem: unable to get local issuer certificate
  URL: https://www.stat.cmu.edu/~cshalizi/rmarkdown/#math-in-r-markdown
    From: inst/doc/nuclearArmageddon.html
    Status: Error
    Message: SSL certificate problem: unable to get local issuer certificate

NOTE:  Some systems have complained about these URLs for years.  They worked fine for me just now, as they have in the past each time I've checked them.  

* Revdepcheck "*Wow, no problems at all. :)*"
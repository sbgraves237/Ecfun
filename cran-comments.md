# Ecfun 0.3-6 (2024-11-12)
* "brew install tidy-html5" eliminated 501 HTML validation problems. 

# Ecfun 0.3-5 (2024-11-11) 
* "Status: 403 ... Forbidden" reported for two URLs that work for me: 
 https://bioguide.congress.gov/ and https://www.bls.gov/cps/
 These are a Biographical Directory of the US Congress and 
 Current Population Survey (CPS). 
* devtools::check_win_devel and *release complained 
  "CRAN-pack does not know about .renviron". 
  ".renviron" was in my .Rbuildignore. 
  It similarly complained, 
  "Non-standard file/directory found at top level:
  'Ecfun_release_to_CRAN_process.R'". 
  Why do check_win* even check those things? 
* check_win* also complained of  
  "Lost braces in \itemize; meant \describe ?" in
  simulate.bic.glm.Rd and simulate.glm.Rd. 
  They seem to work as designed in GitHub Action 
  on 5 platforms. If I need to do something different, 
  I could use help understanding what. 

# Ecfun 0.3-2 (2022-10-06)
* No ERRORs nor WARNINGs nor NOTEs apart from platform malfunctions:  

# R-hub says: 
checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'

I'm ignoring this per:  
https://stackoverflow.com/questions/62456137/r-cran-check-detritus-in-temp-directory  
  
# GitHub Action for R-release on Windows, which could not find a secondary dependency (curl) found by all other platforms.  
  
# win_oldrelease complained of "(possibly) invalid URLs" that work otherwise.    
  
# Ecfun 0.3-1 (2022-10-04)
## R CMD check results
* There were no ERRORs or WARNINGs. 
* R-oldrelease :Found ... (possibly) invalid URLs" that worked when checked manually and were not detected by checks on other platforms
* GitHub Action checked the current version on macOS, Windows and Ubuntu 20.04 plus R-devel and oldrel-1 on Ubuntu.  I also checked devtools::check_win_devel, check_win_release, and check_win_oldrelease.  

# Ecfun 0.3-0 (2022-07-21)
* I apologize for not having put `cran-comments.html` in `.Rbuildignore` until now.  
* Winbuilder (R-devel on x86_64-pc-linux-gnu) will report valid URLs as invalid, as documented for 0.2-8 and previously.   

# Ecfun 0.2-9 (2022-07-21)
* Winbuilder (R-devel on x86_64-pc-linux-gnu) reported valid URLs as invalid, as documented for 0.2-8.  
* I apologize for not having put `cran-comments.html` in `.gitignore` until now.  
* The easiest thing for me now is `devtools::release()`.  I hope that's equivalent to resubmitting "a fixed version via the webform."

# Ecfun 0.2-8 (2022-07-20)
* No errors, warnings or Notes on 5 platforms on GitHub Action (Windows, macOS, and Ubuntu with R 4.2.1 plus Ubuntu with R-devel and R-old) and Winbuilder (mingw but not linux)
* Rhub (Windows Server 2022, R-devel, 64 bit) reported:  
checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
  - [This seems to be a known bug in Rhub](https://github.com/r-hub/rhub/issues/503)
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
  - NOTE:  Some systems have complained about these URLs for years. They worked fine for me just now, as they have in the past each time I've checked them.  
* Revdepcheck "*Wow, no problems at all. :)*"

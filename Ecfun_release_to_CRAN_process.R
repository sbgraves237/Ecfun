# File > "Open Project..." > [parent of Package file]

# https://r-pkgs.org/release.html

#20.1.  Pick a version number:  
#       in DESCRIPTION: must be later than any version on CRAN
#20.3.  The submission process
#       Store submission comments in cran-comments.md
#20.3.1.  Test environments

# File > "Open project" in the package directory (i.e., containing DESCRIPTION, etc.)

# devtools::check_win_*()
dir()

devtools::check_win_devel()
devtools::check_win_release()
devtools::check_win_oldrelease()

devtools::check_rhub()

rhub::rhub_setup()

rhub::rhub_doctor()
rhub::rhub_check()
# 2024-11-10: This produced a list of 26 different platforms
# with no obvious indication of a recommended default other 
# than 0 or 1:26. I chose the former. 

#20.3.3.  Reverse dependencies

# install.packages("revdepcheck")
#devtools::install_github('r-lib/revdepcheck')

revdepcheck::revdep_reset()

revdepcheck::revdep_check(num_workers = 4)

#20.4.  Update README.md and NEWS.md 

#20.5.  Submit to CRAN

library(devtools)
spell_check()

release()

#20.6.  Update the version number for the future 
#20.7.  Publicise

#20.1.  Pick a version number:  in DESCRIPTION > what's on CRAN

#20.2.  Run & document R CMD check 
# 2.1-0 because this is to match the move of 
# the database maintenance to wu.ut.at

#20.3.  Check CRAN policies
#20.4.  Update README.md and NEWS.md 
#20.5.  Submit to CRAN
#20.6.  Update the version number for the future 
#20.7.  Publicise


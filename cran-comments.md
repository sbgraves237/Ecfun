# 2022-07-19
# Winbuilder R-devel - x86_64-w64-mingw32 (64-bit) reported:  
NOTE:  Problems with news in 'NEWS.md': No news entries found.
# Otherwise, checks on multiple platforms as a month ago, including revdepcheck, without problems 

# 2022-06-13:Ecfun:

## R CMD check results: No errors nor warnings 
# and no problems with revdepchecks.  

# 5 platforms on GitHub Actions: 
# Win and macOS (release) plus 
# ubuntu-20.04 (devel, release & oldrel): OK
#
# rhub checks "Finished: SUCCESS"
#
# Winbuilder-oldrel and -devel identified "(possibly) invalid URLs"
# or with "Service Unavailable" 
# that worked on other platforms and for me locally.   
# 
# and 'Warning: <table> attribute "width" not allowed for HTML5'.
# Ben Bolker replied to a question to R-pkg-devel about this, saying, 
# Hopefully this will be fixed in R 4.2.1 (scheduled for June 23)".

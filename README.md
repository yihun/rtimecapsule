# rtimecapsule <img src="man/figures/logo.png" align="right" height="100"/>

[![CRAN status](https://www.r-pkg.org/badges/version/rtimecapsule)](https://CRAN.R-project.org/package=rtimecapsule)
[![R-CMD-check](https://github.com/yihun/rtimecapsule/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/yihun/rtimecapsule/actions/workflows/R-CMD-check.yaml)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)



**rtimecapsule** is an R package that automatically backs up your R, Rmd, and Qmd files in a project as you work, so you can recover from accidental loss or crashes.

---

## Installation

```r
# Install from GitHub
install.packages("devtools") # if you don't have it
devtools::install_github("https://github.com/yihunzeleke/rtimecapsule")
```
## Usage
```r
library(rtimecapsule)

# Start automatic backups every 5 seconds
start_autobackup(interval = 5)

# Stop backups
stop_autobackup()

# Enable project auto-start
use_autobackup()

# Check backup status
capsule_status()
```

## Backup Files 

All backups are stored inside the `.rtimecapsule/` folder in the root of your project.

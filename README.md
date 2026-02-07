# rtimecapsule <img src="man/figures/logo.png" align="right" height="100"/>

[![CRAN status](https://www.r-pkg.org/badges/version/rtimecapsule)](https://CRAN.R-project.org/package=rtimecapsule)
[![R-CMD-check](https://github.com/yihun/rtimecapsule/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/yihun/rtimecapsule/actions/workflows/R-CMD-check.yaml)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)

## Overview

The `rtimecapsule` package provides automated, real-time backup and restoration capabilities for R project files. It continuously monitors your files for changes and maintains backup copies in a hidden `.rtimecapsule` directory, allowing you to recover from crashes, accidental deletions, or unwanted modifications.

## Features

- **Automatic Background Backups**: Background execution is implemented using scheduled callbacks and does not create separate system processes.
- **Selective File Tracking**: Choose which files or file types to backup
- **Quick Restoration**: Restore individual files or your entire project instantly
- **Status Monitoring**: Check backup status and tracked files at any time
- **Auto-Start Support**: Configure automatic backup on project load
- **Lightweight**: Minimal performance impact with configurable scan intervals

## Installation

```r
# install.packages("remotes")
remotes::install_github("yihun/rtimecapsule")
```

## Quick Start

```r
library(rtimecapsule)

# Start automatic backups for all R files
start_autobackup(interval = 2, files = ".R")

# Check status
capsule_status()

# Restore a specific file
restore_file("R/analysis.R")

# Restore files from the most recent backup
restore_last_crash()

# Stop backups
stop_autobackup()
```

## Core Functions

### Backup Management

#### `start_autobackup(interval = 2, files = NULL)`

Start automatic file backups in the background. This function monitors your project files and creates backups whenever changes are detected.

**Arguments:**
- `interval`: Number of seconds between file checks (default: 2)
- `files`: Which files to track:
  - `NULL` (default): Track all files in the project
  - `".R"`: Track only R scripts
  - `c("script1.R", "report.Rmd", "dashboard.qmd")`: Track specific files

**Details:**

The function runs a non-blocking background task using the `later` package. It:
1. Scans tracked files at the specified interval
2. Computes file hashes to detect changes
3. Creates backups in `.rtimecapsule/` when files change
4. Continues running until `stop_autobackup()` is called

**Examples:**
```r
# Monitor all files, check every 2 seconds
start_autobackup()

```

---

#### `stop_autobackup()`

Stop the automatic backup process.

**Examples:**
```r
# Stop backups when you're done working
stop_autobackup()
```

---

#### `use_autobackup()`

Enable automatic startup of backups when you open the project. This adds a startup hook to your project's `.Rprofile` file.

This ensures backups start automatically whenever you open the project in an interactive R session.

**Examples:**
```r
# Set up auto-start (run once per project)
use_autobackup()

# Now backups will start automatically when you open the project
```

---

#### `capsule_status()`

Display the current status of rtimecapsule, including whether backups are running, how many files are tracked, and how many backups exist.

**Returns:**

A list with three elements:
- `running`: Logical indicating if auto-backup is active
- `tracked_files`: Number of files currently being tracked
- `backup_files`: Number of backup files in `.rtimecapsule/`

**Examples:**
```r
# Check status
status <- capsule_status()
print(status)
#> $running
#> [1] TRUE
#> 
#> $tracked_files
#> [1] 15
#> 
#> $backup_files
#> [1] 12

```

---

### File Restoration

#### `restore_file(file)`

Restore a single file from backup to its original location.

**Arguments:**
- `file`: File path relative to project root

**Details:**

This function:
1. Locates the project root directory
2. Searches for the backup file in `.rtimecapsule/`
3. Creates any necessary parent directories
4. Copies the backup file to the target location, overwriting if it exists

**Returns:**

Returns `TRUE` invisibly on success.

**Errors:**

Throws an error if no backup exists for the specified file.

**Examples:**
```r
# Restore a single R script
restore_file("R/analysis.R")

# Restore a file in a subdirectory
restore_file("scripts/preprocessing/clean_data.R")

```

---

#### `restore_last_crash()`

Restore all files from the last backup. Useful for recovering from system crashes or reverting major changes.

**Details:**

This function performs a complete restoration:
1. Locates the project root directory
2. Checks for the existence of `.rtimecapsule/` backup directory
3. Recursively lists all backup files
4. Restores each file to its original location, maintaining directory structure
5. Overwrites existing files with backup versions

**Returns:**

Returns `TRUE` invisibly on success.

**Errors:**

Throws an error if no `.rtimecapsule` backup directory exists.

**Examples:**
```r
# Restore all backed up files after a crash
restore_last_crash()

```

---

## Backup Structure

rtimecapsule maintains a hidden `.rtimecapsule` directory that mirrors your project structure:

```
your-project/
├── .rtimecapsule/          # Hidden backup directory
│   ├── R/
│   │   ├── analysis.R      # Backed up version
│   │   └── utils.R
│   ├── data/
│   │   └── dataset.csv
│   └── scripts/
│       └── preprocess.R
├── R/                      # Your working files
│   ├── analysis.R          # Current version
│   └── utils.R
├── .Rprofile               # Optional: auto-start configuration
└── ...
```

## Common Workflows

### Initial Setup

```r
library(rtimecapsule)

# Enable auto-start (one-time setup)
use_autobackup()

# Start backups for this session
start_autobackup(interval = 2)
```

### Daily Development

```r
# Backups run automatically in the background
# Check status occasionally
capsule_status()

# If you need to restore a file you accidentally changed
restore_file("R/analysis.R")

# Stop backups when done for the day (optional)
stop_autobackup()
```

### Recovering from a Crash

```r
# After R crashes and you restart
library(rtimecapsule)
restore_last_crash()
# Your work is recovered!
```


### Before Major Refactoring

```r
# Ensure backups are running
start_autobackup(interval = 1)  # More frequent checks

# Do your refactoring...

# If something goes wrong
restore_last_crash()
```

### Selective Restoration

```r
# List all backed up files
backup_files <- list.files(".rtimecapsule", recursive = TRUE)
print(backup_files)

# Restore only specific files
restore_file("R/core_functions.R")
restore_file("R/analysis.R")

# Or restore everything
restore_last_crash()
```

## Best Practices

1. **Start backups early**: Run `start_autobackup()` at the beginning of your session
2. **Use auto-start**: Set up `use_autobackup()` so you never forget
3. **Choose appropriate intervals**: Balance between protection and performance
   - Active development: 1-2 seconds
   - Normal work: 2-5 seconds
   - Light monitoring: 5-10 seconds
4. **Be selective with files**: Only track files you're actively editing
5. **Check status regularly**: Use `capsule_status()` to ensure backups are running
6. **Combine with version control**: Use rtimecapsule for real-time protection, Git for milestones
7. **Test restoration**: Try `restore_file()` on a non-critical file to understand the workflow

## Performance Considerations

- **Recommendations**:
  - Track only source code files (`.R`, `.Rmd`, `.qmd`) for best performance
  - Use 2-3 second intervals for typical projects
  - Exclude large data files or binary outputs

## Troubleshooting

### Backups Not Starting

**Problem**: `start_autobackup()` doesn't seem to work

**Solutions**:
```r
# Check if 'later' package is installed
if (!requireNamespace("later", quietly = TRUE)) {
  install.packages("later")
}

# Verify backups are running
capsule_status()$running

# Check for error messages
start_autobackup()
```
### Recommended setup (safe and explicit)
If you want to preserve global startup settings and enable `rtimecapsule` per project, add the following to your project-level `.Rprofile`:

```r
# Source global R profile if it exists
if (file.exists("~/.Rprofile")) {
  source("~/.Rprofile")
}

# Start rtimecapsule automatically (interactive sessions only)
if (interactive()) {
  rtimecapsule::start_autobackup()
}

```
### No Backups Found

**Problem**: `restore_last_crash()` reports "No backups found"

**Solutions**:
```r
# Check if backup directory exists
dir.exists(".rtimecapsule")

# Verify backups are being created
start_autobackup()
# Make a change to a file
# Wait a few seconds
capsule_status()$backup_files  # Should be > 0
```

### File Not Restoring

**Problem**: `restore_file()` fails

**Solutions**:
```r
# Verify the backup exists
list.files(".rtimecapsule", recursive = TRUE)

# Check file path is relative to project root
# Correct: "R/analysis.R"
# Wrong: "/absolute/path/analysis.R"

# Ensure you're in the project directory
getwd()
```

## Dependencies

- **later**: Required for background task scheduling
- **Project root detection**: Uses `project_root()` helper function
- **File tracking**: Uses `tracked_files()` helper function
- **Hashing**: Uses `file_hash()` for change detection

## Function Reference Summary

| Function               | Purpose                           |
| ---------------------- | --------------------------------- |
| `start_autobackup()`   | Start automatic file backups      |
| `stop_autobackup()`    | Stop automatic backups            |
| `use_autobackup()`     | Enable auto-start on project load |
| `capsule_status()`     | Check backup status               |
| `restore_file()`       | Restore a specific file           |
| `restore_last_crash()` | Restore all backed up files       |


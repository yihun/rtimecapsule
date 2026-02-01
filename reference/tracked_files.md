# List tracked files in the project

Determines which files should be tracked based on user input.

## Usage

``` r
tracked_files(root = project_root(), files = NULL)
```

## Arguments

- root:

  Project root path

- files:

  NULL (default), a single extension like ".R", or a character vector of
  specific file names

## Value

Character vector of relative file paths

## Examples

``` r
if (FALSE) { # \dontrun{
# Only works inside an RStudio project
tracked_files()
} # }
```

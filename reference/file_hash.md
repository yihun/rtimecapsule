# Compute file hash

Compute file hash

## Usage

``` r
file_hash(file, root = project_root())
```

## Arguments

- file:

  File path relative to project root

- root:

  Project root path. Defaults to current RStudio project.

## Value

Character string of the file's MD5 hash, or NA if the file does not
exist

## Examples

``` r
if (FALSE) { # \dontrun{
file_hash("script.R")
} # }
```

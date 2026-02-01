# Detect the current project root

Walks up the directory tree until an `.Rproj` file is found. Prevents
execution inside an R package source directory.

## Usage

``` r
project_root()
```

## Value

Absolute path to project root

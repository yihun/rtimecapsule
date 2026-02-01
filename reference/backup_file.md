# Backup a file to .rtimecapsule folder

Backup a file to .rtimecapsule folder

## Usage

``` r
backup_file(file, root = project_root())
```

## Arguments

- file:

  File path to back up

- root:

  Project root path (default: detected automatically)

## Value

NULL (invisibly)

## Examples

``` r
# Create a temporary file to demonstrate backup
tmp <- tempfile(fileext = ".R")
writeLines("print('hello world')", tmp)

# Backup the temporary file
if (FALSE) { # \dontrun{
backup_file(tmp, root = tempdir())
} # }

# Clean up
unlink(tmp)
```

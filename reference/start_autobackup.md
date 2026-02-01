# Start rtimecapsule auto-backup (non-blocking)

Runs a background task that mirrors selected files into the
.rtimecapsule folder whenever they change.

## Usage

``` r
start_autobackup(interval = 2, files = NULL)
```

## Arguments

- interval:

  Seconds between checks

- files:

  NULL (default), a file extension (e.g. ".R"), or a character vector of
  file names

## Value

Invisibly TRUE

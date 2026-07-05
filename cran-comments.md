# daoh 0.2.1

## Submission summary

Update from 0.1.0. Two main changes:

* `calc_daoh()` rewritten on a vectorised data.table backend (roughly 25-70x
  faster on large administrative datasets); `data.table (>= 1.14.0)` added to
  Imports.
* Bug fix: timezone handling for `POSIXct` inputs. Dates were previously
  converted via UTC, which shifted local times onto the wrong calendar day and
  misaligned exact-method interval clipping on machines in non-UTC timezones.
  Results from `Date` inputs are unchanged.

See NEWS.md for details.

## Test environments

* Local: macOS (aarch64-apple-darwin), R 4.5.2

## R CMD check results

0 errors | 0 warnings | 1 note

* checking HTML version of manual ... NOTE
  "Skipping checking HTML validation: 'tidy' doesn't look like recent enough
  HTML Tidy."
  This is an artifact of the outdated HTML Tidy shipped with macOS on the
  local test machine, not a package issue.

## Downstream dependencies

There are no reverse dependencies on CRAN.

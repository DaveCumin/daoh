pkgname <- "daoh"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "daoh-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('daoh')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("calc_daoh")
### * calc_daoh

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: calc_daoh
### Title: Calculate Days Alive and Out of Hospital (DAOH)
### Aliases: calc_daoh

### ** Examples

# --- Example 1: Simple day-stay (highlights nights vs days difference) ---
events <- data.frame(
  patientID = "P1",
  admission = as.Date("2020-03-10"),
  discharge = as.Date("2020-03-10"),  # same-day admission
  dod       = NA
)
idx <- data.frame(patientID = "P1", indexDate = as.Date("2020-03-10"))

calc_daoh(events, idx, period = 30, method = "nights")$daoh  # 30 days
calc_daoh(events, idx, period = 30, method = "days")$daoh    # 29 days

# --- Example 2: Death handling ---
events2 <- data.frame(
  patientID = "P2",
  admission = as.Date("2020-03-10"),
  discharge = as.Date("2020-03-12"),
  dod       = as.Date("2020-03-20")   # died 8 days after discharge
)
idx2 <- data.frame(patientID = "P2", indexDate = as.Date("2020-03-10"))

calc_daoh(events2, idx2, period = 30, method = "nights",
          death_method = "midday")$daoh   # credits pre-death days
calc_daoh(events2, idx2, period = 30, method = "nights",
          death_method = "zero")$daoh     # returns 0




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("calc_daoh", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("daoh_reclassify")
### * daoh_reclassify

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: daoh_reclassify
### Title: Quartile reclassification across two DAOH methods
### Aliases: daoh_reclassify

### ** Examples

# See vignette("getting_started", package = "daoh")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("daoh_reclassify", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("daoh_reclassify_centile")
### * daoh_reclassify_centile

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: daoh_reclassify_centile
### Title: Centile-boundary reclassification across two DAOH methods
### Aliases: daoh_reclassify_centile

### ** Examples

# See vignette("getting_started", package = "daoh")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("daoh_reclassify_centile", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("example_daystay")
### * example_daystay

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: example_daystay
### Title: Synthetic patient example: single day-stay admission
### Aliases: example_daystay
### Keywords: datasets

### ** Examples

data(example_daystay)
calc_daoh(example_daystay$events, example_daystay$index_dates,
          period = 30, method = "nights")
calc_daoh(example_daystay$events, example_daystay$index_dates,
          period = 30, method = "days")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("example_daystay", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("example_death")
### * example_death

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: example_death
### Title: Synthetic patient example: multiple admissions and death
### Aliases: example_death
### Keywords: datasets

### ** Examples

data(example_death)
# All seven variants
for (meth in c("nights", "days", "exact")) {
  for (dm in c("midday", "midnight", "zero")) {
    res <- calc_daoh(example_death$events, example_death$index_dates,
                     period = 30, method = meth, death_method = dm)
    cat(meth, dm, "DAOH =", round(res$daoh, 2), "\n")
  }
}



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("example_death", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("example_population")
### * example_population

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: example_population
### Title: Synthetic population: 500 patients, mixed admission patterns
### Aliases: example_population
### Keywords: datasets

### ** Examples

data(example_population)
res_n <- calc_daoh(example_population$events, example_population$index_dates,
                   period = 90, method = "nights")
res_d <- calc_daoh(example_population$events, example_population$index_dates,
                   period = 90, method = "days")
bland_altman_daoh(res_n, res_d)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("example_population", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("hospital_time")
### * hospital_time

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: hospital_time
### Title: Convert admission/discharge date pairs to numeric time intervals
### Aliases: hospital_time

### ** Examples

# Same-day admission: nights=0, days=1
hospital_time(
  admission_dates = as.Date("2020-03-01"),
  discharge_dates = as.Date("2020-03-01"),
  method = "nights"
)
hospital_time(
  admission_dates = as.Date("2020-03-01"),
  discharge_dates = as.Date("2020-03-01"),
  method = "days"
)

# Two-night stay
hospital_time(
  admission_dates = as.Date("2020-03-01"),
  discharge_dates = as.Date("2020-03-03"),
  method = "nights"   # 2 nights
)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("hospital_time", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("load_example")
### * load_example

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: load_example
### Title: Load a built-in example dataset
### Aliases: load_example

### ** Examples

ex <- load_example("daystay")
calc_daoh(ex$events, ex$index_dates, period = 30, method = "nights")
calc_daoh(ex$events, ex$index_dates, period = 30, method = "days")




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("load_example", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("merge_intervals")
### * merge_intervals

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: merge_intervals
### Title: Merge overlapping or near-adjacent time intervals
### Aliases: merge_intervals

### ** Examples

# Two admissions 10 hours apart -> merged into one
merge_intervals(
  starts = c(0, 1.5),
  ends   = c(1.0, 2.5),
  gap    = 0.5
)

# Two admissions 2 days apart -> kept separate
merge_intervals(
  starts = c(0, 3),
  ends   = c(1, 4),
  gap    = 0.5
)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("merge_intervals", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')

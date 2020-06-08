# regexhelpeR

A small R package to deal with regular expressions, mainly in dictionaries. This
is used in [multidictR](https://github.com/jogrue/multidictR) and
[popdictR](https://github.com/jogrue/popdictR).


## Install

This package requires the stringr package and can be installed from within R
using [devtools](https://github.com/hadley/devtools):

```R
library(devtools)

# Install the socmedhelpeRs package from GitHub
devtools::install_github("jogrue/regexhelpeR")
```



## Usage

```R
# Loading the package
library("regexhelpeR")

# Some (greedy and one mixed) regular expressions
pat <- c("politic(.*)", "boy(s)?", "part(y|i)(.+)", "(.*)mixed(.*?)")

# Switch between lazy and greedy patterns
pat_switched <- switch_regex_greedy_lazy(pat)
pat
# [1] "politic(.*)"    "boy(s)?"        "part(y|i)(.+)"  "(.*)mixed(.*?)"
pat_switched
# [1] "politic(.*?)"   "boy(s)??"       "part(y|i)(.+?)" "(.*?)mixed(.*)"

# Turn all greedy patterns to lazy patterns
pat_lazy <- make_all_regex_lazy(pat)
pat_lazy
# [1] "politic(.*?)"    "boy(s)??"        "part(y|i)(.+?)"  "(.*?)mixed(.*?)"

# Turn all lazy patterns to greedy patterns
pat_greedy <- make_all_regex_greedy(pat_lazy)
pat_greedy
#[1] "politic(.*)"   "boy(s)?"       "part(y|i)(.+)" "(.*)mixed(.*)"

# Optimizations for running the dictionaries
pat_optim <- optimize_regex_patterns(pat_greedy)
pat_greedy
# [1] "politic(.*)"   "boy(s)?"       "part(y|i)(.+)" "(.*)mixed(.*)"
pat_optim
# [1] "\\bpolitic"          "\\bboy(s)?\\b"       "\\bpart(y|i)(.+)\\b" "mixed"  
```

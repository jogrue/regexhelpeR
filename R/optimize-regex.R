# ------------------------------------------------------------------------------
#
# Script name: optimize-regex.R
#
# Purpose of script: Functions to optimize regex patterns
#
# Author: Johann Gründl
# Email: mail@johanngruendl.at
#
# Date created: 2020-06-08
# Date updated: 2020-06-08
#
# ******************************************************************************


#' Optimize regular expression
#'
#' @noMd
#' @description Currently, word boundaries are added to regular expressions,
#' otherwise dictionary patterns would be open (e.g., "cat" would also match
#' "category"). If patterns start or end with a catchall wildcard "(.*)",
#' this expression is removed. These patterns are then processed much quicker.
#'
#' This function allows to provide a list of patterns such as
#' c("dog", "cat(.*)"). "dog" then only matches the word dog because
#' it is replaced with "\\\\bdog\\\\b". "cat(.*)" would match cat, cats,
#' catastrophe, etc. (but not, e.g., tomcat) because it is replaced with
#' "\\\\bcat" (which is also a lot quicker than keeping
#' "\\\\bcat(.*)").
#'
#' The function is intended to pre process patterns in the style of the
#' popdictR package.
#'
#' @param patterns The regular expression which should be optimized.
#'
#' @return An optimized regular expression
#' @export
#'
optimize_regex_patterns <- function(patterns) {
  patterns <- stringr::str_replace_all(patterns, "(^|$)", "\\\\b")
  patterns <- stringr::str_replace_all(
    string = patterns,
    pattern = stringr::fixed("\\b(.*)"),
    replacement = ""
  )
  patterns <- stringr::str_replace_all(
    string = patterns,
    pattern = stringr::fixed("(.*)\\b"),
    replacement = ""
  )
  patterns <- stringr::str_replace_all(
    string = patterns,
    pattern = "(\\\\b){2,}",
    replacement = "\\\\b"
  )
  return(patterns)
}

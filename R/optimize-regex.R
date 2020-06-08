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
#' @description Currently, word boundaries are added to regular expressions,
#' otherwise dictionary patterns would be open (e.g., "boy" would also match
#' "boycott"). If patterns start or end with a catchall wildcard "(.*)", this
#' expression is removed. These patterns are then processed much quicker.
#' 
#' This function allows to provide a list of patterns such as
#' c("girl", "boy(.*)"). "girl" then only matches the world girl because it is
#' replaced with "\\bgirl\\b". "boy(.*)" would match boy, boys, boycott, etc.
#' because it is replaced with "\\bboy" (which is also a lot quicker than
#' keeping "\\bboy(.*)").
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
  return(patterns)
}

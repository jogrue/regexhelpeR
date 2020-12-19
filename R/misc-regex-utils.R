# ------------------------------------------------------------------------------
#
# Script name: misc-regex-utils.R
#
# Purpose of script: Some helper functions to work with regular expressions
#
# Author: Johann Gründl
# Email: mail@johanngruendl.at
#
# Date created: 2020-06-10
# Date updated: 2020-06-10
#
# ******************************************************************************


#' Change glob pattern to regular expression pattern
#'
#' @description Change glob wildcards to regular expressions. Word boundaries
#' are added if no wildcard was present. Thus, "dog" becomes "\\\\bdog\\\\b" and
#' "dog*" becomes "\\\\bdog".
#'
#' @param pattern A glob-style character vector
#'
#' @return A character vector containing regular expressions instead of
#' glob-style wildcards
#'
#' @export
#'
glob_to_regex <- function(pattern) {
  pattern <- utils::glob2rx(pattern, trim.head = TRUE, trim.tail = TRUE)
  pattern <- stringr::str_replace_all(pattern, "^\\^", "\\\\b")
  pattern <- stringr::str_replace_all(pattern, "\\$$", "\\\\b")
  return(pattern)
}

# ------------------------------------------------------------------------------
#
# Script name: greedy-lazy-regex.R
#
# Purpose of script: Functions to switch between greedy and lazy regex patterns.
#
# Author: Johann Gründl
# Email: mail@johanngruendl.at
#
# Date created: 2020-06-08
# Date updated: 2020-06-08
#
# ******************************************************************************


#' Make regex patterns greedy
#' 
#' @description Returns the provided pattern in greedy format. The ? is removed
#' in all instances of ??, +?, *?, {n,}?, {n,m}?.
#'
#' @param pattern A regex pattern in lazy format
#'
#' @return The provided pattern in greedy format.
#' @export
make_all_regex_greedy <- function(pattern) {
  stringr::str_replace_all(pattern,
                           "(?<!\\\\)([\\?\\*\\+\\}])\\?",
                           "\\1")
}


#' Make regex patterns lazy
#' 
#' @description Returns the provided pattern in lazy format. Repetition
#' operators are replaced by their lazy versions: ??, +?, *?, {n,}?, {n,m}?.
#'
#' @param pattern A regex pattern in greedy format
#'
#' @return The provided pattern in lazy format.
#' @export
make_all_regex_lazy <- function(pattern) {
  pattern <-
    stringr::str_replace_all(pattern,
                             "(?<!\\\\)([\\*\\+\\}])(?!\\?)",
                             "\\1\\?")
  pattern <-
    stringr::str_replace_all(pattern,
                             "(?<![\\?\\*\\+\\}\\\\])(\\?)(?!\\?)",
                             "\\1\\?")
  return(pattern)
}


#' Switch between lazy and greedy in regex patterns
#' 
#' @description Lazy repetition operators are replaced by greedy ones and vice
#' versa.
#' 
#' On a minor note: Internally the pattern "_LAZZZY170605_" is used for
#' replacements. Thus, provided patterns should not include this pattern.
#'
#' @param pattern A regex pattern.
#'
#' @return The provided pattern with lazy operators switched to greedy and
#' greedy operators switched to lazy.
#' 
#' @export
switch_regex_greedy_lazy <- function(pattern) {
  # replace the lazy expressions' ? with unique pattern _LAZZZY170605_
  pattern <- stringr::str_replace_all(pattern,
                                      "((?<!\\\\)[\\?\\*\\+\\}])(\\?)",
                                      "\\1_LAZZZY170605_")
  # replace the greedy expressions with lazy version
  pattern <- stringr::str_replace_all(
    pattern,
    "((?<!\\\\)[\\?\\*\\+\\}])(?!_LAZZZY170605_)",
    "\\1?"
  )
  # remove the lazy marker from previously lazy expressions (making them greedy)
  pattern <- stringr::str_replace_all(string = pattern,
                                      pattern = stringr::fixed(
                                        "_LAZZZY170605_",
                                        ignore_case = FALSE
                                      ),
                                      replacement = "")
  return(pattern)
}

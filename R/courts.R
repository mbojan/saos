#' Information about all common courts
#'
#' A dataset containing basic information about Polish common courts and their
#'   organisational structure. Up-to-date version of this dataset could be
#'   obtained with \code{\link{get_courts}}.
#'
#' @format A data frame with 291 rows and 6 variables:
#' \tabular{rlll}{
#' n \tab name \tab type \tab description \cr
#' [,1] \tab id \tab integer \tab court ID in the repository \cr
#' [,2] \tab name \tab character \tab full name of the court \cr
#' [,3] \tab type \tab character \tab type of the court; district, regional or 
#'   appeal \cr
#' [,4] \tab code \tab character \tab court's code, see details below \cr
#' [,5] \tab parentCourt \tab integer \tab ID of the superior court \cr
#' [,6] \tab divisions \tab list \tab details of the court's divisions, see 
#'   details below   \cr
#' }
#' Court's code represents nested structure. It is in format "15BBCCDD" where
#'   "15" - code representing common courts, 
#'   "BB" - code of the coresponding appeal court, 
#'   "CC" - code of the corresponding regional court ("00" for appeal courts),
#'   "DD" - code of the district court ("00" for appeal and regional courts).
#'  All codes are multiples of five.     
#'
#' Information about divisions is stored in dataframes with following columns.
#' \tabular{rlll}{
#' n \tab name \tab type \tab description \cr
#' [,1] \tab id \tab integer \tab unique ID \cr
#' [,2] \tab name \tab character \tab full name of the division \cr
#' [,3] \tab code \tab character \tab court's code, see details below \cr
#' [,4] \tab type \tab character \tab type of the division \cr
#' }
#' Code of the division is in the format "AABCCDD", where
#'   "AA" - code of affiliate division, "00" for local division
#'   "B" - type of affiliate division, "0" for local division, "1" or "2" for 
#'     affiliate division
#'   "CC" - number of division in the given court (multiples of five or, in
#'     cases of more than 20 divisions, multiples of three),
#'   "DD" - code corresponding to the type of the division (multiples of three).
#' 
#' There is no missing data except for structural \code{NA}s in \code{parentCourt}.
#' 
#' @source \url{https://saos-test.icm.edu.pl/api/dump/courts}
"courts"
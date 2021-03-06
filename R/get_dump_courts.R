#' Download all common courts
#'
#' Download information about all common courts in the repository.
#'
#' @template dump_param
#' 
#' @return If \code{simplify = FALSE} the list of all common courts as returned 
#'   from API. Every element of the list represents one court and has the 
#'   following, illustrative structure: \cr
#'   List of 6 \cr
#'    $ id         : int 1 \cr
#'    $ name       : chr "Sąd Apelacyjny we Wrocławiu" \cr
#'    $ type       : chr "APPEAL" \cr
#'    $ code       : chr "15500000" \cr
#'    $ parentCourt: NULL \cr
#'    $ divisions  :List of 3 \cr
#'    ..$ :List of 4 \cr
#'    .. ..$ id  : int 1 \cr
#'    .. ..$ name: chr "I Wydział Cywilny" \cr
#'    .. ..$ code: chr "0000503" \cr
#'    .. ..$ type: chr "Cywilny" \cr
#'    ..$ :List of 4 \cr
#'    .. ..$ id  : int 2 \cr
#'    .. ..$ name: chr "II Wydział Karny" \cr
#'    .. ..$ code: chr "0001006" \cr
#'    .. ..$ type: chr "Karny" \cr
#'    ..$ :List of 4 \cr
#'    .. ..$ id  : int 3 \cr
#'    .. ..$ name: chr "III Wydział Pracy i Ubezpieczeń Społecznych" \cr
#'    .. ..$ code: chr "0001521" \cr
#'    .. ..$ type: chr "Pracy i Ubezpieczeń Społecznych" \cr
#'    
#'    Detailed description of the meaning of all elements could be found in
#'    \code{\link[saos]{courts}}.
#'    
#'    If \code{simplify = TRUE} a \code{data.frame} as described in 
#'    \code{\link[saos]{courts}} is returned.
#'   
#' @seealso \code{\link[saos]{courts}}, \code{\link[saos]{get_dump_scChambers}}
#' 
#' @export

get_dump_courts <- function(simplify = FALSE){
  url <- "https://saos-test.icm.edu.pl/api/dump/commonCourts"
  courts <- get_all_items(url, query = list(pageSize = 100))
  if (simplify) courts <- simplify_courts(courts)
  courts
}



#### utility functions ####

# simplifying to data frame
simplify_courts <- function(courts){
  parentCourt <- sapply(courts, function(x) {
    if (is.null(x$parentCourt)) { NA } else { x[["parentCourt"]][[1]] }
    })
  divisions <- lapply(courts, function(x) {
    as.data.frame(dplyr::bind_rows(lapply(x$divisions, dplyr::as_data_frame)))
  })
  res <- data.frame(id = sapply(courts, `[[`, "id"), 
                    name = sapply(courts, `[[`, "name"), 
                    type = sapply(courts, `[[`, "type"), 
                    code = sapply(courts, `[[`, "code"),
                    parentCourt = parentCourt, 
                    stringsAsFactors = FALSE)
  res$divisions <- divisions
  res
}
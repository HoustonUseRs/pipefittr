#' pop
#' 
#' a pop function that behaves like .pop() in
#' python or javascript
#'
#' @param vec a vector, from which last variable is extracted
#'
#' @importFrom utils tail
#'
pop <- function(vec) {
  newvec <- vec[-length(vec)]
  vecname <- deparse(substitute(vec))
  
  # this does seem to be used in the pkg.
  # assign(vecname, newvec, envir = .GlobalEnv)
  tail(vec, 1) 
}
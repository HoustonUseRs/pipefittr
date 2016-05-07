test_str <- "bop_on( 
  scoop_up( 
    hop_through(foo_foo, forest),
    field_mouse ),
  head )"

# a pop function that behaves like .pop() in
# python or javascript
pop <- function(vec){
  newvec <- vec[-length(vec)]
  vecname <- deparse(substitute(vec))
  assign(vecname, newvec, envir = .GlobalEnv)
  tail(vec, 1) 
}

piperize <- function(string){
  # remove whitespace
  string_ns <- gsub("\\s+", "", test_str)
  
}
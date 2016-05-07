test_str <- "bop_on( 
  scoop_up( 
    hop_through(foo_foo, forest),
    field_mouse ),
  head )"


piperize <- function(string){
  # remove whitespace
  string_ns <- gsub("\\s+", "", test_str)
  
}
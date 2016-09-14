
globalVariables(".")

#' make_output
#' 
#' @keywords internal
#' 
#' @param funclist a list of functions
#'
#' @importFrom utils tail
#'
make_output <- function(funclist) {
  output = ""
  
  while(length(funclist) > 0) {
    # pop
    func <- tail(funclist, 1)
    funclist <- funclist[-length(funclist)]
    funcname_str <- names(func)
    
    # unpack
    if (length(func[[1]])) { # if there are arguments
      
      # remove . if its the first element
      if(func[[1]][1] == ".") func[[1]] <- func[[1]][-1]
      
      arg_str <- paste(func[[1]], collapse = ", ")
      func_str <- paste0(funcname_str, "(", arg_str, ")")
    } else { # incase of no arguments
      func_str <- funcname_str
    }
    
    # add a %>%
    if (length(funclist) == 0) {
      full_str <- func_str
    } else {
      full_str <- paste0(func_str, " %>% ")
    }
    
    output <- paste0(output, full_str)
  }
  
  #remove leading whitespace
  output <- gsub("^\\s+", "", output)
  
  output
}


#' make_list
#' @keywords internal
#' 
#' @param string a string to be converted into a list
#'
#' @importFrom utils tail
#'
make_list <- function(string) {
  
  # extract func names
  fwd <- string %>% 
    gsub("\\s+", "", .) %>%
    strsplit("\\(")
  
  fwd <- fwd[[1]]
  
  bk <- tail(fwd, 1) %>% 
    strsplit("\\)") %>%
    unlist()
  
  fwd <- fwd[-length(fwd)]
  
  #pop the start
  start <- strsplit(bk[[1]][1], ",")[[1]][1]
  bk[1] <- ifelse(grepl(",", bk[1]), unlist(strsplit(bk[1], ","))[-1], "")
  
  # vector of args
  bk <- gsub("^,", "", bk)
  
  l <- as.list(rev(bk))
  names(l) <- fwd
  
  l[] <- strsplit(paste(".", l), " ")
  
  # make list 
  l <- append(l, 0)
  names(l)[length(l)] <- start
  l[length(l)] <- list(NULL)
  
  l
}


#' Convert nested calls to magrittr's pipes.
#' 
#' To take nested function calls and convert them to a more readable form using magrittr's pipes.
#'
#' @param string a string, to be converted into \code{magrittr}'s pipe syntax
#' @param pretty create a multiline output, which is prettier. Try this.
#' 
#' @import magrittr
#' 
#' @examples
#' teststring = "jump_on(bop_on( scoop_up( hop_through(foo_foo, forest), field_mouse ), head))"
#' pipefittr(teststring, pretty = TRUE)
#'   
#' 
#' @export
pipefittr <- function(string, pretty=F) {
  out_string <- string %>%
    make_list() %>%
    make_output() %>%
    ifelse(pretty, gsub("%>% ", "%>%\n  ", .), .)
  cat(out_string)
  invisible(out_string)
}

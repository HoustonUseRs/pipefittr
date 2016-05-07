require(dplyr)

test_str <- "bop_on( 
  scoop_up( 
    hop_through(foo_foo, forest),
    field_mouse ),
  head )"

test_str2 <- "select(
                filter(
                  read.csv('data.csv', as.is=T)
                )
              )"
# we're assuming we can get here ->
test_list <- list(bop_on = c(".", "head"), 
                  scoop_up = c(".", "field_mouse"), 
                  hop_through = c(".", "forest"), 
                  foo_foo = NULL)

test_list2 <- list(summarise = c(".", "m = mean(wt)"), 
                   filter = c(".", "mpg > 20"), 
                   mtcars = NULL)

make_output <- function(funclist) {
  output = ""
  
  while(length(funclist) > 0){
    # pop
    func <- tail(funclist, 1)
    funclist <- funclist[-length(funclist)]
    funcname_str <- names(func)
    
    # unpack
    if (length(func[[1]])) {
      arg_str <- paste(func[[1]], collapse=", ")
      func_str <- paste0(funcname_str, "(", arg_str, ")")
    } else {
      func_str <- funcname_str
    }
    
    #add a %>%
    if (length(funclist) == 0) {
      full_str <- func_str
    } else {
      full_str <- paste(func_str, "%>%")
    }
    output <- paste(output, full_str)
  }
  
  output
}

make_list <- function(string) {
  # remove whitespace
  fwd <- string %>% 
    gsub("\\s+", "", .) %>%
    strsplit("\\(")
  
  fwd <- fwd[[1]]
  
  #pop the back
  bk <- tail(fwd, 1) %>% 
    strsplit("\\)") %>%
    unlist()
  
  fwd <- fwd[-length(fwd)]
  
  #pop the start
  start <- strsplit(bk[[1]][1], ",")[[1]][1]
  
  bk[1] <- unlist(strsplit(bk[1], ","))[-1]
  
  bk <- gsub("^,", "", bk)
  
  l <- as.list(rev(bk))
  names(l) <- fwd
  
  l[] <- strsplit(paste(".", l), " ")
  
  # make list like test_list or test_list2
  l <- append(l, 0)
  names(l)[length(l)] <- start
  l[length(l)] <- list(NULL)
  
  l
}


#' pipefittr
#'
#' @param string 
pipefittr <- function(string) {
  l <- make_list(string)
  #l <- test_list
  make_output(l)
}
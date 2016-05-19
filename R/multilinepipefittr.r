##
## [multilinepipefittr.r]
##
## author     : Ed Goodwin
## project    : pipefittr
## createdate : 05.15.2016
##
## description:
##    multiline conversion for pipefittr
##
## version: 0.01
## changelog:
##

# tmp_bunny1 <- foo_foo
# tmp_bunny2 <- hop_through(tmp_bunny1, forest)
# tmp_bunny3 <- scoop_up(tmp_bunny2, field_mouse)
# tmp_bunny4 <- bop_on(tmp_bunny3, head)

# foo_foo <- little_bunny()
# tmp_bunny4 <- foo_foo %>% 
#   hop_through(forest) %>% 
#   scoop_up(field_mouse) 
# %>% bop_on(head)

## NOT WORKING YET...NEED TO PARSE CODE STRING INTO DATAFRAME

require(dplyr)
require(pipefittr)

unpackstr = function(atom) {
  if(is.character(atom) == FALSE)
    stop("Error: unpackstr input must be string")
  atom = as.character(atom)
  # pull args
  atoms = make_list(atom)  
  atoms
}

multistrdf = data.frame(funchead=c("tmp_bunny1", 
                               "tmp_bunny2", 
                               "tmp_bunny3", 
                               "tmp_bunny4"), 
                        functail=c("foo_foo()", 
                               "hop_through(tmp_bunny1, forest)", 
                               "scoop_up(tmp_bunny2, field_mouse)",
                               "bop_on(tmp_bunny3, head)"))


pipestr = paste0(multistrdf$funchead[nrow(multistrdf)], " = ")


for (i in 1:length(multistrdf$functail)) {
  if (i == 1) {
    pipestr = paste0(pipestr, as.character(multistrdf$functail[i]))
  }
  else {
    funccall = as.character(multistrdf$functail[i])
    atomlist = unpackstr(funccall)
    funcname = names(atomlist)[1]
    argsname = paste(atomlist[[1]], collapse = ", ")
    
    pipestr = paste0(pipestr, " %>% ", funcname, "(", argsname, ")")
  }
  i = i+1
}

pipestr

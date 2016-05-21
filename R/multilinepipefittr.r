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

splitmultistrtolist = function(stringtosplit) {
  strlist = str_split(stringtosplit, "\n")  
  strlist
}

splitlisttodf = function(listtosplit) {
  atomsdf = data.frame()
  for(line in listtosplit[[1]]) {
    atoms = str_split_fixed(line, "<-|\\=", 2)
    convdf = data.frame(funchead = atoms[1],
                        functail = atoms[2])
    atomsdf = rbind(atomsdf, convdf)
  }
  atomsdf
}

unpackstr = function(atom) {
  if(is.character(atom) == FALSE)
    stop("Error: unpackstr input must be string")
  atom = as.character(atom)
  # pull args
  atoms = make_list(atom)  
  atoms
}

multipipefittr = function(multistrdf) {
  pipestr = paste0(multistrdf$funchead[nrow(multistrdf)], " = ")
  
  # remove . if its the first element

  for (i in 1:length(multistrdf$functail)) {
    if (i == 1) {
      pipestr = paste0(pipestr, as.character(multistrdf$functail[i]))
    }
    else {
      funccall = as.character(multistrdf$functail[i])
      atomlist = unpackstr(funccall)
      funcname = names(atomlist)[1]

      # removing first .
      if(atomlist[[1]][1] == ".") atomlist[[1]] <- atomlist[[1]][-1]
      argsname = paste(atomlist[[1]], collapse = ", ")
      
      pipestr = paste0(pipestr, " %>% ", funcname, "(", argsname, ")")
    }
    i = i + 1
  }
  
  pipestr
}


if(FALSE){
  # wrapping example, into a non-runnable block. 
  # pkg build fails.
  
  require(dplyr)
  require(pipefittr)
  require(stringr)
  
  ## Example
  multistrdfex = data.frame(funchead=c("tmp_bunny1", 
                                       "tmp_bunny2", 
                                       "tmp_bunny3", 
                                       "tmp_bunny4"), 
                            functail=c("foo_foo(dummy_df)", 
                                       "hop_through(tmp_bunny1, forest)", 
                                       "scoop_up(tmp_bunny2, field_mouse)",
                                       "bop_on(tmp_bunny3, head)"))
  multipipefittr(multistrdfex)

  # Example, with nesting and multi-line breaks!
  multistrdfex = data.frame(funchead=c("tmp_bunny1", 
                                       "tmp_bunny2", 
                                       "tmp_bunny3", 
                                       "tmp_bunny4"), 
                            functail=c("foo_foo(dummy_df)", 
                                       "hop_through(tmp_bunny1, forest)", 
                                       "scoop_up(tmp_bunny2, log(field_mouse))",
                                       "bop_on(tmp_bunny3, head)"))
  multipipefittr(multistrdfex)
  # we get
  # "tmp_bunny4 = foo_foo(dummy_df) %>% hop_through(forest) %>% scoop_up() %>% bop_on(head)"
  # shoud be:
  # "tmp_bunny4 = foo_foo(dummy_df) %>% hop_through(forest) %>% scoop_up(log(field_mouse)) %>% bop_on(head)"
}



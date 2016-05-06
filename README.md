# piperize_or_pipefittr

a function in R to take nested function calls and convert them to a more readable form using magrittr's pipes.

e.g. (example taken from Hadley Wickham):

    foo_foo <- little_bunny()
    bop_on( scooop_up( hop_through(foo_foo_ forest), field_mouse ), head )
    

converts to:

    foo_foo <- little_bunny()
    foo_foo %>% 
      hop_through(forest) %>% 
      scoop_up(field_mouse) 
      %>% bop_on(head)
    

Ostensibly, the (same?) function would also be able to remedy horrendous situations like this:

    tmp_bunny1 <- foo_foo
    tmp_bunny2 <- hop_through(tmp_bunny1, forest)
    tmp_bunny3 <- scoop_up(tmp_bunny2, field_mouse)
    tmp_bunny4 <- bop_on(tmp_bunny3, head)
    
This would also resolve to the above with the minor difference that it would now be assigned to `tmp_bunny4`. 
It can be up to the user to change that later.

# some disorganized ideas on how the function could work:

steps:

1. collapse all new-lines within parentheses
2. parse the order of operations
3. construct and return the pipe

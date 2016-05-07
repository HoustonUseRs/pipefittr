##
## [testpipefittr.r]
##
## author     : Ed Goodwin
## project    : pipefittr
## createdate : 05.07.2016
##
## description:
##    test of piping functionality in pipefittr
##
## version: 0.01
## changelog:
##

## test stub...dispose of before commit to repo
# pipefittr = function(string) {
#   pipestring = paste(
#     "foo_foo <- little_bunny()\n",
#     "foo_foo %>%\n",
#     "\thop_through(forest) %>%\n",
#     "\tscoop_up(field_mouse) %>%\n",
#     "\tbop_on(head)",
#     sep = ""
#   )
#   pipestring
# }

context("test harness for pipefittr")
test_that("Simple bunny foo foo convert", {
  teststring = paste(
    "foo_foo <- little_bunny()\n",
    "bop_on( scoop_up( hop_through(foo_foo, forest),",
    "field_mouse ), head )",
    sep = ""
  )
  pipestring = paste(
    "foo_foo <- little_bunny()\n",
    "foo_foo %>%\n",
    "\thop_through(forest) %>%\n",
    "\tscoop_up(field_mouse) %>%\n",
    "\tbop_on(head)",
    sep = ""
  )
  expect_match(pipestring, pipefittr(teststring))
})

test_that("Complex bunny foo foo convert",{
  teststring = paste(
    "tmp_bunny1 <- foo_foo\n",
    "tmp_bunny2 <- hop_through(tmp_bunny1, forest)\n",
    "tmp_bunny3 <- scoop_up(tmp_bunny2, field_mouse)\n",
    "tmp_bunny4 <- bop_on(tmp_bunny3, head),\n",
    sep = ""
  )
  
  pipestring = paste(
    "foo_foo <- little_bunny()\n",
    "tmp_bunny4 <- foo_foo %>%\n", 
    "\thop_through(forest) %>%\n", 
    "\tscoop_up(field_mouse) %>%\n",
    "bop_on(head)",
    sep = ""
  )
  expect_match(pipestring, pipefittr(teststring))
})



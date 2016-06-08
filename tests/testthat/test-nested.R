library(testthat)
#
# [test-nested.r]
#
# description:
#    test of piping functionality in pipefittr, focussing on single line nested functions

context("test conversion of nested functions")
test_that("conversion works, in case of no args", {
  
  # ------------ in case of no args ------------------------ #
  teststring = "jump_on(bop_on( scoop_up( hop_through(foo_foo, forest), field_mouse ), head))"
  pipestring = "foo_foo %>% hop_through(forest) %>% scoop_up(field_mouse) %>% bop_on(head) %>% jump_on()"
  expect_equal(pipefittr(teststring), pipestring)
})

test_that("conversion works, in case of two args", {
  # ------------ in case of two args, one with = ------------------------ #
  teststring = "jump_on(bop_on( scoop_up( hop_through(foo_foo, forest), field_mouse, color = 'white'), head))"
  pipestring = "foo_foo %>% hop_through(forest) %>% scoop_up(field_mouse,color='white') %>% bop_on(head) %>% jump_on()"
  expect_equal(pipefittr(teststring), pipestring)
})
  
test_that("conversion works, in case of args, with comma", {
  # ------------ in case of two args, with a comma ------------------------ #
  teststring = "jump_on(bop_on( scoop_up( hop_through(foo_foo, forest), field_mouse, color = 'white,blue'), head))"
  pipestring = "foo_foo %>% hop_through(forest) %>% scoop_up(field_mouse,color='white,blue') %>% bop_on(head) %>% jump_on()"
  expect_equal(pipefittr(teststring), pipestring)
})






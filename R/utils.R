highlightCode <- function(session, id) {
  session$sendCustomMessage("highlight-code", list(id = id))
}

rCodeContainer <- function(...) {
  code <- HTML(as.character(tags$code(class = "language-r", ...)))
  div(pre(code))
}

renderCode <- function(expr, env = parent.frame(), quoted = FALSE) {
  func <- NULL
  installExprFunction(expr, "func", env, quoted)
  markRenderFunction(textOutput, function() {
    paste(func(), collapse = "\n")
  })
}
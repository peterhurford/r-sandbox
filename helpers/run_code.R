Ramd::define('error', function(error) {
  verify_body_legality <- function(body) {
    blacklist <- c("source", "system", "try", "tryCatch", "stop",
                   "library", "require", "warning",
                   "remove.packages", "install.packages", "loadNamespace",
                   "unloadNamespace", "history", "ls")
    parsed <- try(silent = TRUE, parse(text = body))
    if (is(parsed, 'try-error')) { return(error("Cannot parse.")) }
    parsed_body <- parsed

    native_tokens <- setdiff(all.names(parsed_body), all.vars(parsed_body))
    illegal_tokens <- intersect(native_tokens, blacklist)
    if (length(illegal_tokens) > 0) {
      return(error("You are not allowed to use: ",
                   paste(illegal_tokens, collapse = ', ')))
    }
    TRUE
  }


  provided_env <- getNamespace("base")
  execute_body <- function(body) {
    input <- body
    body <- textConnection(body)
    # TODO: (RK) Better environment sequestering.
    value <- try(silent = TRUE, local({
      # TODO: (RK) Use opencpu's mechanism for time limit on forks
      # setTimeLimit(1, transient = TRUE)
      source(body, local = provided_env)$value
    }))
    close(body)
    if (is(value, 'try-error')) {
      return(list(input = input, output = paste("<b>Error:</b>", attr(value, 'condition')$message)))
    }
    list(input = input, output = capture.output(value))
  }

  run_code <- function(params) {
    check <- verify_body_legality(params$body)
    if (!isTRUE(check)) { return(check) }
    microserver:::to_json(execute_body(params$body))
  }
})


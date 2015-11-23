function(...) {
  msg <- paste0(...)
  microserver_response(list(message = msg), status = 500)
}

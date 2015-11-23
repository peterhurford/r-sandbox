routes <- Ramd::define('helpers/error', function(error) {
  list(
  '/process' = Ramd::define('helpers/run_code', function(run_code) {
      force(run_code)
      function(params, query) {
        return(params)
        params <- as.list(params)
        required <- c('body')
        for (name in required) {
          if (!is.element(name, names(params))) { return(error("Missing `", name, "`")) }
        }
        run_code(params)
      }
    }),
  '/ping' = function (p, q) { c("PONG") },
  function(...) { "Nothing to see here." }
)})
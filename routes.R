routes <- Ramd::define("helpers/error", function(error) {
  list(
  "/process" = Ramd::define("helpers/run_code", function(run_code) {
      force(run_code)
      function(params, query) {
        params <- as.list(params)
        required <- c('body')
        for (name in required) {
          if (!is.element(name, names(params))) { return(error("Missing `", name, "`")) }
        }
        run_code(params)
      }
    }),
  "/ping" = function (p, q) { c("PONG") },
  "/js/console.js" = microserver::html_page("js/console.js"),
  microserver::html_page("form.html")
)})

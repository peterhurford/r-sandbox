library(methods)

require_package <- function(pkg, github = FALSE) {
  if (!require(pkg, quietly = TRUE, character.only = TRUE)) {
    if (isTRUE(github)) { devtools::install_github(paste0('robertzk/', pkg)) }
    else { install.packages(pkg) }
    if (!require(pkg, quietly = TRUE)) {
      stop("Could not load ", pkg, ".")
    }
  }
}

lapply(c('Ramd', 'httpuv'), require_package)
lapply('microserver', require_package, github = TRUE)

Ramd::define('routes', function(routes) { microserver::run_server(routes, port = 8102) })

# The R Sandbox

The R Sandbox allows one to run arbitrary R computations in the cloud.  It's good
for demoing R software.

The R sandbox was built by modifying robertzk's [R tutorial engine](https://github.com/robertzk/tutorial-engine), which is built ontop of robertzk's [microserver](http://github.com/robertzk/microserver), which is built ontop of RStudio's [httpuv](https://github.com/rstudio/httpuv), which is built ontop of Joyent's [libuv](https://github.com/libuv/libuv).  Isn't open source cool? 

## Example Usage

From R within this repo, run `source("engine.R")`.  Then you can start sending arbitrary R commands using POST, like:

```
curl -d '{"body": "mean(c(1, 2, 3))"}' http://localhost:8102/process
```

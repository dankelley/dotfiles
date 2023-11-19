options(digits=7, digits.secs=3)
options(repos=c(CRAN="https://cloud.r-project.org"))
options(editor="/Applications/MacVim.app/Contents/bin/vim")
options(device="quartz")
## options(repos="https://cloud.r-project.org")
#options(oceEOS="unesco")
options(oceEOS="gsw")
Sys.setenv(TZ="America/Halifax")
## https://github.com/r-lib/devtools/issues/1921
## Sys.setenv("_R_CHECK_CRAN_INCOMING_"=TRUE)
setHook(packageEvent("grDevices", "onLoad"),
    function(...) grDevices::quartz.options(width=5, height=5))

# https://github.com/dankelley/oce/issues/1977
#> trace(gsub, exit=quote(if ("bytes" %in% Encoding(returnValue())) browser()))

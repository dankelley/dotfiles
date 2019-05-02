options(digits=7, digits.secs=3)
options(repos=c(CRAN="https://cloud.r-project.org"))
options(editor="mvim")
options(device="quartz")
## options(repos="https://cloud.r-project.org")
##options(oceEOS="unesco") # home machine
options(oceEOS="gsw") # work machine
Sys.setenv(TZ="America/Halifax")
## https://github.com/r-lib/devtools/issues/1921
## Sys.setenv("_R_CHECK_CRAN_INCOMING_"=TRUE)
setHook(packageEvent("grDevices", "onLoad"),
        function(...) grDevices::quartz.options(width = 6, height = 6))


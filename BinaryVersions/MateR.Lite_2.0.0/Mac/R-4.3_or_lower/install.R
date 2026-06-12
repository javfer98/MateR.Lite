#Install needed packages
list.of.packages <- c("doParallel",
                      "foreach",
                      "devtools",
                      "httr",
                      "jsonlite")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


#Install MateR.Lite package itself
install.packages("MateR.Lite_2.0.0.tgz", repos = NULL, type = "binary")
library(MateR.Lite)

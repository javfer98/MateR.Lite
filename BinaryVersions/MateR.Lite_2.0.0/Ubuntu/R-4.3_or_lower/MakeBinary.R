#Install needed packages
list.of.packages <- c("doParallel",
                      "foreach",
                      "devtools",
                      "httr",
                      "jsonlite")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos = "https://cran.rediris.es/")




#Run this in the appropriate operating system to build a binary version of MateR.Lite
#I believe we should only publish the binary to avoid people copying it.

#We need to install MateR.Lite first and then build binary with it installed to avoid
#one error specific for this package
install.packages("../../../../MateR.Lite", repos = NULL, type = "source")
devtools::build(pkg="../../../../MateR.Lite",binary = TRUE, path = "./")


remove.packages("MateR.Lite")

install.packages("./MateR.Lite_2.0.0_R_x86_64-pc-linux-gnu.tar.gz")
library(MateR.Lite)
#?GenomicMatingMT




data(ExampleDataDiploid)


#reduce dataset size to be within the demo limitations (100 crosses and 
#100 marker positions)
Parents_tmp <- Parents[1:10] #only the first 10 parents
Markers_tmp<-Markers[1:10,1:100] #only the first 10 parents and 100 markers

#only the first 100 markers:
markereffects_tmp <- lapply(markereffects, function(x) {return(x[1:100])}) 
markereffects_d_tmp <- lapply(markereffects_d, function(x) {return(x[1:100])}) 
c_list_tmp <- list(c_list[[1]][1:100,1:100])


################################################################################
#No testers used
################################################################################

#Without testers, disregard LD
out <- GenomicMatingMT(Parents1 = Parents_tmp,
                       Parents2 = Parents_tmp,
                       separator = "/",
                       LD = "Ind",
                       PropSD = 0.05,
                       Markers = Markers_tmp,
                       parametrization = "Genotypic",
                       phi=2,
                       Markers_T = NULL, #Add testers here
                       markereffects = markereffects_tmp,
                       markereffects_d=markereffects_d_tmp,
                       n = 3,
                       size = 100, #maximum number possible with demo
                       replication = T,
                       coefficients = coefficients,
                       offspring_per_cross = 10,
                       n_selected_per_family=5,
                       Username=NULL, #NULL username --> we are using the demo
                       Password=NULL #NULL password --> we are using the demo
)

out$OptimalMatingScheme[1:5,]
out$PropSD
out$Optimization_quality

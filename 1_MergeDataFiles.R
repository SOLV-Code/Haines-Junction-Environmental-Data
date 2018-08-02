# Script to merge raw csv files into single data set


# -------------------
# Read in the latest version of all the custom functions
fn.file.list <- list.files(path="FUNCTIONS/",pattern=".R") # get all .R files 
for(file.source in fn.file.list){
		print(paste("Sourcing: ",file.source))
		source(paste("FUNCTIONS",file.source,sep="/"))}




# read in raw csv files

Haines_AirTempMin <- read.csv("DATA/EnvData_HainesJct_AirTemp_MnthMeanDailyMin.csv",stringsAsFactors=FALSE)
Haines_AirTempMean <- read.csv("DATA/EnvData_HainesJct_AirTemp_MnthMeanDailyMeans.csv",stringsAsFactors=FALSE)
Haines_AirTempMax <- read.csv("DATA/EnvData_HainesJct_AirTemp_MnthMeanDailyMax.csv",stringsAsFactors=FALSE)

Burwash_WindSpeed <- read.csv("DATA/EnvData_BurwashLdg_WindSpeed_MnthMeanHrlyMean.csv",stringsAsFactors=FALSE)


# test reorg function
test <- cols.reorg(Haines_AirTempMin,var.label="AirTemp_Min",station.label="Haines")
test




merged.data <- rbind(cols.reorg(Haines_AirTempMin,var.label="AirTemp_Min",station.label="Haines"),
			cols.reorg(Haines_AirTempMean,var.label="AirTemp_Mean",station.label="Haines"),
			cols.reorg(Haines_AirTempMax,var.label="AirTemp_Max",station.label="Haines"),
			cols.reorg(Burwash_WindSpeed ,var.label="WindSpeed_Mean",station.label="Burwash")
			)


write.csv(merged.data,file="DATA/1_HainesEnvData_MERGEDFILE.csv",row.names=FALSE)














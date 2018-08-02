# Script to merge raw csv files into single data set


# -------------------
# Read in the latest version of all the custom functions
fn.file.list <- list.files(path="FUNCTIONS/",pattern=".R") # get all .R files 
for(file.source in fn.file.list){
		print(paste("Sourcing: ",file.source))
		source(paste("FUNCTIONS",file.source,sep="/"))}




# read in merged data file
merged.df <- read.csv("DATA/1_HainesEnvData_MERGEDFILE.csv",stringsAsFactors=FALSE)

# convert to date format
merged.df$FullDate <- as.Date( merged.df$FullDate , "%Y/%m/%d")

vars.list <- unique( merged.df[,"Variable"])
stations.list <- unique( merged.df[,"Station"])



# START HANDOUT 1

pdf("OUTPUT/HainesJct_EnvData_Handout1.pdf",onefile=TRUE, height=11,width=8.5)




# Plot full series



# PAGE 1: Air Temp   - Haines JctAvg of Daily Means - By Month


layout(matrix(1:12,ncol=3,byrow=TRUE))
var.idx <- merged.df[,"Station"]== "HainesJct" & merged.df[,"Variable"]== "AirTemp_Mean"
y.label <- "Temperature (C)"

# loop through by quarter
for(month in 1:12){

# start plot
plot( merged.df[var.idx,"FullDate"],merged.df[var.idx ,"Value"],type="n",bty="n",axes=FALSE,xlab="Date",
	ylab = y.label )
axis(2)
yr.ticks <- as.Date(paste(seq(1950,2020,by=10),1,1,sep="/"),"%Y/%m/%d")
axis(1,at=yr.ticks,labels=seq(1950,2020,by=10))
#abline(v=seq.Date(min(merged.df$FullDate),max(merged.df$FullDate),by="year"),col="lightgrey")
abline(v=yr.ticks,col="lightgrey")
abline(h=0,col="red")

month.idx <- merged.df[,"Month"]== month
lines( merged.df[var.idx & month.idx ,"FullDate"],merged.df[var.idx & month.idx  ,"Value"],
		type="o",cex=0.5,col="darkblue",pch=19)
abline(h=median(merged.df[var.idx & month.idx  ,"Value"],na.rm=TRUE),col="red",lty=2)
lines( merged.df[var.idx & month.idx ,"FullDate"],filter(merged.df[var.idx & month.idx  ,"Value"],filter=rep(1/4,4),sides=1),col="red",lwd=1)




title(main = month.abb[month],col.main="darkblue",line=0,cex.main=1.1)

} # end looping through months


title(main = "Haines Junction - Air Temperature (Monthly Avg of Daily Avg)",outer = TRUE, 
		line=-1,cex.main=1.5, col.main="darkblue")




# PAGE 2: Wind Speed   - Haines Jct  By Monthly Avg

layout(matrix(1:12,ncol=3,byrow=TRUE))
var.idx <- merged.df[,"Station"]== "BurwashLdg" & merged.df[,"Variable"]== "WindSpeed_Mean"
y.label <- "Wind Speed (km/h)"

# loop through by quarter
for(month in 1:12){

# start plot
plot( merged.df[var.idx,"FullDate"],merged.df[var.idx ,"Value"],type="n",bty="n",axes=FALSE,xlab="Date",
	ylab = y.label )
axis(2)
yr.ticks <- as.Date(paste(seq(1950,2020,by=10),1,1,sep="/"),"%Y/%m/%d")
axis(1,at=yr.ticks,labels=seq(1950,2020,by=10))
#abline(v=seq.Date(min(merged.df$FullDate),max(merged.df$FullDate),by="year"),col="lightgrey")
abline(v=yr.ticks,col="lightgrey")
abline(h=0,col="red")

month.idx <- merged.df[,"Month"]== month
lines( merged.df[var.idx & month.idx ,"FullDate"],merged.df[var.idx & month.idx  ,"Value"],
		type="o",cex=0.5,col="darkblue",pch=19)
abline(h=median(merged.df[var.idx & month.idx  ,"Value"],na.rm=TRUE),col="red",lty=2)
lines( merged.df[var.idx & month.idx ,"FullDate"],filter(merged.df[var.idx & month.idx  ,"Value"],filter=rep(1/4,4),sides=1),col="red",lwd=1)

title(main = month.abb[month],col.main="darkblue",line=0,cex.main=1.1)

} # end looping through months


title(main = "Burwash Landing - Wind Speed (Monthly Avg)",outer = TRUE, 
		line=-1,cex.main=1.5, col.main="darkblue")






# close pdf for Handout 1
dev.off()



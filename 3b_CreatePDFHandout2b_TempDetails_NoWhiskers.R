# Script to create a pdf handout with 1 page per month showing range of Air Temps in Haines Jct


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









# START HANDOUT 2

pdf("OUTPUT/HainesJct_EnvData_Handout2b_TempDetailsNoRanges_HainesJct.pdf",onefile=TRUE, height=8.5,width=11)

#par(mfrow=c(2,2))

y.label <- "Temperature (C)"


for(month in 1:12){



mean.idx <- merged.df[,"Station"]== "HainesJct"  & merged.df[,"Variable"]== "AirTemp_Mean" & merged.df[,"Month"]== month
mean.vec <- merged.df[mean.idx,"Value"]
mean.dates <- merged.df[mean.idx,"FullDate"] 



x.lim <- range(merged.df[mean.idx ,"FullDate"])
y.lim <- range(merged.df[ mean.idx ,"Value"],na.rm=TRUE)

# start plot
plot( max.dates,max.vec,bty="n",axes=FALSE,xlab="Date",ylab = y.label,xlim=x.lim,ylim=y.lim, type="n")
axis(2)
yr.ticks <- as.Date(paste(seq(1950,2020,by=10),1,1,sep="/"),"%Y/%m/%d")
axis(1,at=yr.ticks,labels=seq(1950,2020,by=10))

#abline(v=yr.ticks,col="darkgrey",lty=1)
abline(h=0,col="red")

lines(mean.dates,mean.vec, type="o",cex=0.7,col="darkblue",pch=19)
abline(h=median(mean.vec,na.rm=TRUE),col="red",lty=2)
lines( mean.dates,filter(mean.vec,filter=rep(1/4,4),sides=1),col="red",lwd=2)






title(main = paste("Haines Junction - Air Temperature",month.abb[month]), line=1,cex.main=1.5, col.main="darkblue")







} # end looping through months







# close pdf for Handout 2
dev.off()



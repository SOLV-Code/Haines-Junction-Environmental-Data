# Script to create a pdf handout with 1 page per month showing a scatterplot of Air Temps in Haines Jct vs. Wind Speed in Burwash Landing


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









# START HANDOUT 3

pdf("OUTPUT/HainesJct_EnvData_Handout3_TempvsWind.pdf",onefile=TRUE, height=8.5,width=11)

#par(mfrow=c(2,2))
par(pty="s")


x.label <- "Min Temperature (C)"
y.label <- "Wind Speed (km/h)"


for(month in 1:12){


mintmp.idx <- merged.df[,"Station"]== "HainesJct"  & merged.df[,"Variable"]== "AirTemp_Min" & merged.df[,"Month"]== month
mintmp.vec <- merged.df[mintmp.idx,"Value"]
mintmp.dates <- merged.df[mintmp.idx,"FullDate"] 

wind.idx <- merged.df[,"Station"]== "BurwashLdg"  & merged.df[,"Variable"]== "WindSpeed_Mean" & merged.df[,"Month"]== month
wind.vec <- merged.df[wind.idx,"Value"]
wind.dates <- merged.df[wind.idx,"FullDate"] 


dates.list <- sort(unique(mintmp.dates,wind.dates))


x.lim <- range(mintmp.vec,na.rm=TRUE)
y.lim <- range(wind.vec,na.rm=TRUE)


# start plot
plot( 1:5,1:5,bty="n",axes=TRUE,xlab=x.label,ylab = y.label,xlim=x.lim,ylim=y.lim, type="n")

abline(v=median(mintmp.vec,na.rm=TRUE),col="red")
abline(h=median(wind.vec,na.rm=TRUE),col="red")


# loop through dates

for(i in 1:length(dates.list)){

date.plot <- dates.list[i]
pt.coords <- c(mintmp.vec[match(date.plot,mintmp.dates)],wind.vec[match(date.plot,wind.dates)])
print("-----")
print(date.plot)
print(pt.coords)
text(pt.coords[1],pt.coords[2],labels=format(date.plot,"%Y"),cex=0.8,col="darkblue",xpd=NA)

}



#abline(v=yr.ticks,col="darkgrey",lty=1)
abline(h=0,col="red")


if(all.equal(min.dates,mean.dates) & all.equal(max.dates,mean.dates) ){
	segments(mean.dates,min.vec,mean.dates,max.vec,lty=1,col="lightgrey")
	}


lines(mean.dates,mean.vec, type="o",cex=0.7,col="darkblue",pch=19)
abline(h=median(mean.vec,na.rm=TRUE),col="red",lty=2)
lines( mean.dates,filter(mean.vec,filter=rep(1/4,4),sides=1),col="red",lwd=2)






title(main = paste("Haines Junction - Air Temperature",month.abb[month]), line=1,cex.main=1.5, col.main="darkblue")







} # end looping through months







# close pdf for Handout 2
dev.off()



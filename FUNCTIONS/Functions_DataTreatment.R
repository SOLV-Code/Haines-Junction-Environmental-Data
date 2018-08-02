# DATA TREATMENT FUNCTIONS


cols.reorg <- function(x,var.label="Variable",station.label="Station"){
# x is a data.frame with rows= years and columns = Months, Classifications, Seasons
# var.label and station.label are labels to be used for the merged file
# this function extracts only the data columns by month and turns it into a "long" data format

month.cols <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

x.sub <- x[,c("Year",month.cols)]

n.rows <- dim(x)[1] * 12


x.out <- data.frame(Year=sort(rep(x.sub[,"Year"],12)),
					Month=rep(1:12,dim(x)[1]),
					Day_Infill = rep(15,n.rows) ,
					FullDate= rep(NA,n.rows),
					Station = rep(station.label,n.rows) ,
					Variable = rep(var.label,n.rows),
					Value = rep(NA,n.rows)
					)

x.out[,"FullDate"] <- paste(x.out[,"Year"],x.out[,"Month"],x.out[,"Day_Infill"],sep="/")


for(yr in x.sub[,"Year"]){
	for(month in month.cols){
		
		month.num <- match(month,month.cols)

		x.out[x.out[,"Year"] == yr & x.out[,"Month"] == month.num , "Value" ] <- x.sub[x.sub[,"Year"]==yr, month]
	}
}







return(x.out)



}





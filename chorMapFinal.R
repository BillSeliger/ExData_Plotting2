## chorMap will create A choropleth Map of total Emissions by FIPS area for the given year

## setwd("C:/Users/rr046302/Documents/Bill's Stuff/Coursera/Exploratory Data Analysis/Project 2")

chorMap <- function(NEIyear){
  
  if(!exists("NEI")) {
    print("Reading NEI file")
    setwd("C:/Users/rr046302/Documents/Bill's Stuff/Coursera/Exploratory Data Analysis/Project 2")
    NEI <- readRDS("summarySCC_PM25.rds")
  }
  
  if(!exists("SCC")) {
    print("Reading SCC file")
    setwd("C:/Users/rr046302/Documents/Bill's Stuff/Coursera/Exploratory Data Analysis/Project 2")
    SCC <- readRDS("Source_Classification_Code.rds")
  }
  
  require(maps)
  require(ggmap)
  require(doBy)
  
## set the color bands  
colors = c("#F1EEF6", "#D4B9DA", "#C994C7", "#DF65B0", "#DD1C77", 
             "#980043")

## summarize by fips and year
  fipssum <- summaryBy(Emissions ~fips + year, data = NEI, keep.names = TRUE, FUN = sum) 
  
## cut Emissions into breaks  
  fipssum$colorBuckets <- cut(fipssum$Emissions, breaks=c(quantile(fipssum$Emissions, probs = seq(0, 1, by = 0.2))),
                              labels=c(1,2,3,4,5), include.lowest=TRUE)

## subset based on the NEIyear called in the function  
  year <- subset (fipssum, year == NEIyear) 
  
  colorsmatched <- year$colorBuckets
title <- paste("NEI PM2.5 Emissions by county ", NEIyear)  

  windows()
  map("county")
  map("county", col = colors[colorsmatched], fill = TRUE, resolution = 0, 
      lty = 0, projection = "polyconic")
  title(title)
  leg.txt <- c("bottom", "2nd", "3rd", "4th", "5th quintile")
  legend("topright", leg.txt, horiz = TRUE, fill = colors)
  
if(!exists("NEI")) {
  print("Assigning NEI to Global Environment")
  assign("NEI", NEI, envir=globalenv())
}

if(!exists("SCC")) {
  print("Assigning SCC to Global Environment")
  assign("SCC", SCC, envir=globalenv())
}

}

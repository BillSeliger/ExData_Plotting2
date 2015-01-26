ggvisChorMap <- function (NEIyear){
  
  
  
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
  
  
  require(ggvis)
  require(dplyr)
  
  require(maps)
  require(ggmap)
  require(doBy)
  
  ## this code should build an interactive map using ggvis

  map_data = ggplot2::map_data("state")
  map_data %>% select(long, lat, group, order, region) %>% 
    group_by(group) %>% 
    ggvis(x = ~long, y = ~lat) %>% 
    layer_paths(fill = ~region) %>%
    hide_legend("fill") %>% 
    handle_click(on_click = function(data, ...) {print(data)})
  
  
  
  
}
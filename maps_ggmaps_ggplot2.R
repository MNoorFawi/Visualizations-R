library(ggplot2)
library(ggmap)

## getting places addresses from google
## for example I want to know how far the three main stadiums 
## of Madrid are away from each other
address <- c("Paseo de la Virgen del Puerto, 67, 28005 Madrid, Spain",
             "Av. de Luis Aragones, 4, 28022 Madrid, Spain",
             "Av. de Concha Espina, 1, 28036 Madrid, Spain")

## Get Longitude and Latitude of ADDRESSES
yy <- geocode(address)

## Add Location Name to the data.frame produced
yy$location <- c("Vicente Calderon Stadium", "Wanda Metroploitano Stadium", 
                 "Santiago Bernabeu Stadium")

yy

## Get the map centralized around the Vicente Calderon St. i.e, first address
bbox <- make_bbox(lon = yy$lon[1], lat = yy$lat[1], f = 0.1)
map <- get_map(location = bbox, zoom = 11, 
               ## we can here change the zoom of the map
               source = "google", maptype = "roadmap")

## draw the MAP & add point labels or whatever texts we want to add
ggmap(map, extent = "device") + 
  geom_point(data = yy, 
             col = c("red2", rep("blue2", 2)),
             alpha = 0.7) + 
  geom_text(data = yy, 
            aes(label = location), 
            col = c("red2", rep("blue2", 2)),
            hjust = 0, vjust = 1) +
  guides(col = FALSE)

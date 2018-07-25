library(ggmap)
library(leaflet)
library(ggplot2)
library(dplyr)

worldWonders <- c("Chichen Itza, Yucatan, Mexico", 
                  "Christ the Redeemer, Rio de Janeiro - RJ, Brazil", 
                  "Great Wall of China, Huairou, China", "Machu Picchu, Peru",
                  "Petra, Jordan", "Taj Mahal, Uttar Pradesh, India",
                  "Colosseum, Roma, Italy",
                  "Great Pyramid of Giza, Giza Governate, Egypt", 
                  "Hanging Gardens of Babylon, Babil, Iraq",
                  "Temple of Artemis at Ephesus, Turkey", 
                  "Statue of Zeus, Olympia, Greece", 
                  "Mausoleum at Halicarnassus, turkey",
                  "Colossus of Rhodes, Greece", 
                  "Lighthouse of Alexandria Egypt, Alexandria, Egypt")

yy <- geocode(worldWonders)
yy$era <- c(rep("New", 7), rep("Old", 7))

pal <- colorFactor(c("navy", "red"), domain = c("New", "Old"))

map <- leaflet(yy) %>% addTiles() %>% 
  addCircleMarkers(
    color = ~ pal(era), 
    stroke = TRUE, fillOpacity = 0.5,
    popup = worldWonders,
    clusterOptions = markerClusterOptions()
  )

map


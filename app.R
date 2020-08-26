library(tidyverse)
library(osmdata)
library(sf)

getbb("palu")

streets <- getbb("palu")%>%
   opq()%>%
   add_osm_feature(key = "highway", 
                   value = c("motorway", "primary", 
                             "secondary", "tertiary")) %>%
   osmdata_sf()

small_streets <- getbb("palu")%>%
   opq()%>%
   add_osm_feature(key = "highway", 
                   value = c("residential", "living_street",
                             "unclassified",
                             "service", "footway")) %>%
   osmdata_sf()

river <- getbb("palu")%>%
   opq()%>%
   add_osm_feature(key = "waterway", value = "river") %>%
   osmdata_sf()

#membuat peta
ggplot() +
   geom_sf(data = streets$osm_lines, #jalan besar
           inherit.aes = FALSE,
           color = "red",
           size = 1,
           alpha = .8) +
   geom_sf(data = river$osm_lines, #jalan kecil
           inherit.aes = FALSE,
           color = "blue",
           size = .2,
           alpha = .5) +
   geom_sf(data = small_streets$osm_lines, #sungai
           inherit.aes = FALSE,
           color = "yellow",
           size = .2,
           alpha = .6) +
   coord_sf(xlim = c(119.707997, 120.0279974), #titik koordinat
            ylim = c(-1.055779, -0.7357793), #dari getbb("Palu")
            expand = FALSE) 

#Menambahkan Tema

ggplot() +
   geom_sf(data = streets$osm_lines,
           inherit.aes = FALSE,
           color = "red",
           size = 1,
           alpha = .8) +
   geom_sf(data = river$osm_lines,
           inherit.aes = FALSE,
           color = "blue",
           size = .2,
           alpha = .5) +
   geom_sf(data = small_streets$osm_lines,
           inherit.aes = FALSE,
           color = "yellow",
           size = .2,
           alpha = .6) +
   coord_sf(xlim = c(119.707997, 120.0279974), 
            ylim = c(-1.055779, -0.7357793),
            expand = FALSE) +
   theme_void() +
   theme(
     plot.background = element_rect(fill = "#282828")
   )

available_features() #melihat elemen
available_tags("highway") #melihat fitur di elemen highway

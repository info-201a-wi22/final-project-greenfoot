worlddata <- read_OWID_country_emission()

install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel", "ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))
install.packages(c("tidyverse", "maps", "mapproj", "patchwork"))
library("tidyverse")
library("maps")
library("mapproj")
library("patchwork")
library("dplyr")
library("ggplot2")
theme_set(theme_bw())
library("sf")

library("rnaturalearth")
library("rnaturalearthdata")


world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

ggplot(data = world) +
  geom_sf()

worlddata <- worlddata[worlddata$year == "2020",]
worlddata <- worlddata[, -c(5:58)]

country_shape <- map_data("world") %>%
  unite(polyname, region, subregion, sep = ",")%>%
  left_join(iso.alpha(country_shape, n=3), by="polyname")


View(country_shape)

# Author: Lauren Whightsil
# Date: 07/13/21
# Purpose: Daily Exercise 11: Projecting Data

library(tidyverse, dplyr, magrittr)
library(sf)
library(units)

twocities = read_csv("~/github/geog13-daily-exercises/data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs= 4326) %>%
  filter(city %in% c("Santa Barbara", "Rancho Cucamonga"))

twocities.wgs84 = st_distance(twocities)


# Equal Area projection:
twocities.5070 = st_distance(st_transform(twocities, 5070))

cities5070km = twocities.5070 %>% set_units("km") %>% drop_units()


# Equidistance projection:
twocities.eqds = st_distance(st_transform(twocities, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))


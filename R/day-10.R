# Author: Lauren Whightsil
# Date: 07/12/21
# Purpose: Daily Exercise 10: Feature Geometries

library(tidyverse, dplyr, magrittr, USAboundaries)
library(sf)

CONUS = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))

USboundary = st_union(CONUS) %>% st_cast("MULTILINESTRING")
ggplot() +
  geom_sf(data = USboundary)

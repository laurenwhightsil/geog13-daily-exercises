# Author: Lauren Whightsil
# Date: 07/14/21
# Purpose: Daily Exercise 12: Spatial Filtering

library(tidyverse, dplyr, magrittr)
library(sf, USAboundaries)

Texas = USAboundaries::us_states() %>%
  filter(state_name == "Texas")

Colorado = USAboundaries::us_states() %>%
  filter(state_name == "Colorado")

states = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))

touchColorado = st_filter(states, Colorado, .predicate = st_touches)

c1 <- ggplot() +
  geom_sf(data = states) +
  geom_sf(data = touchColorado, fill= 'red', alpha = .5) +
  geom_sf_label(data= touchColorado, aes(label = stusps), size = 3, alpha = 0, label.size = 0) +
  geom_sf(data = Colorado, fill= 'blue', alpha = .8) +
  geom_sf_label(data= Colorado, aes(label = stusps), size = 3, alpha = 0, label.size = 0) +
  labs(title = "All states touching Colorado", x = "long", y = "lat") +
  theme_minimal()

ggsave(c1, filename= "Day-12.png", path = "./img")

c1

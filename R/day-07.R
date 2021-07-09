# Author: Lauren Whightsil
# Date: 07/03/21
# Purpose: Daily Exercise 7: Faceted Plot of US COVID-19 Cases

library(tidyverse, magrittr)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv'
covid = read_csv(url)

## Question 1:
covid %>%
  region = data.frame(state = state.name, region = state.region) %>%
  filter(state %in% state.name) %>%
  filter(date == max(date)) %>%
  count(state) %>%
  left_join(covid, region, by = "state") %>%
    count(region) %>%
    mutate(tot = sum(n)) %>%
  group_by(region, date) %>%
  summarize(cases = sum(cases, na.rm = TRUE),deaths = sum(deaths, na.rm = TRUE)) %>%
  pivot_longer(cols = c('cases', 'deaths')) -> covid_region

covid %>%
  ggplot(covid_region, aes(x = date, y = value)) +
    geom_line(aes(col = region)) +
    facet_grid(name~region, scale = "free_y") +
    theme_linedraw() +
    theme(legend.position = "NA") +
    labs(title = "Cumulative Cases and Deaths: Region",
       subtitle = "Data Source: NY-Times COVID-19 Data",
       x = "Date", y = "Daily Cumulative Count",
       caption = "Daily Exercise 07")
  ggsave("exercise07image.png")

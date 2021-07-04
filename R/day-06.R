# Author: Lauren Whightsil
# Date: 07/01/21
# Purpose: Daily Exercise 6: COVID-19 ggplots

library(tidyverse, magrittr)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)

## Question 1:
covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state) -> most_case_states

covid %>%
  filter(state %in% most_case_states) %>%
  group_by(state, date) %>%
  summarise(cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases, color = state)) +
  geom_line(size = 2) +
  facet_wrap(~state) +
  ggthemes::theme_gdocs() +
  theme(legend.position = 'NA') +
  labs(title = "Cummulative Case Counts",
       subtitle = "Data Source: NY-Times",
       x = "Date", y = "Cases",
       caption = "Daily Exercise 06")
  ggsave("StateCummulativeCases.png")

## Question 2:

covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(fill = "orange", color = "orange", alpha = 0.25) +
  geom_line(color = "orange", size = 3) +
  ggthemes::theme_economist() +
  theme(legend.position = 'NA')
  labs(title = "National Cummulative Case Counts: COVID-19 Pandemic",
  x = "Date",
  y = "Cases", caption = "Daily Exercise 06")
  ggsave("NationalCummulativeCases.png")

# Author: Lauren Whightsil
# Date: 07/06/21
# Purpose: Daily Exercise 8: Daily New COVID-19 Cases in Texas

library(tidyverse, magrittr, zoo)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
state.of.interest = "Texas"

covid %>%
  filter(state == state.of.interest) %>%
  group_by(date) %>%
  summarise(cases = sum(cases)) %>%
  mutate(newCases = cases - lag(cases),roll7 = rollmean(newCases, 7, fill = NA, align = "right")) %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "orange") +
  geom_line(aes(y = roll7), col = "darkorange", size = 1) +
  ggthemes::theme_wsj() +
  labs(title = paste("Daily New COVID-19 Cases in", state.of.interest)) +
  theme(plot.background = element_rect(fill = "white"), panel.background = element_rect(fill = "white"), plot.title = element_text(size = 14, face = 'bold')) +
  theme(aspect.ratio = .6)

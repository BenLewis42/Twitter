require(tidyverse)

biases <- read.csv("~/GitHub/Twitter/data/corpus.tsv", sep = "\t")

fact_bias <- biases %>% 
  select(source_url, fact)

pol_bias <- biases %>% 
  select(source_url, bias)

summary(pol_bias)



ggplot(fact_bias) +
  geom_bar(aes(x = fact))


ggplot(pol_bias) +
  geom_bar(aes(x = bias))

require(rtweet)
require(tidyverse)
require(httpuv)


Sys.setenv(consumer_key = "DSzrOoBnDmuWIbihQ6RnKpZoG",
           consumer_secret = "bSrmCwdDI2rwWClLRJzwKsSrvVoRCnS9lvGMvRuWzESiVt1PO1",
           access_token = "1239299250476814336-cj9xfDHWtEL3FXiLnuCjH4C11FmQtW",
           access_token_secret = "U6fygEtwcmmn70fniIj3Iye9egsj6dG5v0rAZ4hgU7ftu",
           bearer_token = "AAAAAAAAAAAAAAAAAAAAADaYYAEAAAAAB22bcJU1xulU%2Buur%2BSKuhQ2JLA4%3DMIlhGPaOcHlWGIfaLlmm7s3TsLFs7H3iRFT1a9zbLMVTAM3Py1")


bearer_token <- Sys.getenv("bearer_token")
consumer_key <- Sys.getenv("consumer_key")
consumer_secret <- Sys.getenv("consumer_secret")
access_token <- Sys.getenv("access_token")
access_secret <- Sys.getenv("access_token_secret") 




token <- create_token(
  app = "BenLewisResearch",
  consumer_key = consumer_key,
  consumer_secret = consumer_secret,
  access_token = access_token,
  access_secret = access_secret)
#get_token()




twitter_search <- search_tweets("#CovidVaccine", n = 1000)


text_and_tags <- twitter_search %>%
  select(status_id, text, hashtags) 





anti_vax_tags <- c('plandemic', 'scamdemic', 'wakeup', 'bloodclots', 'cancer', 
                   'nomask', 'death', 'VaccineSideEffects', 'LeaveOurKidsAlone',
                   'HeartAttack', 'CrimesAgainstChildren')




tweets_antivax <- text_and_tags %>%
  mutate(anti_vax = ifelse(grepl(anti_vax_tags[1], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[2], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[3], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[4], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[5], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[6], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[7], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[8], hashtags, ignore.case = TRUE) |
                             grepl(anti_vax_tags[9], hashtags, ignore.case = TRUE), 
                           1, 0))

tweets_antivax %>% 
  summarize(mean(anti_vax))



# 
# 
# filter_age <- shear_age %>% 
#   mutate(format_date = as.Date(date, format= "%Y-%m-%d")) %>% 
#   mutate(format_created = as.Date(user_created, format= "%Y-%m-%d")) %>% 
#   mutate(acc_age = as.numeric(difftime(as.Date(format_date), as.Date(format_created), units = 'days'))) %>% 
#   select(acc_age, anti_vax)
# 
# 
# specify_decimal <- function(x, k) {
#   trimws(format(round(x, k), nsmall=k))
#   
# } 
# 
# 
# 
# 
# 
# 
# age_plot <- ggplot(filter_age, aes(y = acc_age, x = as.factor(anti_vax), color = as.factor(anti_vax))) +
#   geom_boxplot() + 
#   stat_summary(fun = "quantile",
#                geom = "text",
#                aes(label = trimws(format(round(as.numeric(sprintf("%1.1f", ..y..)), 0), nsmall = 0))),
#                position = position_nudge(x = 0.2, y = 125),
#                color = "black") +
#   scale_y_discrete(name = "Account Age (Days)", labels = NULL, expand = expansion(mult = c(0, 0.02))) +
#   scale_color_manual(name = "", values = c("black", "red"), labels = c("All #CovidVaccine Tweets", "Anti-vax Tweets")) + 
#   scale_x_discrete(name = NULL, labels = NULL)
# 
# age_plot
# 
# 
# conspiracy_data <- shear_age %>% 
#   mutate(conspiracy = ifelse(grepl(check_tag[1], hashtags, ignore.case = TRUE) | 
#                                grepl(check_tag[2], hashtags, ignore.case = TRUE) |
#                                grepl(check_tag[3], hashtags, ignore.case = TRUE) |
#                                grepl(check_tag[4], hashtags, ignore.case = TRUE) |
#                                grepl(check_tag[5], hashtags, ignore.case = TRUE), 1, 0))
# 
# cons_group <- conspiracy_data %>% 
#   group_by(anti_vax) %>% 
#   summarise(mean = mean(conspiracy))
# cons_group

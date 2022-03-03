require(tidyverse)
require(RCurl)
require(rtweet)
require(httr)




biases <- read.csv("~/GitHub/Twitter/data/corpus.tsv", sep = "\t")

fact_bias <- biases %>% 
  select(source_url, fact)

pol_bias <- biases %>% 
  select(source_url, bias)

# summary(pol_bias)



# ggplot(fact_bias) +
#   geom_bar(aes(x = fact))
# 
# 
# ggplot(pol_bias) +
#   geom_bar(aes(x = bias))
# 







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





twitter_search <- search_tweets("#CovidVaccine", n = 5000, lang = "en", include_rts = FALSE, include_entities = TRUE)


twitter_urls <- twitter_search %>% 
  mutate(urls = urls_expanded_url) %>% 
  select(status_id, urls)
  
twitter_urls <- twitter_urls[!is.na(twitter_urls$urls),]





flat_urls <- rtweet::flatten(twitter_urls)

flat_urls <- separate_rows(flat_urls, 2, sep = " ")


#myOpts <- curlOptions(connecttimeout = 10)


# expand_urls <- function(link) {
#   
#   expanded = ''
#   
#   expanded <- httr::GET(link, config = timeout(2))$url
#   
#   
#   return(expanded)
#  
# 
#     
#   
#   
# } 

# expanded_flat <- data.frame(matrix(nrow = 1))


# httr::timeout(2)
# curl::timeout(2)

#expanded_flat <- lapply(, expand_urls)
# 
# for (i in 1:length(flat_urls$urls[1:50])) {
#   
#   expanded = ''
#   expanded <- tryCatch(expand_urls(flat_urls$urls[i]), finally = flat_urls$urls[i])
#   expanded_flat[i] <- expanded
#   
# }

# 
# expand_urls(flat_urls$urls[24])
# 
# i = 21
# tryCatch(expand_urls(flat_urls$urls[i]), finally = flat_urls$urls[i])
# 
# 
# 



# 
# 
# 
# exp_url_df <- t(data.frame(expanded_urls)) %>% 
#   unname() %>% 
#   data.frame()
# 
# names(exp_url_df)[1] <- "urls"
# 
# 







bias_string_df <- data.frame(matrix(nrow = 1))

for (i in 1:nrow(fact_bias)) {
  string <- as.character(fact_bias$source_url[i])
  url_string <- str_extract(string, "\\w+\\.\\w+")
  bias_string_df[i, 1] <- url_string
  
}


# 
# url_string_df <- t(url_string_df)
# url_string_df <- data.frame(url_string_df)
# url_string_df <- unname(url_string_df)
# rownames(url_string_df) <- NULL
# 
# names(url_string_df)[1] <- "urls"



tweet_bias = data.frame(matrix(nrow = 1))

for (f in 1:length(flat_urls$urls)) {


  for (i in 1:nrow(bias_string_df)) {
    
    
    if(str_detect(flat_urls$urls[f], bias_string_df[i,1]) == TRUE) {
      
      tweet_bias[f] <- fact_bias$fact[i]
      #url_detected <- fact_bias$source_url[i]
      
      break
      
    } 
    
    tweet_bias[f] <- NA
    
  }

}


bias_df <- data.frame(tweet_bias[!is.na(tweet_bias)]) %>% 
  unname()
names(bias_df) <- 'bias'


#nrow(bias_string_df)



server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(bias_df) +
      geom_bar(aes(x = bias)) 
    
    
  })
}




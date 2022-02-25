require(tidyverse)
require(RCurl)
require(rtweet)


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




# from stack overflow 
decode.short.url <- function(u) {
  x <- try( getURL(u, header = TRUE, nobody = TRUE, followlocation = FALSE) )
  if(class(x) == 'try-error') {
    print(paste("***", u, "--> ERORR!!!!"))    
    return(u)
  } else {
    x <- strsplit(x, "Location: ")[[1]][2]
    x.2  <- strsplit(x, "\r")[[1]][1]
    if (is.na(x.2)){
      print(paste("***", u, "--> No change."))
      return(u)
    }else{
      print(paste("***", x.2, "--> resolved in -->", x.2))  
      return(x.2)
    }
  }
}

#decoded <- decode.short.url('http://tinyurl.com/adcd')







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





twitter_search <- search_tweets("#CovidVaccine", n = 1000, lang = "en", include_rts = FALSE, include_entities = TRUE)


twitter_urls <- twitter_search %>% 
  mutate(urls = urls_expanded_url) %>% 
  select(status_id, urls)
  

# extract base url from tweet
string <- as.character(twitter_urls$urls[24])
tweet_url <- str_extract(string, "\\w+\\.\\w+")



tweet_bias = ""

for (i in 1:nrow(fact_bias)) {
  
  bias_url <- fact_bias$source_url[i]
  
  if(str_detect(bias_url, tweet_url) == TRUE) {
    
    tweet_bias <- fact_bias$fact[i]
    url_detected <- fact_bias$source_url[i]
    
    break
    
  } 
  
}

print(paste0("Url detected: ", as.character(url_detected)))
print(paste0("Url bias: ", as.character(tweet_bias)))




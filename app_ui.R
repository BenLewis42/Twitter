library(shiny)
# 
# data <- read.csv('data/covidvaccine.csv')
# select_values = colnames(data)
# 



# sidebar_content <- sidebarPanel(
#   selectInput(
#     "y_var",
#     label = "Y Variable",
#     choices = select_values,
#     selected = "Speed"
#   )
# )
# main_content <- mainPanel(
#   #plotOutput("plot")
# )
# 



intro_panel <- tabPanel(
  "Vaccine Bias",
  
  titlePanel("Plot"),
  plotOutput("plot")

)

second_panel <- tabPanel(
  "[Tab Title]",
  titlePanel("[Page Title]"),
  
)





ui <- navbarPage(
  intro_panel
  #second_panel
)
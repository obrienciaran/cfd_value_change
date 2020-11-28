library(shiny)
library(shinyWidgets)

shinyUI(fluidPage(
  
  # Application title
  h4(id="big-heading", "How much money do I need to top up my CFD account by so my account isn't blasted into smithereens (assumes impending leverage change of 1:5 -> 1:2)"),
  tags$style(HTML("#big-heading{color: darkblue;}")),

   sidebarLayout(
    sidebarPanel(
      numericInput("account_value", "Input your current total account value", 200),
      numericInput("blocked_funds", "Input your current blocked funds amount", 100),
      tags$b("Current margin:"),
        h5(textOutput("current_margin")),
      #sliderInput("current_margin", "Input your current margin", 0, min = 25, max = 100,step = 1),
      sliderInput("target_margin", "Input the margin you want to end up at", 0, min = 25, max = 100, step = 0.1),
      selectInput("ops", "Select Operation (only one operation available for now)",
                  choices = c("How much do I need to top up by?")
                 )
                 ),
    mainPanel(
      h3("Result:"),
      h3(textOutput("oput")),
      
      tags$h6("DISCLAIMER: THIS CALCULATOR ONLY WORKS WITH CFD PORTFOLIOS THAT ONLY CONTAIN STOCKS. IF YOUR PORTFOLIO CONTAINS ANY OTHER TYPE OF INSTRUMENT (e.g. Commodities, Indexes or FOREX) THE RESULTS WILL BE INACCURATE SO THE CALCULATOR SHOULD NOT BE USED.
      IT IS YOUR RESPONSIBILITY TO CONFIRM THAT THE OUTPUT OF THIS CALCULATOR IS ACCURATE!",style="color:red")

    ),

  )))


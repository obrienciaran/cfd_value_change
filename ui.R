library(shiny)
library(shinyWidgets)

shinyUI(fluidPage(
  
  # Application title
  h4(id="big-heading", "How much money do I need to top up my CFD account by so my account isn't blasted into smithereens (assumes impending leverage change of 1:5 -> 1:2)"),
  tags$style(HTML("#big-heading{color: darkblue;}")),

   sidebarLayout(
    sidebarPanel(
      numericInput("account_value", "Input your ACCOUNT VALUE", 200),
      numericInput("blocked_funds", "Input your BLOCKED FUNDS", 100),
      h5(tags$b("FREE FUNDS:"),textOutput("free_funds", inline = TRUE)),
      h6("If the FREE FUNDS figures shown above don’t match Trading 212, please check your entries for ACCOUNT VALUE and BLOCKED FUNDS"),
      h5(tags$b("CURRENT MARGIN:"),textOutput("current_margin", inline = TRUE)),
      #h5(tags$b("Deposit needed to maintain current margin:"),textOutput("current_margin_funds_needed", inline = TRUE)),
      h5(tags$b("Margin after leverage change if no action taken:"),textOutput("revised_margin", inline = TRUE)),
      
      sliderInput("target_margin", "Input your target margin", 50, min = 25, max = 100),
      selectInput("ops", "Select Operation (only one operation available for now)",
                  choices = c("How much do I need to top up by to achieve target margin?")
                 )
                 ),
    mainPanel(
      h3("Result:"),
      h3(textOutput("oput")),
      
      tags$h6("DISCLAIMER: THIS CALCULATOR ONLY WORKS WITH CFD PORTFOLIOS THAT ONLY CONTAIN STOCKS. IF YOUR PORTFOLIO CONTAINS ANY OTHER TYPE OF INSTRUMENT (e.g. Commodities, Indexes or FOREX) THE RESULTS WILL BE INACCURATE SO THE CALCULATOR SHOULD NOT BE USED.
      IT IS YOUR RESPONSIBILITY TO CONFIRM THAT THE OUTPUT OF THIS CALCULATOR IS ACCURATE!",style="color:red")

    ),

  )))


library(shiny)

# current margin = [Total funds]/([Total funds] + [Blocked funds]) 
# current margin = 9000/(9000 + 1000) = 90%

# revised margin = [Total funds]/([Total funds]+[New Blocked funds]) 
# revised margin = 9000/(9000+2500) = 78.3%
# where [New Blocked funds] = 2.5 [Blocked funds]

shinyServer(function(input, output) {
  
  # three sets of calculations are below depending on three scenarios outlined below in the comments. The output 'oput' is set to bold via <b>
  output$oput <- renderText({
    
    # If the revised margin from T212 is greater than the users target margin, no need to add any funds to the account
    if ((input$account_value/(input$account_value+(input$blocked_funds*2.5)))*100 > input$target_margin)
      {
      switch(input$ops,
             "How much do I need to top up by to achieve target margin?" = 0)
      }
    # If target margin is greater than 50 and if the revised margin from T212 is less than the users target margin, the user must add funds
    else if((input$account_value/(input$account_value+(input$blocked_funds*2.5)))*100 && input$target_margin >= 50)
      {
      switch(input$ops,
             "How much do I need to top up by to achieve target margin?" = round(((2.5 * input$blocked_funds) / ((1 / (input$target_margin / 100)) - 1)) - input$account_value,digits =2)
             )
      }
    # If target margin is less than 50 and if the revised margin from T212 is less than the users target margin, the user must add funds
    else if((input$account_value/(input$account_value+(input$blocked_funds*2.5)))*100 < input$target_margin && input$target_margin<50)
      {
      switch(input$ops,
             "How much do I need to top up by to achieve target margin?" = round((input$target_margin*.05*input$blocked_funds) - input$account_value,digits = 2)
             )
      }
  })

  # Free funds
  #ab <- reactive({req(input$account_value) - req(input$blocked_funds)})
  #output$free_funds <- renderText({ab()})
  ab <- reactive({
    req(input$account_value,input$blocked_funds)
    if (input$account_value - input$blocked_funds< 0){
      freeFunds <- 0
    }else { 
      freeFunds <- input$account_value - input$blocked_funds
    }
})  
  output$free_funds <- renderText({ab()})
  
  # Current margin
  cm <- reactive({
    req(input$account_value,input$blocked_funds)
    if (input$account_value > input$blocked_funds){
      curmargin <- paste(round((input$account_value/(input$account_value + input$blocked_funds)*100), digits = 2),"%",sep="")
    }else { 
      curmargin <- paste(round(((.5*(input$account_value))/input$blocked_funds)*100, digits = 2),"%",sep="")
    }
  })
  output$current_margin <- renderText({cm()})

  # Revised margin
  rm <- reactive({
    req(input$account_value,input$blocked_funds)
    if (input$account_value > input$blocked_funds*2.5){
      rmargin <- paste(round((input$account_value/(input$account_value + input$blocked_funds*2.5))*100, digits = 2),"%",sep="")
    }else { 
      rmargin <- paste(round((.5*(input$account_value))/(input$blocked_funds*2.5)*100, digits = 2),"%",sep="")
    }
  })
  
  output$revised_margin <- renderText({rm()})

  })



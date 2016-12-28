library(shiny)

# Define server logic - mandatory function
shinyServer(function(input, output) {
  
  # Expression that generates the fuzzy output of flirtation level. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$flirtationLevel <- renderText({
    library(pracma)

    source('compute_membership_grade.R')
    source('generate_WM_rulebase_T1.R')
    source('rulebase_pruner.R')
    source('FLS_output_T1.R')
    
    num_input <- 2
    # input: {touching, eye contact} - between 0 and 10 each
    num_mf_array <- c(5, 5)
    std_dev_array <- c(0.3, 0.3)
    
    # output: between 0 and 10
    num_mf_output <- 5
    std_dev_output <- 0.3
    
    center_input_MF <- list(c(1.2, 3.2, 5.1, 7.3, 9.3),
                            c(1.1, 3, 4.9, 7.1, 9))
    
    center_output_MF <- c(1.1, 3, 4.9, 7.1, 9.1)
    
    # these rules are determined in American context at Uiversity of southern california
    consolidated_rulebase <- rbind(c(1, 1, 1), c(1, 2, 1), c(1, 3, 1), c(1, 4, 1), c(1, 5, 2),
                                   c(2, 1, 1), c(2, 2, 1), c(2, 3, 2), c(2, 4, 2), c(2, 5, 3),
                                   c(3, 1, 2), c(3, 2, 2), c(3, 3, 3), c(3, 4, 3), c(3, 5, 4),
                                   c(4, 1, 3), c(4, 2, 3), c(4, 3, 4), c(4, 4, 4), c(4, 5, 5),
                                   c(5, 1, 3), c(5, 2, 4), c(5, 3, 4), c(5, 4, 5), c(5, 5, 5))
    
    
    new_input <- c(input$touch, input$eyeContact)
    
    # setting the weight of each rule in the consolidated rulebase
    weight_matrix <- ones(nrow(consolidated_rulebase),1)
    
    # apply the FLS on test set inputs, using a loop. Pass each row of new input
    # matrix in a single iteration 
    flirtation_result <- NULL
#     for (i in 1:nrow(new_input)){
      flirtation_result <- FLS_output_T1(new_input, consolidated_rulebase, center_input_MF, 
                                   center_output_MF, num_input, std_dev_array, weight_matrix) 
#     }
    
    
    
    

    # check the maximum membersbip of defuzzified output to provide a fuzzy answer
    mf_grade_result <- NULL
    for (i in 1:length(center_output_MF)){
      mf_grade_result[i] <- compute_membership_grade(flirtation_result, 
                                                     center_output_MF[i],
                                                     std_dev_output)
    }
    
    position_max_mf_grade_result <- which.max(mf_grade_result)
    
    if (position_max_mf_grade_result == 1){
      fuzzy_answer <- "Not at all flirty"
    } else if (position_max_mf_grade_result == 2){
      fuzzy_answer <- "Hardly flirty"
    } else if (position_max_mf_grade_result == 3){
      fuzzy_answer <- "A bit flirty"
    } else if (position_max_mf_grade_result == 4){
      fuzzy_answer <- "Pretty good amount of flirt"
    } else if (position_max_mf_grade_result == 5){
      fuzzy_answer <- "OMG! A lot of flirt here"
    } else {fuzzy_answer <- "Out of my range"}


    paste(fuzzy_answer, ", with an exact score of ", flirtation_result, " on the scale of 0 to 10.")


  })
})
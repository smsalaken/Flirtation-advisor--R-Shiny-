library(shiny)

# Define UI for application - should be present always
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Was that a flirty move!!"),
 
  
  # Sidebar with a slider input for the number of flirting indicators
  sidebarLayout( position = "right", # always takes output of "sidebarPanel" and "mainPanel" as input
    sidebarPanel(
      sliderInput("touch",
                  "Amount of touch:",
                  min = 1,
                  max = 10,
                  value = 4,
                  step= 0.1),
      
      sliderInput("eyeContact",
                  "Amount of eye contact:",
                  min = 1,
                  max = 10,
                  value = 5,
                  step= 0.1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      HTML("<hr>"),
      div(
      img(src="flirt_withpermissionforreuse.jpg", height = "25%", width = "70%"), style="margin-left:18%"
      ),
      #p("Most people will think it is:  "),
      #h3(code(textOutput("flirtationLevel"))),
      br(),
      strong("Based on your selection on the right, the described behavior is most likely to be:"),
      
      
      HTML("<hr>"),
      h3(code(textOutput("flirtationLevel"))),
      HTML("<hr>"),
      br(),
      strong("About the application:"),
      p("This is a flirtation adivsor. If you are trying to determine whether or not  someone
        is flirting with you, select (on the right) the level of touch and eye contact you think they 
        are making with you. These are top two identifier of flirt according to a survey in 
         USC, USA [1]. 
         The system will display a level of flirt that most people will agree exists 
        in that particular behavior in a North American setting. 
        The consensus is likely to be different in other geophacic and demographic settings."),
      
      
      
        
     
      p("This result is determined by a type-1 fuzzy logic system. The rulebase is constructed 
        by a survey in University of Southern California, USA. This implentaion follows 
        the article in  [1]-[2]."),
      
      
      
      
      br(),
      em("[1] Martin, Matthew A., and Jerry M. Mendel. \"Flirtation, a very fuzzy prospect: a flirtation advisor.\"
         Journal of Popular Cult., XI (1) (1995): 1-41."),
      br(),
      em( "[2] Wang, L-X., and Jerry M. Mendel. \"Generating fuzzy rules by 
             learning from examples.\" Systems, Man and Cybernetics, IEEE Transactions
             on 22.6 (1992): 1414-1427."),
      br(),
      em("[3] Image taken from https://pixabay.com/p-218849 which has permission for reuse"),
      br(),
      br(),
      p("coded in R 3.1.2 -- \"Pumpkin Helmet\" by Syed M. Salaken"),
      p("Contact: salaken[dot]buet[dot]eee@gmail.com"),
      HTML("<hr>"),
      p("Don\'t expect a nice outlook. I\'m not a designer, yet.")
      #img(src="cisr-logo.jpg", height = 45, width = 200),
      #img(src="Deakin_Worldly_Logo.png", height = 100, width = 100)
    )
  )
))
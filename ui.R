shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Quickly Word Prediction App"),
        sidebarPanel(
            textInput("bigram", "Type a phrase (> 1 word):", ""),
            submitButton('Submit')
        ),
        mainPanel(
            h3('Results of prediction'),
            h4('You entered'),
            verbatimTextOutput("inputValue"),
            h4('Which resulted in a prediction of '),
            verbatimTextOutput("prediction")
        )
    )
)
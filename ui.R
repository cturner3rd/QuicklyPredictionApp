shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Word prediction"),
        sidebarPanel(
            textInput("bigram", "Type two words:", ""),
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
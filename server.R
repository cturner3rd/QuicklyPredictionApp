library(shiny)
library(ngram)
library(tau)
library(NLP)
library(tm)
library(stringr)

txt<-readRDS("data/blogtxt.rds")
blogtxt = scan(text = txt, what="", quote=NULL, blank.lines.skip = TRUE)#######

##blog single letter
blogtxt<-gsub("[^[:alnum:][:space:]\']", " ", blogtxt) #remove all punctuation except "'"
blogtxt<-gsub("â ", "\'", blogtxt)
blogtxt<-gsub("\\' ", "\\'", blogtxt)
blogtxt<-gsub(" [b-hj-z] "," ", blogtxt) #remove single letters except a,i
blogtxt<-preprocess(blogtxt)
blogtxt<-preprocess(blogtxt, case="lower", split.at.punct=FALSE)
blogcounts = as.data.frame(xtabs(~blogtxt))
blog.str = paste(blogtxt, collapse=" ")

blog.counts = textcnt(blog.str, n=1, method="string", tolower=T) #1-gram
blog.counts.df = data.frame(word = names(blog.counts), count = c(blog.counts))
#head(blog.counts.df[order(blog.counts.df$count, decreasing = T),], 10)
#sum(blog.counts.df$count) #word count

##blog 2gram
blog.corpus = Corpus(VectorSource(blog.str))
blog.corpus = tm_map(blog.corpus, tolower) 
cleaned.blog.str = as.character(blog.corpus)[1]
blog.words = strsplit(cleaned.blog.str, " ", fixed = T)[[1]]

blog.bigrams = vapply(ngrams(blog.words, 2), paste, "", collapse = " ")
blog.bigram.counts = as.data.frame(xtabs(~blog.bigrams))
blog.bigrams.y <- blog.bigram.counts[order(blog.bigram.counts$Freq, decreasing = T),]

##blog 3gram
blog.trigrams = vapply(ngrams(blog.words, 3), paste, "", collapse = " ")
blog.trigram.counts = as.data.frame(xtabs(~blog.trigrams))
blog.trigrams.y <- blog.trigram.counts[order(blog.trigram.counts$Freq, decreasing = T),]

#Prediction function
getTrigram <- function(matches, userinp) {
    for(i in 1:length(matches$blog.trigrams)){
        if (word(matches$blog.trigrams[i],1) == word(userinp, 1)){
            #print(matches$blog.trigrams[i])
            return(word(matches$blog.trigrams[i], 3))
            break
        }
    } 
}
getBigram <- function(matches, userinp) {
    for(i in 1:length(matches$blog.bigrams)){
        if (word(matches$blog.bigrams[i],1) == word(userinp, 2)){
            #print(matches$blog.bigrams[i])
            return(word(matches$blog.bigrams[i], 2))
            break
        }
    } 
}
getPrediction <- function(userinp) {
    matches<-blog.trigrams.y[grep(userinp, blog.trigrams.y$blog.trigrams), ]
    if (dim(matches)[1]>0){
        getTrigram(matches, userinp)
    } else {
        matches<-blog.bigrams.y[grep(word(userinp, 2), blog.bigrams.y$blog.bigrams), ]
        if (dim(matches)[1]>0){
            getBigram(matches, userinp)
        } else {
            return("no prediction")
        }
    }
}
shinyServer(
        function(input, output) {
        output$inputValue <- renderPrint(input$bigram)
        #output$prediction <- renderPrint({myprediction(input$bigram)})
        output$prediction <- renderPrint({getPrediction(input$bigram)})
    }
)

The Quickly Word Prediction App for Typed Text on Mobile Devices
========================================================
author: Carl W. Turner
date: 4/23/2016

Capstone Project, Data Science Specialization  
Johns Hopkins University via Coursera

Effectively Predicting Text Entry Improves Usability of Mobile Devices
========================================================

- Presenting mobile users with predictions of text can significantly improve the usability of entering text on small keyboards.
- However, if the algorithm to present the text runs slowly, users will type past the predicted input, yielding no benefits. 
- An effective algorithm must balance speed and accuracy in order to be useful.

This project presents a simplified algorithm for quickly predicting the likely next word in a typed phrase and presenting it to a user for confirmation. 

The Quickly Corpora Database
========================================================
A database corpus was created from a sample of the en_US.blog.txt file using the tm function. 
- Twitter was found to be too ideosyncratic with regards to spelling, and news stories were found have an overly-formal grammatical style
- Special characters were removed and capitals changed to lower case during preprocessing
- Finally, trigrams and bigrams and their frequencies were calculated using the ngram function

Prediction Algorithm: How it Works
========================================================

- The prediction algorithm searches for the most-likely trigram based on the last 2 words in the phrase
- If a likely trigram is not found, it backs off to search for a likely bigram that includes last word
- It is possible to get "no prediction" if no words in the phrase are found, e.g., "sdfe gsdfe" will not return a prediction

Shiny: The [Quickly Prediction app](http://cturner3rd.shinyapps.io/shiny/)
- Note: it takes about 1 minute for the database to load and for the app to accept input. After that, the app will calculate a prediction word very quickly upon pressing Submit.

Final Comments
========================================================

- An improved version of this app would generate predictions constantly, replacing the need to enter Submit. 
- Personalization could be implemented by saving a record of everything the user enters as they interact with their mobile device and adding it to the database. 
- The improved app would include tagging parts of speech and using grammar as part of an improved, faster prediction algorithm

Github: [Github repo](http://github.com/cturner3rd/QuicklyPredictionApp) for all code.

Rpubs: [Rpubs report](http://rpubs.com/cturner3rd/174408) with documentation and report.

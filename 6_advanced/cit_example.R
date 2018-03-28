## example for CTI data

# read the tab-delimited file
tsvdf <- read.delim("~/Downloads/cti_sample.tsv", stringsAsFactors = FALSE)

# create a categorical sentiment variable
sentiment_cat <- factor(rep("neutral", length(tsvdf$obj_sentiment)),
                        levels = c("neg", "neutral", "pos"))
sentiment_cat[tsvdf$obj_sentiment < 0] <- "neg"
sentiment_cat[tsvdf$obj_sentiment > 0] <- "pos"
table(sentiment_cat)

# make a corpus from the data
sentcorpus <- corpus(tsvdf, text_field = "segment")
# add the sentiment category document variable
docvars(sentcorpus, "sentiment_cat") <- sentiment_cat

## try a dictionary method
liwcdict <- dictionary(file = "~/Dropbox/QUANTESS/dictionaries/LIWC/LIWC2001_German_UTF8.dic")
sentdfm_liwc <- dfm_lookup(sentdfm, dictionary = liwcdict)
dictionary_sentiment <- 
    log((sentdfm_liwc[, "Posemo"] + .5) / (sentdfm_liwc[, "Negemo"] + .5))
plot(as.vector(dictionary_sentiment) ~ docvars(sentdfm, "sentiment_cat"))

## try Naive Bayes
sentdfm2 <- dfm(corpus_subset(sentcorpus, sentiment_cat != "neutral"))
nb_fitted2 <- textmodel_NB(x = sentdfm2, y = docvars(sentdfm2, "sentiment_cat"), 
                           prior = "docfreq")
nb_pred2 <- predict(nb_fitted2)
table(nb_pred2$nb.predicted, docvars(sentdfm2, "sentiment_cat"))

# predict on the neutral cases
sentdfm_neutr <- dfm(corpus_subset(sentcorpus, sentiment_cat == "neutral"))
# make feature space equivalent
sentdfm_neutr <- dfm_select(sentdfm_neutr, sentdfm2)
# predict neutral from training data
predict(nb_fitted2, newdata = sentdfm_neutr)
















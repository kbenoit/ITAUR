## Demonstration of quanteda's capabilities
##
## Ken Benoit <kbenoit@lse.ac.uk>
## Paul Nulty <p.nulty@lse.ac.uk>

require(quanteda)

help(package="quanteda")

## create a corpus from a text vector of UK immigration texts
summary(data_char_ukimmig2010)
str(data_char_ukimmig2010)

# create a corpus from immigration texts
immigCorpus <- corpus(data_char_ukimmig2010, 
                      metacorpus = list(notes = "Created as part of a demo."))
docvars(immigCorpus) <- data.frame(party = names(data_char_ukimmig2010), 
                                   year = 2010)
summary(immigCorpus)

# explore using kwic
kwic(immigCorpus, "deport", window = 3)
kwic(immigCorpus, "illegal immig*", window = 3)

# extract a document-feature matrix
immigDfm <- dfm(corpus_subset(immigCorpus, party == "BNP"))
textplot_wordcloud(immigDfm)
immigDfm <- dfm(corpus_subset(immigCorpus, party == "BNP"), 
                remove = stopwords("english"))
textplot_wordcloud(immigDfm, 
                   random.color = TRUE, rot.per = .25, 
                   colors = sample(colors()[2:128], 5))

# change units to sentences
immigCorpusSent <- corpus_reshape(immigCorpus, to = "sentences")
summary(immigCorpusSent, 20)


## tokenize some texts
txt <- "#TextAnalysis is MY <3 4U @myhandle gr8 #stuff :-)"
tokens(txt, remove_punct = TRUE)
tokens(txt, remove_punct = TRUE, remove_twitter = FALSE)
tokens(txt, remove_punct = TRUE, remove_twitter = TRUE)
(toks <- tokens(char_tolower(txt), remove_punct = TRUE, 
                remove_twitter = TRUE))

# tokenize sentences
(sents <- tokens(data_char_ukimmig2010[3], what = "sentence"))
# tokenize characters
tokens(data_char_ukimmig2010[5], what = "character")[[1]][1:100]


## some descriptive statistics

## create a document-feature matrix from the inaugural corpus
summary(data_corpus_inaugural)
presDfm <- dfm(data_corpus_inaugural)
head(presDfm)
docnames(presDfm)
# concatenate by president name                 
presDfm <- dfm(data_corpus_inaugural, groups = "President", verbose = TRUE)
presDfm
docnames(presDfm)

# need first to install quantedaData, using
# devtools::install_github("kbenoit/quantedaData")
## show some selection capabilities on Irish budget corpus
data(data_corpus_irishbudgets, package = "quantedaData")
summary(data_corpus_irishbudgets, 10)
ieFinMin <- corpus_subset(data_corpus_irishbudgets, number=="01" & debate == "BUDGET")
summary(ieFinMin)
dfmFM <- dfm(ieFinMin)
plot(2008:2012, textstat_lexdiv(dfmFM, "C"), xlab="Year", ylab="Herndan's C", type="b",
     main = "World's Crudest Lexical Diversity Plot")


# plot some readability statistics
data(data_corpus_SOTU, package = "sophistication")
stat <- textstat_readability(data_corpus_SOTU, "Flesch.Kincaid")
year <- lubridate::year(docvars(data_corpus_SOTU, "Date"))

require(ggplot2)
partyColours <- c("blue", "blue", "black", "black", "red", "red")
p <- ggplot(data = docvars(data_corpus_SOTU),
            aes(x = year, y = stat)) + #, group = delivery)) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_line(colour = "black")) +
    geom_smooth(alpha=0.2, linetype=1, color="grey70", method = "loess", span = .34) +
    xlab("") +
    ylab("Flesch-Kincaid Readability") +
    geom_point(aes(colour = party)) +
    scale_colour_manual(values = partyColours) +
    geom_line(aes(), alpha=0.3, size = 1) +
    # ggtitle("Text Complexity in State of the Union Addresses") +
    theme(plot.title = element_text(lineheight=.8, face="bold"))
print(p)

## Presidential Inaugural Address Corpus
presDfm <- dfm(data_corpus_inaugural, remove = stopwords("english"))
# compute some document similarities
as.list(textstat_simil(presDfm, "1985-Reagan", margin = "documents"))

textstat_simil(presDfm, c("2009-Obama" , "2013-Obama"), method = "cosine")
textstat_simil(presDfm, c("2009-Obama" , "2013-Obama"), method = "eJaccard")

# compute some term similarities
featsim <- textstat_simil(presDfm, c("fair", "health", "terror"), margin = "features", 
                          method = "cosine")
lapply(as.list(featsim), head)

## mining collocations

# form ngrams
txt <- "Hey @kenbenoit #textasdata: The quick, brown fox jumped over the lazy dog!"
(toks1 <- tokens(char_tolower(txt), remove_punct = TRUE))
tokens(char_tolower(txt), remove_punct = TRUE, ngrams = 2)
tokens(char_tolower(txt), remove_punct = TRUE, ngrams = c(1,3))

# low-level options exist too
tokens_ngrams(toks1, c(1, 3, 5))

# form "skip-grams"
toks <- tokens("insurgents killed in ongoing fighting")
tokens_skipgrams(toks, n = 2, skip = 0:1, concatenator = " ") 
tokens_skipgrams(toks, n = 2, skip = 0:2, concatenator = " ") 
tokens_skipgrams(toks, n = 3, skip = 0:2, concatenator = " ") 

# mine bigrams
require(magrittr)
collocs2 <- tokens(data_corpus_inaugural) %>%
    tokens_remove(stopwords("english"), padding = TRUE) %>%
    tokens_remove("\\p{P}", valuetype = "regex", padding = TRUE) %>%
    textstat_collocations(max_size = 2, method = "lr")
head(collocs2, 20)

# mine trigrams
collocs3 <- tokens(data_corpus_inaugural) %>%
    tokens_remove(stopwords("english"), padding = TRUE) %>%
    tokens_remove("\\p{P}", valuetype = "regex", padding = TRUE) %>%
    textstat_collocations(max_size = 3, method = "bj")
head(collocs3, 20)




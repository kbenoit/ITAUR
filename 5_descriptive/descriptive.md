Descriptive Analysis of Texts
=============================

### Kenneth Benoit

### 24 April 2017

quateda has a number of descriptive statistics available for reporting on texts. The **simplest of these** is through the `summary()` method:

``` r
require(quanteda)
## Loading required package: quanteda
## quanteda version 0.9.9.50
## Using 7 of 8 cores for parallel computing
## 
## Attaching package: 'quanteda'
## The following object is masked from 'package:utils':
## 
##     View
txt <- c(sent1 = "This is an example of the summary method for character objects.",
         sent2 = "The cat in the hat swung the bat.")
summary(txt)
##    Text Types Tokens Sentences
## 1 sent1    12     12         1
## 2 sent2     8      9         1
```

This also works for corpus objects:

``` r
summary(corpus(data_char_ukimmig2010, notes = "Created as a demo."))
## Warning in corpus.character(data_char_ukimmig2010, notes = "Created as a
## demo."): Argument notes not used.
## Corpus consisting of 9 documents.
## 
##          Text Types Tokens Sentences
##           BNP  1126   3330        88
##     Coalition   144    268         4
##  Conservative   252    503        15
##        Greens   325    687        21
##        Labour   296    703        29
##        LibDem   257    499        14
##            PC    80    118         5
##           SNP    90    136         4
##          UKIP   346    739        27
## 
## Source:  /Users/kbenoit/GitHub/ITAUR/5_descriptive/* on x86_64 by kbenoit
## Created: Mon Apr 24 08:17:47 2017
## Notes:
```

To access the **syllables** of a text, we use `syllables()`:

``` r
nsyllable(c("Superman.", "supercalifragilisticexpialidocious", "The cat in the hat."))
## [1]  3 13  5
```

We can even compute the **Scabble value** of English words, using `scrabble()`:

``` r
nscrabble(c("cat", "quixotry", "zoo"))
## [1]  5 27 12
```

We can analyze the **lexical diversity** of texts, using `lexdiv()` on a dfm:

``` r
myDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980))
textstat_lexdiv(myDfm, "R")
##  1981-Reagan  1985-Reagan    1989-Bush 1993-Clinton 1997-Clinton 
##     61.23322     59.78702     62.53175     75.57121     65.42433 
##    2001-Bush    2005-Bush   2009-Obama   2013-Obama   2017-Trump 
##     76.13278     67.17373     62.00250     67.02974     79.45028
dotchart(sort(textstat_lexdiv(myDfm, "R")))
```

![](descriptive_files/figure-markdown_github/unnamed-chunk-6-1.png)

We can analyze the **readability** of texts, using `readability()` on a vector of texts or a corpus:

``` r
readab <- textstat_readability(corpus_subset(data_corpus_inaugural, Year > 1980), 
                               measure = "Flesch.Kincaid")
dotchart(sort(readab))
```

![](descriptive_files/figure-markdown_github/unnamed-chunk-7-1.png)

We can **identify documents and terms that are similar to one another**, using `similarity()`:

``` r
## Presidential Inaugural Address Corpus
presDfm <- dfm(data_corpus_inaugural, remove = stopwords("english"))
# compute some document similarities
textstat_simil(presDfm, "1985-Reagan", n = 5, margin = "documents")
##                 1985-Reagan
## 1985-Reagan       1.0000000
## 1789-Washington   0.8600495
## 1793-Washington   0.5955303
## 1797-Adams        0.8468456
## 1801-Jefferson    0.8928164
textstat_simil(presDfm, c("2009-Obama", "2013-Obama"), n = 5, margin = "documents", method = "cosine")
##                 2009-Obama 2013-Obama
## 2009-Obama       1.0000000  0.9471694
## 2013-Obama       0.9471694  1.0000000
## 1789-Washington  0.8084783  0.8167533
## 1793-Washington  0.5698686  0.5863695
## 1797-Adams       0.7708500  0.7748261
textstat_dist(presDfm, c("2009-Obama", "2013-Obama"), n = 5, margin = "documents", method = "canberra")
##                 2009-Obama 2013-Obama
## 2009-Obama           0.000   7527.722
## 2013-Obama        7527.722      0.000
## 1789-Washington   8368.735   8465.746
## 1793-Washington   8931.343   8938.622
## 1797-Adams        8336.272   8353.647
textstat_dist(presDfm, c("2009-Obama", "2013-Obama"), n = 5, margin = "documents", method = "eJaccard")
##                 2009-Obama 2013-Obama
## 2009-Obama      1.00000000 0.84057792
## 2013-Obama      0.84057792 1.00000000
## 1789-Washington 0.41079560 0.53248550
## 1793-Washington 0.03250327 0.04426369
## 1797-Adams      0.62309228 0.57117783

# compute some term similarities
as.list(textstat_simil(presDfm, c("fair", "health", "terror"), margin = "features", method = "cosine", n = 8))
## $fair
##  citizens    fellow         -    senate     house    health    terror 
## 0.6823483 0.6192089 0.4737572 0.4357159 0.2819419 0.2573251 0.1470429 
## 
## $health
##  citizens         -    senate    fellow      fair     house    terror 
## 0.4708214 0.4260064 0.3210121 0.3016041 0.2573251 0.2300895 0.2000000 
## 
## $terror
##          -     fellow     health   citizens      house       fair 
## 0.44927569 0.30729473 0.20000000 0.19645785 0.15339300 0.14704292 
##     senate 
## 0.04938648
```

And this can be used for **clustering documents**:

``` r
data(data_corpus_SOTU, package="quantedaData")
presDfm <- dfm(subset(data_corpus_SOTU, lubridate::year(Date)>1990), stem = TRUE,
               remove = stopwords("english"))
## Warning: 'subset.corpus' is deprecated.
## Use 'corpus_subset' instead.
## See help("Deprecated")
presDfm <- dfm_trim(presDfm, min_count = 5, min_docfreq = 3)
# hierarchical clustering - get distances on normalized dfm
presDistMat <- dist(as.matrix(dfm_weight(presDfm, "relFreq")))
# hiarchical clustering the distance object
presCluster <- hclust(presDistMat)
# label with document names
presCluster$labels <- docnames(presDfm)
# plot as a dendrogram
plot(presCluster)
```

![](descriptive_files/figure-markdown_github/unnamed-chunk-9-1.png)

Or we could look at **term clustering** instead:

``` r
# word dendrogram with tf-idf weighting
wordDfm <- sort(dfm_weight(presDfm, "tfidf"))
## Warning: 'sort.dfm' is deprecated.
## Use 'dfm_sort' instead.
## See help("Deprecated")
wordDfm <- t(wordDfm)[1:100,]  # because transposed
wordDistMat <- dist(wordDfm)
wordCluster <- hclust(wordDistMat)
plot(wordCluster, xlab="", main="tf-idf Frequency weighting")
```

![](descriptive_files/figure-markdown_github/unnamed-chunk-10-1.png)

Finally, there are number of helper functions to extract information from quanteda objects:

``` r
myCorpus <- corpus_subset(data_corpus_inaugural, Year > 1980)

# return the number of documents
ndoc(myCorpus)           
```

    ## [1] 10

``` r
ndoc(dfm(myCorpus, verbose = FALSE))
```

    ## [1] 10

``` r
# how many tokens (total words)
ntoken(myCorpus)
```

    ##  1981-Reagan  1985-Reagan    1989-Bush 1993-Clinton 1997-Clinton 
    ##         2798         2935         2683         1837         2451 
    ##    2001-Bush    2005-Bush   2009-Obama   2013-Obama   2017-Trump 
    ##         1810         2325         2729         2335         1662

``` r
ntoken("How many words in this sentence?")
```

    ## [1] 7

``` r
# arguments to tokenize can be passed 
ntoken("How many words in this sentence?", remove_punct = TRUE)
```

    ## [1] 6

``` r
# how many types (unique words)
ntype(myCorpus)
```

    ##  1981-Reagan  1985-Reagan    1989-Bush 1993-Clinton 1997-Clinton 
    ##          904          925          795          644          773 
    ##    2001-Bush    2005-Bush   2009-Obama   2013-Obama   2017-Trump 
    ##          622          772          939          814          582

``` r
ntype("Yada yada yada.  (TADA.)")
```

    ## [1] 6

``` r
ntype("Yada yada yada.  (TADA.)", remove_punct = TRUE)
```

    ## [1] 3

``` r
ntype(char_tolower("Yada yada yada.  (TADA.)"), remove_punct = TRUE)
```

    ## [1] 2

``` r
# can count documents and features
ndoc(data_corpus_inaugural)
```

    ## [1] 58

``` r
myDfm1 <- dfm(data_corpus_inaugural)
ndoc(myDfm1)
```

    ## [1] 58

``` r
nfeature(myDfm1)
```

    ## [1] 9232

``` r
myDfm2 <- dfm(data_corpus_inaugural, remove = stopwords("english"), stem = TRUE)
nfeature(myDfm2)
```

    ## [1] 5289

``` r
# can extract feature labels and document names
head(featnames(myDfm1), 20)
```

    ##  [1] "fellow"          "-"               "citizens"       
    ##  [4] "of"              "the"             "senate"         
    ##  [7] "and"             "house"           "representatives"
    ## [10] ":"               "among"           "vicissitudes"   
    ## [13] "incident"        "to"              "life"           
    ## [16] "no"              "event"           "could"          
    ## [19] "have"            "filled"

``` r
head(docnames(myDfm1))
```

    ## [1] "1789-Washington" "1793-Washington" "1797-Adams"      "1801-Jefferson" 
    ## [5] "1805-Jefferson"  "1809-Madison"

``` r
# and topfeatures
topfeatures(myDfm1)
```

    ##   the    of     ,   and     .    to    in     a   our  that 
    ## 10082  7103  7026  5310  4945  4534  2785  2246  2181  1789

``` r
topfeatures(myDfm2) # without stopwords
```

    ##      ,      .      -   will govern nation  peopl      ;     us    can 
    ##   7026   4945   1042    931    687    677    623    565    478    471

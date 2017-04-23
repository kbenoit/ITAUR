Getting texts into R
====================

### Kenneth Benoit

### 23 April 2017

In this section we will show how to load texts from different sources and create a `corpus` object in **quanteda**.

Creating a `corpus` object
--------------------------

**quanteda can construct a `corpus` object** from several input sources:

### a character vector object

``` r
require(quanteda, warn.conflicts = FALSE, quietly = TRUE)
## quanteda version 0.9.9.50
## Using 7 of 8 cores for parallel computing
myCorpus <- corpus(data_char_ukimmig2010, notes = "My first corpus")
## Warning in corpus.character(data_char_ukimmig2010, notes = "My first
## corpus"): Argument notes not used.
summary(myCorpus)
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
## Source:  /Users/kbenoit/GitHub/ITAUR/3_file_import/* on x86_64 by kbenoit
## Created: Sun Apr 23 23:24:09 2017
## Notes:
```

### a `VCorpus` object from the **tm** package, and

``` r
data(crude, package = "tm")
myTmCorpus <- corpus(crude)
summary(myTmCorpus, 5)
## Corpus consisting of 20 documents, showing 5 documents.
## 
##            Text Types Tokens Sentences                     author
##  reut-00001.xml    62    103         5                       <NA>
##  reut-00002.xml   240    497        19 BY TED D'AFFLISIO, Reuters
##  reut-00004.xml    47     62         4                       <NA>
##  reut-00005.xml    55     74         5                       <NA>
##  reut-00006.xml    67     97         4                       <NA>
##        datetimestamp description
##  1987-02-26 17:00:56            
##  1987-02-26 17:34:11            
##  1987-02-26 18:18:00            
##  1987-02-26 18:21:01            
##  1987-02-26 19:00:57            
##                                          heading  id language
##         DIAMOND SHAMROCK (DIA) CUTS CRUDE PRICES 127       en
##  OPEC MAY HAVE TO MEET TO FIRM PRICES - ANALYSTS 144       en
##        TEXACO CANADA <TXC> LOWERS CRUDE POSTINGS 191       en
##        MARATHON PETROLEUM REDUCES CRUDE POSTINGS 194       en
##        HOUSTON OIL <HO> RESERVES STUDY COMPLETED 211       en
##             origin topics lewissplit     cgisplit oldid places people orgs
##  Reuters-21578 XML    YES      TRAIN TRAINING-SET  5670    usa   <NA> <NA>
##  Reuters-21578 XML    YES      TRAIN TRAINING-SET  5687    usa   <NA> opec
##  Reuters-21578 XML    YES      TRAIN TRAINING-SET  5734 canada   <NA> <NA>
##  Reuters-21578 XML    YES      TRAIN TRAINING-SET  5737    usa   <NA> <NA>
##  Reuters-21578 XML    YES      TRAIN TRAINING-SET  5754    usa   <NA> <NA>
##  exchanges
##       <NA>
##       <NA>
##       <NA>
##       <NA>
##       <NA>
## 
## Source:  Converted from tm VCorpus 'crude'
## Created: Sun Apr 23 23:24:09 2017
## Notes:
```

### Texts read by the **readtext** package

The **quanteda** package works nicely with a companion package we have written named, descriptively, [**readtext**](https://github.com/kbenoit/readtext). **readtext** is a one-function package that does exactly what it says on the tin: It reads files containing text, along with any associated document-level metadata, which we call "docvars", for document variables. Plain text files do not have docvars, but other forms such as .csv, .tab, .xml, and .json files usually do.

**readtext** accepts filemasks, so that you can specify a pattern to load multiple texts, and these texts can even be of multiple types. **readtext** is smart enough to process them correctly, returning a data.frame with a primary field "text" containing a character vector of the texts, and additional columns of the data.frame as found in the document variables from the source files.

As encoding can also be a challenging issue for those reading in texts, we include functions for diagnosing encodings on a file-by-file basis, and allow you to specify vectorized input encodings to read in file types with individually set (and different) encodings. (All ecnoding functions are handled by the **stringi** package.)

To install **readtext**, you will need to use the **devtools** package, and then issue this command:

``` r
# devtools packaged required to install readtext from Github 
devtools::install_github("kbenoit/readtext") 
```

Using `readtext()` to import texts
----------------------------------

In the simplest case, we would like to load a set of texts in plain text files from a single directory. To do this, we use the `textfile` command, and use the 'glob' operator '\*' to indicate that we want to load multiple files:

``` r
require(readtext)
## Loading required package: readtext
myCorpus <- corpus(readtext("inaugural/*.txt"))
myCorpus <- corpus(readtext("sotu/*.txt"))
```

Often, we have metadata encoded in the names of the files. For example, the inaugural addresses contain the year and the president's name in the name of the file. With the `docvarsfrom` argument, we can instruct the `textfile` command to consider these elements as document variables.

``` r
mytf <- readtext("inaugural/*.txt", docvarsfrom = "filenames", dvsep = "-", 
                 docvarnames = c("Year", "President"))
data_corpus_inaugural <- corpus(mytf)
summary(data_corpus_inaugural, 5)
## Corpus consisting of 57 documents, showing 5 documents.
## 
##                 Text Types Tokens Sentences Year  President
##  1789-Washington.txt   626   1540        23 1789 Washington
##  1793-Washington.txt    96    147         4 1793 Washington
##       1797-Adams.txt   826   2584        37 1797      Adams
##   1801-Jefferson.txt   716   1935        41 1801  Jefferson
##   1805-Jefferson.txt   804   2381        45 1805  Jefferson
## 
## Source:  /Users/kbenoit/GitHub/ITAUR/3_file_import/* on x86_64 by kbenoit
## Created: Sun Apr 23 23:24:11 2017
## Notes:
```

If the texts and document variables are stored separately, we can easily add document variables to the corpus, as long as the data frame containing them is of the same length as the texts:

``` r
SOTUdocvars <- read.csv("SOTU_metadata.csv", stringsAsFactors = FALSE)
SOTUdocvars$Date <- as.Date(SOTUdocvars$Date, "%B %d, %Y")
SOTUdocvars$delivery <- as.factor(SOTUdocvars$delivery)
SOTUdocvars$type <- as.factor(SOTUdocvars$type)
SOTUdocvars$party <- as.factor(SOTUdocvars$party)
SOTUdocvars$nwords <- NULL

sotuCorpus <- corpus(readtext("sotu/*.txt", encoding = "UTF-8-BOM"))
docvars(sotuCorpus) <- SOTUdocvars
```

Another common case is that our texts are stored alongside the document variables in a structured file, such as a json, csv or excel file. The textfile command can read in the texts and document variables simultaneously from these files when the name of the field containing the texts is specified.

``` r
tf1 <- readtext("inaugTexts.csv", textfield = "inaugSpeech")
myCorpus <- corpus(tf1)


tf2 <- readtext("text_example.csv", textfield = "Title")
myCorpus <- corpus(tf2)
head(docvars(tf2))
##                    VOTE DocumentNo CouncilLink         Year
## text_example.csv.1    1    5728/99             Jan-Dec 1999
## text_example.csv.2    2    5728/99             Jan-Dec 1999
## text_example.csv.3    3    5728/99             Jan-Dec 1999
## text_example.csv.4    4    5728/99             Jan-Dec 1999
## text_example.csv.5    5    5728/99             Jan-Dec 1999
## text_example.csv.6    6    6327/99             Jan-Dec 1999
##                    Date.of.Meeting VotingDate
## text_example.csv.1      08/02/1999 08/02/1999
## text_example.csv.2      08/02/1999 08/02/1999
## text_example.csv.3      08/02/1999 08/02/1999
## text_example.csv.4      08/02/1999 08/02/1999
## text_example.csv.5      08/02/1999 08/02/1999
## text_example.csv.6      22/02/1999 22/02/1999
##                                                        Policy.area
## text_example.csv.1 Employment, Education, Culture & Social Affairs
## text_example.csv.2 Employment, Education, Culture & Social Affairs
## text_example.csv.3 Employment, Education, Culture & Social Affairs
## text_example.csv.4                         Agriculture & Fisheries
## text_example.csv.5                  Transport & Telecommunications
## text_example.csv.6                    Economic & Financial Affairs
##                    Council.configuration Procedure
## text_example.csv.1                ECOFIN         1
## text_example.csv.2                ECOFIN         1
## text_example.csv.3                ECOFIN         0
## text_example.csv.4                ECOFIN         0
## text_example.csv.5                ECOFIN         0
## text_example.csv.6       General Affairs         0
```

Working with corpus objects
---------------------------

Once the we have loaded a corpus with some document level variables, we can subset the corpus using these variables, create document-feature matrices by aggregating on the variables, or extract the texts concatenated by variable.

``` r
recentCorpus <- corpus_subset(data_corpus_inaugural, Year > 1980)
oldCorpus <- corpus_subset(data_corpus_inaugural, Year < 1880)

require(magrittr)
## Loading required package: magrittr
demCorpus <- corpus_subset(sotuCorpus, party == 'Democratic')
demFeatures <- dfm(demCorpus, remove = stopwords('english')) %>%
    dfm_trim(min_doc = 3, min_count = 5) %>% 
    dfm_weight(type='tfidf')
topfeatures(demFeatures)
##   mexico  tonight        $ treasury     jobs     1947      u.s   soviet 
## 199.2179 183.3506 153.5178 148.5544 139.5461 122.5412 120.0403 118.9656 
##   duties     help 
## 118.7152 117.9478

repCorpus <- corpus_subset(sotuCorpus, party == 'Republican') 
repFeatures <- dfm(repCorpus, remove = stopwords('english')) %>%
    dfm_trim(min_doc = 3, min_count = 5) %>% 
    dfm_weight(type = 'tfidf')
topfeatures(repFeatures)
##         upon      tonight      islands corporations         cent 
##    119.88325    110.90617    110.59322    102.07949     97.83122 
##       tariff         navy      program      subject     programs 
##     96.53531     93.14501     91.62697     91.41255     90.91003
```

The **quanteda** corpus objects can be combined using the `+` operator:

``` r
data_corpus_inaugural2 <- demCorpus + repCorpus
dfm(data_corpus_inaugural2, remove = stopwords('english'), verbose = FALSE) %>%
    dfm_trim(min_doc = 3, min_count = 5) %>% 
    dfm_weight(type = 'tfidf') %>% 
    topfeatures
##  tonight        •   mexico     jobs     upon  subject  program        $ 
## 292.8302 238.4091 233.6592 217.3148 215.6084 207.9494 207.8004 206.7664 
##     cent     gold 
## 194.7937 192.6288
```

It should also be possible to load a zip file containing texts directly from a url. However, whether this operation succeeds or not can depend on access permission settings on your particular system (i.e. fails on Windows):

``` r
immigfiles <- readtext("https://github.com/kbenoit/ME114/raw/master/day8/UKimmigTexts.zip")
mycorpus <- corpus(immigfiles)
summary(mycorpus)
```

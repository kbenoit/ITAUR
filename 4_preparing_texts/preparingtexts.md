Preparing texts for analysis
============================

### Kenneth Benoit

### 24 April 2017

Here we will step through the basic elements of preparing a text for analysis. These are tokenization, conversion to lower case, stemming, removing or selecting features, and defining equivalency classes for features, including the use of dictionaries.

### 1. Tokenization

Tokenization in quanteda is very *conservative*: by default, it only removes separator characters.

``` r
require(quanteda, quietly = TRUE, warn.conflicts = FALSE)
## quanteda version 0.9.9.50
## Using 7 of 8 cores for parallel computing
txt <- c(text1 = "This is $10 in 999 different ways,\n up and down; left and right!",
         text2 = "@kenbenoit working: on #quanteda 2day\t4ever, http://textasdata.com?page=123.")
tokens(txt)
## tokens from 2 documents.
## text1 :
##  [1] "This"      "is"        "$"         "10"        "in"       
##  [6] "999"       "different" "ways"      ","         "up"       
## [11] "and"       "down"      ";"         "left"      "and"      
## [16] "right"     "!"        
## 
## text2 :
##  [1] "@kenbenoit"     "working"        ":"              "on"            
##  [5] "#quanteda"      "2day"           "4ever"          ","             
##  [9] "http"           ":"              "/"              "/"             
## [13] "textasdata.com" "?"              "page"           "="             
## [17] "123"            "."
tokens(txt, verbose = TRUE)
## Starting tokenization...
## ...preserving Twitter characters (#, @)
## ...tokenizing 1 of 1 blocks
## ...replacing Twitter characters (#, @)
## ...serializing tokens
## 31 unique types
## ...total elapsed:  0.00100000000000011 seconds.
## Finished tokenizing and cleaning 2 texts.
## tokens from 2 documents.
## text1 :
##  [1] "This"      "is"        "$"         "10"        "in"       
##  [6] "999"       "different" "ways"      ","         "up"       
## [11] "and"       "down"      ";"         "left"      "and"      
## [16] "right"     "!"        
## 
## text2 :
##  [1] "@kenbenoit"     "working"        ":"              "on"            
##  [5] "#quanteda"      "2day"           "4ever"          ","             
##  [9] "http"           ":"              "/"              "/"             
## [13] "textasdata.com" "?"              "page"           "="             
## [17] "123"            "."
tokens(txt, remove_numbers = TRUE,  remove_punct = TRUE)
## tokens from 2 documents.
## text1 :
##  [1] "This"      "is"        "in"        "different" "ways"     
##  [6] "up"        "and"       "down"      "left"      "and"      
## [11] "right"    
## 
## text2 :
## [1] "@kenbenoit"     "working"        "on"             "#quanteda"     
## [5] "2day"           "4ever"          "http"           "textasdata.com"
## [9] "page"
tokens(txt, remove_numbers = FALSE, remove_punct = TRUE)
## tokens from 2 documents.
## text1 :
##  [1] "This"      "is"        "10"        "in"        "999"      
##  [6] "different" "ways"      "up"        "and"       "down"     
## [11] "left"      "and"       "right"    
## 
## text2 :
##  [1] "@kenbenoit"     "working"        "on"             "#quanteda"     
##  [5] "2day"           "4ever"          "http"           "textasdata.com"
##  [9] "page"           "123"
tokens(txt, remove_numbers = TRUE,  remove_punct = FALSE)
## tokens from 2 documents.
## text1 :
##  [1] "This"      "is"        "$"         "in"        "different"
##  [6] "ways"      ","         "up"        "and"       "down"     
## [11] ";"         "left"      "and"       "right"     "!"        
## 
## text2 :
##  [1] "@kenbenoit"     "working"        ":"              "on"            
##  [5] "#quanteda"      "2day"           "4ever"          ","             
##  [9] "http"           ":"              "/"              "/"             
## [13] "textasdata.com" "?"              "page"           "="             
## [17] "."
tokens(txt, remove_numbers = FALSE, remove_punct = FALSE)
## tokens from 2 documents.
## text1 :
##  [1] "This"      "is"        "$"         "10"        "in"       
##  [6] "999"       "different" "ways"      ","         "up"       
## [11] "and"       "down"      ";"         "left"      "and"      
## [16] "right"     "!"        
## 
## text2 :
##  [1] "@kenbenoit"     "working"        ":"              "on"            
##  [5] "#quanteda"      "2day"           "4ever"          ","             
##  [9] "http"           ":"              "/"              "/"             
## [13] "textasdata.com" "?"              "page"           "="             
## [17] "123"            "."
tokens(txt, remove_numbers = FALSE, remove_punct = FALSE, remove_separators = FALSE)
## tokens from 2 documents.
## text1 :
##  [1] "This"      " "         "is"        " "         "$"        
##  [6] "10"        " "         "in"        " "         "999"      
## [11] " "         "different" " "         "ways"      ","        
## [16] "\n"        " "         "up"        " "         "and"      
## [21] " "         "down"      ";"         " "         "left"     
## [26] " "         "and"       " "         "right"     "!"        
## 
## text2 :
##  [1] "@kenbenoit"     " "              "working"        ":"             
##  [5] " "              "on"             " "              "#quanteda"     
##  [9] " "              "2day"           "\t"             "4ever"         
## [13] ","              " "              "http"           ":"             
## [17] "/"              "/"              "textasdata.com" "?"             
## [21] "page"           "="              "123"            "."
```

There are several options to the `what` argument:

``` r
# sentence level
tokens(c("Kurt Vongeut said; only assholes use semi-colons.",
         "Today is Thursday in Canberra:  It is yesterday in London.",
         "Today is Thursday in Canberra:  \nIt is yesterday in London.",
         "To be?  Or\nnot to be?"),
       what = "sentence")
## tokens from 4 documents.
## Component 1 :
## [1] "Kurt Vongeut said; only assholes use semi-colons."
## 
## Component 2 :
## [1] "Today is Thursday in Canberra:  It is yesterday in London."
## 
## Component 3 :
## [1] "Today is Thursday in Canberra:   It is yesterday in London."
## 
## Component 4 :
## [1] "To be?"        "Or not to be?"
tokens(data_corpus_inaugural[2], what = "sentence")
## tokens from 1 document.
## 1793-Washington :
## [1] "Fellow citizens, I am again called upon by the voice of my country to execute the functions of its Chief Magistrate."                                                                                                                                                                                                                                       
## [2] "When the occasion proper for it shall arrive, I shall endeavor to express the high sense I entertain of this distinguished honor, and of the confidence which has been reposed in me by the people of united America."                                                                                                                                      
## [3] "Previous to the execution of any official act of the President the Constitution requires an oath of office."                                                                                                                                                                                                                                                
## [4] "This oath I am now about to take, and in your presence: That if it shall be found during my administration of the Government I have in any instance violated willingly or knowingly the injunctions thereof, I may (besides incurring constitutional punishment) be subject to the upbraidings of all who are now witnesses of the present solemn ceremony."

# character level
tokens("My big fat text package.", what = "character")
## tokens from 1 document.
## Component 1 :
##  [1] "M" "y" "b" "i" "g" "f" "a" "t" "t" "e" "x" "t" "p" "a" "c" "k" "a"
## [18] "g" "e" "."
tokens("My big fat text package.", what = "character", remove_separators = FALSE)
## tokens from 1 document.
## Component 1 :
##  [1] "M" "y" " " "b" "i" "g" " " "f" "a" "t" " " "t" "e" "x" "t" " " "p"
## [18] "a" "c" "k" "a" "g" "e" "."
```

Two other options, for really fast and simple tokenization are `"fastestword"` and `"fasterword"`, if performance is a key issue. These are less intelligent than the boundary detection used in the default `"word"` method, which is based on stringi/ICU boundary detection.

### 2. Conversion to lower case

This is a tricky one in our workflow, since it is a form of equivalency declaration, rather than a tokenization step. It turns out that it is more efficient to perform at the pre-tokenization stage.

The **quanteda** functions `*_tolower` include options designed to preserve acronyms.

``` r
test1 <- c(text1 = "England and France are members of NATO and UNESCO",
           text2 = "NASA sent a rocket into space.")
char_tolower(test1)
##                                               text1 
## "england and france are members of nato and unesco" 
##                                               text2 
##                    "nasa sent a rocket into space."
char_tolower(test1, keep_acronyms = TRUE)
##                                               text1 
## "england and france are members of NATO and UNESCO" 
##                                               text2 
##                    "NASA sent a rocket into space."

test2 <- tokens(test1, remove_punct=TRUE)
tokens_tolower(test2)
## tokens from 2 documents.
## text1 :
## [1] "england" "and"     "france"  "are"     "members" "of"      "nato"   
## [8] "and"     "unesco" 
## 
## text2 :
## [1] "nasa"   "sent"   "a"      "rocket" "into"   "space"
tokens_tolower(test2, keep_acronyms = TRUE)
## tokens from 2 documents.
## text1 :
## [1] "england" "and"     "france"  "are"     "members" "of"      "nato"   
## [8] "and"     "unesco" 
## 
## text2 :
## [1] "nasa"   "sent"   "a"      "rocket" "into"   "space"
```

The **quanteda** `*_tolower` functions are based on `stringi::stri_trans_tolower()`, and is therefore nicely Unicode compliant.

``` r
data(data_char_encodedtexts, package = "readtext")

# Russian
cat(iconv(data_char_encodedtexts[8], "windows-1251", "UTF-8"))
## "8-битные" oncodings являются частью прошлого. 0€. Дефис-ели. Тильда ~ тире - и ± § 50.
cat(tolower(iconv(data_char_encodedtexts[8], "windows-1251", "UTF-8")))
## "8-битные" oncodings являются частью прошлого. 0€. дефис-ели. тильда ~ тире - и ± § 50.
head(char_tolower(stopwords("russian")), 20)
##  [1] "и"   "в"   "во"  "не"  "что" "он"  "на"  "я"   "с"   "со"  "как"
## [12] "а"   "то"  "все" "она" "так" "его" "но"  "да"  "ты"
head(char_toupper(stopwords("russian")), 20)
##  [1] "И"   "В"   "ВО"  "НЕ"  "ЧТО" "ОН"  "НА"  "Я"   "С"   "СО"  "КАК"
## [12] "А"   "ТО"  "ВСЕ" "ОНА" "ТАК" "ЕГО" "НО"  "ДА"  "ТЫ"

# Arabic
cat(iconv(data_char_encodedtexts[6], "ISO-8859-6", "UTF-8"))
## ترميزات 8 بت هي موديل قديم. 0 . الواصلة أكل. تيلدا ~ م اندفاعة - و  50 .
cat(tolower(iconv(data_char_encodedtexts[6], "ISO-8859-6", "UTF-8")))
## ترميزات 8 بت هي موديل قديم. 0 . الواصلة أكل. تيلدا ~ م اندفاعة - و  50 .
head(char_toupper(stopwords("arabic")), 20)
##  [1] "فى"    "في"    "كل"    "لم"    "لن"    "له"    "من"    "هو"   
##  [9] "هي"    "قوة"   "كما"   "لها"   "منذ"   "وقد"   "ولا"   "نفسه" 
## [17] "لقاء"  "مقابل" "هناك"  "وقال"
```

**Note**: dfm, the Swiss army knife, converts to lower case by default, but this can be turned off using the `tolower = FALSE` argument.

### 3. Removing and selecting features

This can be done when creating a dfm:

``` r
# with English stopwords and stemming
dfmsInaug2 <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980),
                  remove = stopwords("english"), stem = TRUE)
dfmsInaug2
## Document-feature matrix of: 10 documents, 2,277 features (74.8% sparse).
head(dfmsInaug2)
## Document-feature matrix of: 10 documents, 2,277 features (74.8% sparse).
## (showing first 6 documents and first 6 features)
##               features
## docs           senat hatfield   , mr   . chief
##   1981-Reagan      2        1 174  3 130     1
##   1985-Reagan      4        0 177  0 124     1
##   1989-Bush        3        0 166  6 142     1
##   1993-Clinton     0        0 139  0  81     0
##   1997-Clinton     0        0 131  0 108     0
##   2001-Bush        0        0 110  0  96     0
```

Or can be done **after** creating a dfm:

``` r
myDfm <- dfm(c("My Christmas was ruined by your opposition tax plan.",
               "Does the United_States or Sweden have more progressive taxation?"),
             tolower = FALSE, verbose = TRUE)
##    ... tokenizing
##    ... found 2 documents, 20 features
##    ... created a 2 x 20 sparse dfm
##    ... complete. 
## Elapsed time: 0.005 seconds.
dfm_select(myDfm, features = c("s$", ".y"), selection = "keep", valuetype = "regex")
## Document-feature matrix of: 2 documents, 6 features (50% sparse).
## 2 x 6 sparse Matrix of class "dfmSparse"
##        features
## docs    My Christmas was by Does United_States
##   text1  1         1   1  1    0             0
##   text2  0         0   0  0    1             1
dfm_select(myDfm, features = c("s$", ".y"), selection = "remove", valuetype = "regex")
## Document-feature matrix of: 2 documents, 14 features (50% sparse).
## 2 x 14 sparse Matrix of class "dfmSparse"
##        features
## docs    ruined your opposition tax plan . the or Sweden have more
##   text1      1    1          1   1    1 1   0  0      0    0    0
##   text2      0    0          0   0    0 0   1  1      1    1    1
##        features
## docs    progressive taxation ?
##   text1           0        0 0
##   text2           1        1 1
dfm_select(myDfm, features = stopwords("english"), selection = "keep", valuetype = "fixed")
## Document-feature matrix of: 2 documents, 9 features (50% sparse).
## 2 x 9 sparse Matrix of class "dfmSparse"
##        features
## docs    My was by your Does the or have more
##   text1  1   1  1    1    0   0  0    0    0
##   text2  0   0  0    0    1   1  1    1    1
dfm_select(myDfm, features = stopwords("english"), selection = "remove", valuetype = "fixed")
## Document-feature matrix of: 2 documents, 11 features (50% sparse).
## 2 x 11 sparse Matrix of class "dfmSparse"
##        features
## docs    Christmas ruined opposition tax plan . United_States Sweden
##   text1         1      1          1   1    1 1             0      0
##   text2         0      0          0   0    0 0             1      1
##        features
## docs    progressive taxation ?
##   text1           0        0 0
##   text2           1        1 1
```

More examples:

``` r
# removing stopwords
testText <- "The quick brown fox named Seamus jumps over the lazy dog also named Seamus, with
             the newspaper from a boy named Seamus, in his mouth."
testCorpus <- corpus(testText)
# note: "also" is not in the default stopwords("english")
featnames(dfm(testCorpus, remove = stopwords("english")))
##  [1] "quick"     "brown"     "fox"       "named"     "seamus"   
##  [6] "jumps"     "lazy"      "dog"       "also"      ","        
## [11] "newspaper" "boy"       "mouth"     "."
# for ngrams
featnames(dfm(testCorpus, ngrams = 2, remove = stopwords("english")))
##  [1] "quick_brown"  "brown_fox"    "fox_named"    "named_seamus"
##  [5] "seamus_jumps" "lazy_dog"     "dog_also"     "also_named"  
##  [9] "seamus_,"     ",_with"       "boy_named"    ",_in"        
## [13] "mouth_."
featnames(dfm(testCorpus, ngrams = 1:2, remove = stopwords("english")))
##  [1] "quick"        "brown"        "fox"          "named"       
##  [5] "seamus"       "jumps"        "lazy"         "dog"         
##  [9] "also"         ","            "newspaper"    "boy"         
## [13] "mouth"        "."            "quick_brown"  "brown_fox"   
## [17] "fox_named"    "named_seamus" "seamus_jumps" "lazy_dog"    
## [21] "dog_also"     "also_named"   "seamus_,"     ",_with"      
## [25] "boy_named"    ",_in"         "mouth_."

## removing stopwords before constructing ngrams
tokensAll <- tokens(tolower(testText), remove_punct = TRUE)
tokensNoStopwords <- tokens_remove(tokensAll, stopwords("english"))
tokensNgramsNoStopwords <- tokens_ngrams(tokensNoStopwords, 2)
featnames(dfm(tokensNgramsNoStopwords, verbose = FALSE))
##  [1] "quick_brown"      "brown_fox"        "fox_named"       
##  [4] "named_seamus"     "seamus_jumps"     "jumps_lazy"      
##  [7] "lazy_dog"         "dog_also"         "also_named"      
## [10] "seamus_newspaper" "newspaper_boy"    "boy_named"       
## [13] "seamus_mouth"

# keep only certain words
dfm(testCorpus, select = "*s", verbose = FALSE)  # keep only words ending in "s"
## Document-feature matrix of: 1 document, 3 features (0% sparse).
## 1 x 3 sparse Matrix of class "dfmSparse"
##        features
## docs    seamus jumps his
##   text1      3     1   1
dfm(testCorpus, select = "s$", valuetype = "regex", verbose = FALSE)
## Document-feature matrix of: 1 document, 3 features (0% sparse).
## 1 x 3 sparse Matrix of class "dfmSparse"
##        features
## docs    seamus jumps his
##   text1      3     1   1

# testing Twitter functions
testTweets <- c("My homie @justinbieber #justinbieber shopping in #LA yesterday #beliebers",
                "2all the ha8ers including my bro #justinbieber #emabiggestfansjustinbieber",
                "Justin Bieber #justinbieber #belieber #fetusjustin #EMABiggestFansJustinBieber")
dfm(testTweets, select = "#*", remove_twitter = FALSE)  # keep only hashtags
## Document-feature matrix of: 3 documents, 6 features (50% sparse).
## 3 x 6 sparse Matrix of class "dfmSparse"
##        features
## docs    #justinbieber #la #beliebers #emabiggestfansjustinbieber #belieber
##   text1             1   1          1                           0         0
##   text2             1   0          0                           1         0
##   text3             1   0          0                           1         1
##        features
## docs    #fetusjustin
##   text1            0
##   text2            0
##   text3            1
dfm(testTweets, select = "^#.*$", valuetype = "regex", remove_twitter = FALSE)
## Document-feature matrix of: 3 documents, 6 features (50% sparse).
## 3 x 6 sparse Matrix of class "dfmSparse"
##        features
## docs    #justinbieber #la #beliebers #emabiggestfansjustinbieber #belieber
##   text1             1   1          1                           0         0
##   text2             1   0          0                           1         0
##   text3             1   0          0                           1         1
##        features
## docs    #fetusjustin
##   text1            0
##   text2            0
##   text3            1
```

One very nice feature is the ability to create a new dfm with the same feature set as the old. This is very useful, for instance, if we train a model on one dfm, and need to predict on counts from another, but need the feature set to be equivalent.

``` r
# selecting on a dfm
textVec1 <- c("This is text one.", "This, the second text.", "Here: the third text.")
textVec2 <- c("Here are new words.", "New words in this text.")
featnames(dfm1 <- dfm(textVec1))
##  [1] "this"   "is"     "text"   "one"    "."      ","      "the"   
##  [8] "second" "here"   ":"      "third"
featnames(dfm2a <- dfm(textVec2))
## [1] "here"  "are"   "new"   "words" "."     "in"    "this"  "text"
(dfm2b <- dfm_select(dfm2a, dfm1))
## Document-feature matrix of: 2 documents, 11 features (77.3% sparse).
## 2 x 11 sparse Matrix of class "dfmSparse"
##       this is text one . , the second here : third
## text1    0  0    0   0 1 0   0      0    1 0     0
## text2    1  0    1   0 1 0   0      0    0 0     0
identical(featnames(dfm1), featnames(dfm2b))
## [1] TRUE
```

### 4. Applying equivalency classes: dictionaries, thesaruses

Dictionary creation is done through the `dictionary()` function, which classes a named list of characters as a dictionary.

``` r
# import the Laver-Garry dictionary from http://bit.ly/1FH2nvf
lgdict <- dictionary(file = "LaverGarry.cat")
budgdfm <- dfm(data_corpus_irishbudget2010, dictionary = lgdict, verbose = TRUE)
## Creating a dfm from a corpus ...
##    ... tokenizing texts
##    ... lowercasing
##    ... found 14 documents, 5,058 features
## ...
## applying a dictionary consisting of 20 keys
##    ... created a 14 x 20 sparse dfm
##    ... complete. 
## Elapsed time: 0.232 seconds.
head(budgdfm)
## Document-feature matrix of: 14 documents, 20 features (0% sparse).
## 14 x 20 sparse Matrix of class "dfmSparse"
##                                        features
## docs                                    CULTURE CULTURE.CULTURE-HIGH
##   2010_BUDGET_01_Brian_Lenihan_FF             8                    1
##   2010_BUDGET_02_Richard_Bruton_FG           35                    0
##   2010_BUDGET_03_Joan_Burton_LAB             31                    1
##   2010_BUDGET_04_Arthur_Morgan_SF            53                    0
##   2010_BUDGET_05_Brian_Cowen_FF              15                    1
##   2010_BUDGET_06_Enda_Kenny_FG               25                    1
##   2010_BUDGET_07_Kieran_ODonnell_FG          18                    0
##   2010_BUDGET_08_Eamon_Gilmore_LAB           28                    0
##   2010_BUDGET_09_Michael_Higgins_LAB          7                    0
##   2010_BUDGET_10_Ruairi_Quinn_LAB             3                    0
##   2010_BUDGET_11_John_Gormley_Green           6                    0
##   2010_BUDGET_12_Eamon_Ryan_Green             5                    0
##   2010_BUDGET_13_Ciaran_Cuffe_Green           4                    0
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF      28                    1
##                                        features
## docs                                    CULTURE.CULTURE-POPULAR
##   2010_BUDGET_01_Brian_Lenihan_FF                             0
##   2010_BUDGET_02_Richard_Bruton_FG                            0
##   2010_BUDGET_03_Joan_Burton_LAB                              1
##   2010_BUDGET_04_Arthur_Morgan_SF                             3
##   2010_BUDGET_05_Brian_Cowen_FF                               0
##   2010_BUDGET_06_Enda_Kenny_FG                                0
##   2010_BUDGET_07_Kieran_ODonnell_FG                           0
##   2010_BUDGET_08_Eamon_Gilmore_LAB                            0
##   2010_BUDGET_09_Michael_Higgins_LAB                          0
##   2010_BUDGET_10_Ruairi_Quinn_LAB                             0
##   2010_BUDGET_11_John_Gormley_Green                           0
##   2010_BUDGET_12_Eamon_Ryan_Green                             0
##   2010_BUDGET_13_Ciaran_Cuffe_Green                           0
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                       1
##                                        features
## docs                                    CULTURE.SPORT ECONOMY.+STATE+
##   2010_BUDGET_01_Brian_Lenihan_FF                   0             116
##   2010_BUDGET_02_Richard_Bruton_FG                  0              35
##   2010_BUDGET_03_Joan_Burton_LAB                    0             136
##   2010_BUDGET_04_Arthur_Morgan_SF                   0              93
##   2010_BUDGET_05_Brian_Cowen_FF                     0              92
##   2010_BUDGET_06_Enda_Kenny_FG                      0              46
##   2010_BUDGET_07_Kieran_ODonnell_FG                 0              30
##   2010_BUDGET_08_Eamon_Gilmore_LAB                  0              74
##   2010_BUDGET_09_Michael_Higgins_LAB                0              14
##   2010_BUDGET_10_Ruairi_Quinn_LAB                   0              14
##   2010_BUDGET_11_John_Gormley_Green                 0               8
##   2010_BUDGET_12_Eamon_Ryan_Green                   0              22
##   2010_BUDGET_13_Ciaran_Cuffe_Green                 0              13
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF             0             115
##                                        features
## docs                                    ECONOMY.=STATE= ECONOMY.-STATE-
##   2010_BUDGET_01_Brian_Lenihan_FF                   357             115
##   2010_BUDGET_02_Richard_Bruton_FG                  131              35
##   2010_BUDGET_03_Joan_Burton_LAB                    208              61
##   2010_BUDGET_04_Arthur_Morgan_SF                   296              50
##   2010_BUDGET_05_Brian_Cowen_FF                     245              82
##   2010_BUDGET_06_Enda_Kenny_FG                      139              27
##   2010_BUDGET_07_Kieran_ODonnell_FG                  85               6
##   2010_BUDGET_08_Eamon_Gilmore_LAB                  190              33
##   2010_BUDGET_09_Michael_Higgins_LAB                 36               5
##   2010_BUDGET_10_Ruairi_Quinn_LAB                    26               9
##   2010_BUDGET_11_John_Gormley_Green                  46               8
##   2010_BUDGET_12_Eamon_Ryan_Green                    31               5
##   2010_BUDGET_13_Ciaran_Cuffe_Green                  39               7
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF             154              23
##                                        features
## docs                                    ENVIRONMENT.CON ENVIRONMENT
##   2010_BUDGET_01_Brian_Lenihan_FF                                 4
##   2010_BUDGET_02_Richard_Bruton_FG                                3
##   2010_BUDGET_03_Joan_Burton_LAB                                  0
##   2010_BUDGET_04_Arthur_Morgan_SF                                 1
##   2010_BUDGET_05_Brian_Cowen_FF                                   8
##   2010_BUDGET_06_Enda_Kenny_FG                                    2
##   2010_BUDGET_07_Kieran_ODonnell_FG                               1
##   2010_BUDGET_08_Eamon_Gilmore_LAB                                1
##   2010_BUDGET_09_Michael_Higgins_LAB                              0
##   2010_BUDGET_10_Ruairi_Quinn_LAB                                 0
##   2010_BUDGET_11_John_Gormley_Green                               0
##   2010_BUDGET_12_Eamon_Ryan_Green                                 0
##   2010_BUDGET_13_Ciaran_Cuffe_Green                               0
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                           1
##                                        features
## docs                                    ENVIRONMENT.PRO ENVIRONMENT
##   2010_BUDGET_01_Brian_Lenihan_FF                                18
##   2010_BUDGET_02_Richard_Bruton_FG                                2
##   2010_BUDGET_03_Joan_Burton_LAB                                  6
##   2010_BUDGET_04_Arthur_Morgan_SF                                 9
##   2010_BUDGET_05_Brian_Cowen_FF                                  18
##   2010_BUDGET_06_Enda_Kenny_FG                                    6
##   2010_BUDGET_07_Kieran_ODonnell_FG                               0
##   2010_BUDGET_08_Eamon_Gilmore_LAB                                1
##   2010_BUDGET_09_Michael_Higgins_LAB                              3
##   2010_BUDGET_10_Ruairi_Quinn_LAB                                 1
##   2010_BUDGET_11_John_Gormley_Green                              12
##   2010_BUDGET_12_Eamon_Ryan_Green                                 7
##   2010_BUDGET_13_Ciaran_Cuffe_Green                               4
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                           6
##                                        features
## docs                                    GROUPS.ETHNIC GROUPS.WOMEN
##   2010_BUDGET_01_Brian_Lenihan_FF                   0            0
##   2010_BUDGET_02_Richard_Bruton_FG                  0            0
##   2010_BUDGET_03_Joan_Burton_LAB                    0            3
##   2010_BUDGET_04_Arthur_Morgan_SF                   0            0
##   2010_BUDGET_05_Brian_Cowen_FF                     0            0
##   2010_BUDGET_06_Enda_Kenny_FG                      0            1
##   2010_BUDGET_07_Kieran_ODonnell_FG                 0            0
##   2010_BUDGET_08_Eamon_Gilmore_LAB                  0            1
##   2010_BUDGET_09_Michael_Higgins_LAB                0            0
##   2010_BUDGET_10_Ruairi_Quinn_LAB                   0            0
##   2010_BUDGET_11_John_Gormley_Green                 0            0
##   2010_BUDGET_12_Eamon_Ryan_Green                   0            1
##   2010_BUDGET_13_Ciaran_Cuffe_Green                 0            0
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF             0            0
##                                        features
## docs                                    INSTITUTIONS.CONSERVATIVE
##   2010_BUDGET_01_Brian_Lenihan_FF                              13
##   2010_BUDGET_02_Richard_Bruton_FG                              6
##   2010_BUDGET_03_Joan_Burton_LAB                                5
##   2010_BUDGET_04_Arthur_Morgan_SF                               6
##   2010_BUDGET_05_Brian_Cowen_FF                                19
##   2010_BUDGET_06_Enda_Kenny_FG                                 10
##   2010_BUDGET_07_Kieran_ODonnell_FG                             2
##   2010_BUDGET_08_Eamon_Gilmore_LAB                              3
##   2010_BUDGET_09_Michael_Higgins_LAB                            1
##   2010_BUDGET_10_Ruairi_Quinn_LAB                               0
##   2010_BUDGET_11_John_Gormley_Green                             3
##   2010_BUDGET_12_Eamon_Ryan_Green                               4
##   2010_BUDGET_13_Ciaran_Cuffe_Green                             5
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                         8
##                                        features
## docs                                    INSTITUTIONS.NEUTRAL
##   2010_BUDGET_01_Brian_Lenihan_FF                         64
##   2010_BUDGET_02_Richard_Bruton_FG                        63
##   2010_BUDGET_03_Joan_Burton_LAB                          68
##   2010_BUDGET_04_Arthur_Morgan_SF                         48
##   2010_BUDGET_05_Brian_Cowen_FF                           34
##   2010_BUDGET_06_Enda_Kenny_FG                            34
##   2010_BUDGET_07_Kieran_ODonnell_FG                       11
##   2010_BUDGET_08_Eamon_Gilmore_LAB                        18
##   2010_BUDGET_09_Michael_Higgins_LAB                       9
##   2010_BUDGET_10_Ruairi_Quinn_LAB                         15
##   2010_BUDGET_11_John_Gormley_Green                        3
##   2010_BUDGET_12_Eamon_Ryan_Green                          4
##   2010_BUDGET_13_Ciaran_Cuffe_Green                        4
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                   31
##                                        features
## docs                                    INSTITUTIONS.RADICAL
##   2010_BUDGET_01_Brian_Lenihan_FF                         17
##   2010_BUDGET_02_Richard_Bruton_FG                        26
##   2010_BUDGET_03_Joan_Burton_LAB                          11
##   2010_BUDGET_04_Arthur_Morgan_SF                          9
##   2010_BUDGET_05_Brian_Cowen_FF                           10
##   2010_BUDGET_06_Enda_Kenny_FG                             9
##   2010_BUDGET_07_Kieran_ODonnell_FG                        3
##   2010_BUDGET_08_Eamon_Gilmore_LAB                        10
##   2010_BUDGET_09_Michael_Higgins_LAB                       1
##   2010_BUDGET_10_Ruairi_Quinn_LAB                          4
##   2010_BUDGET_11_John_Gormley_Green                        0
##   2010_BUDGET_12_Eamon_Ryan_Green                          0
##   2010_BUDGET_13_Ciaran_Cuffe_Green                       10
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                    7
##                                        features
## docs                                    LAW_AND_ORDER.LAW-CONSERVATIVE
##   2010_BUDGET_01_Brian_Lenihan_FF                                   11
##   2010_BUDGET_02_Richard_Bruton_FG                                  14
##   2010_BUDGET_03_Joan_Burton_LAB                                     6
##   2010_BUDGET_04_Arthur_Morgan_SF                                   22
##   2010_BUDGET_05_Brian_Cowen_FF                                      4
##   2010_BUDGET_06_Enda_Kenny_FG                                      18
##   2010_BUDGET_07_Kieran_ODonnell_FG                                  4
##   2010_BUDGET_08_Eamon_Gilmore_LAB                                  10
##   2010_BUDGET_09_Michael_Higgins_LAB                                 2
##   2010_BUDGET_10_Ruairi_Quinn_LAB                                    2
##   2010_BUDGET_11_John_Gormley_Green                                  3
##   2010_BUDGET_12_Eamon_Ryan_Green                                    1
##   2010_BUDGET_13_Ciaran_Cuffe_Green                                  6
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                              8
##                                        features
## docs                                    LAW_AND_ORDER.LAW-LIBERAL RURAL
##   2010_BUDGET_01_Brian_Lenihan_FF                               0     9
##   2010_BUDGET_02_Richard_Bruton_FG                              0     0
##   2010_BUDGET_03_Joan_Burton_LAB                                0     2
##   2010_BUDGET_04_Arthur_Morgan_SF                               0     2
##   2010_BUDGET_05_Brian_Cowen_FF                                 0     8
##   2010_BUDGET_06_Enda_Kenny_FG                                  0     0
##   2010_BUDGET_07_Kieran_ODonnell_FG                             0     0
##   2010_BUDGET_08_Eamon_Gilmore_LAB                              0     2
##   2010_BUDGET_09_Michael_Higgins_LAB                            0     0
##   2010_BUDGET_10_Ruairi_Quinn_LAB                               0     0
##   2010_BUDGET_11_John_Gormley_Green                             0     0
##   2010_BUDGET_12_Eamon_Ryan_Green                               0     2
##   2010_BUDGET_13_Ciaran_Cuffe_Green                             0     1
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF                         0     1
##                                        features
## docs                                    URBAN VALUES.CONSERVATIVE
##   2010_BUDGET_01_Brian_Lenihan_FF           0                  19
##   2010_BUDGET_02_Richard_Bruton_FG          0                  14
##   2010_BUDGET_03_Joan_Burton_LAB            3                   5
##   2010_BUDGET_04_Arthur_Morgan_SF           1                  16
##   2010_BUDGET_05_Brian_Cowen_FF             1                  13
##   2010_BUDGET_06_Enda_Kenny_FG              2                   7
##   2010_BUDGET_07_Kieran_ODonnell_FG         0                   4
##   2010_BUDGET_08_Eamon_Gilmore_LAB          0                  12
##   2010_BUDGET_09_Michael_Higgins_LAB        0                   2
##   2010_BUDGET_10_Ruairi_Quinn_LAB           0                   4
##   2010_BUDGET_11_John_Gormley_Green         0                   6
##   2010_BUDGET_12_Eamon_Ryan_Green           0                   7
##   2010_BUDGET_13_Ciaran_Cuffe_Green         0                   6
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF     1                   8
##                                        features
## docs                                    VALUES.LIBERAL
##   2010_BUDGET_01_Brian_Lenihan_FF                    0
##   2010_BUDGET_02_Richard_Bruton_FG                   0
##   2010_BUDGET_03_Joan_Burton_LAB                     1
##   2010_BUDGET_04_Arthur_Morgan_SF                    2
##   2010_BUDGET_05_Brian_Cowen_FF                      0
##   2010_BUDGET_06_Enda_Kenny_FG                       1
##   2010_BUDGET_07_Kieran_ODonnell_FG                  1
##   2010_BUDGET_08_Eamon_Gilmore_LAB                   1
##   2010_BUDGET_09_Michael_Higgins_LAB                 0
##   2010_BUDGET_10_Ruairi_Quinn_LAB                    0
##   2010_BUDGET_11_John_Gormley_Green                  0
##   2010_BUDGET_12_Eamon_Ryan_Green                    0
##   2010_BUDGET_13_Ciaran_Cuffe_Green                  0
##   2010_BUDGET_14_Caoimhghin_OCaolain_SF              0
## (showing first 6 documents and first 6 features)
##                                   features
## docs                               CULTURE CULTURE.CULTURE-HIGH
##   2010_BUDGET_01_Brian_Lenihan_FF        8                    1
##   2010_BUDGET_02_Richard_Bruton_FG      35                    0
##   2010_BUDGET_03_Joan_Burton_LAB        31                    1
##   2010_BUDGET_04_Arthur_Morgan_SF       53                    0
##   2010_BUDGET_05_Brian_Cowen_FF         15                    1
##   2010_BUDGET_06_Enda_Kenny_FG          25                    1
##                                   features
## docs                               CULTURE.CULTURE-POPULAR CULTURE.SPORT
##   2010_BUDGET_01_Brian_Lenihan_FF                        0             0
##   2010_BUDGET_02_Richard_Bruton_FG                       0             0
##   2010_BUDGET_03_Joan_Burton_LAB                         1             0
##   2010_BUDGET_04_Arthur_Morgan_SF                        3             0
##   2010_BUDGET_05_Brian_Cowen_FF                          0             0
##   2010_BUDGET_06_Enda_Kenny_FG                           0             0
##                                   features
## docs                               ECONOMY.+STATE+ ECONOMY.=STATE=
##   2010_BUDGET_01_Brian_Lenihan_FF              116             357
##   2010_BUDGET_02_Richard_Bruton_FG              35             131
##   2010_BUDGET_03_Joan_Burton_LAB               136             208
##   2010_BUDGET_04_Arthur_Morgan_SF               93             296
##   2010_BUDGET_05_Brian_Cowen_FF                 92             245
##   2010_BUDGET_06_Enda_Kenny_FG                  46             139

# import a LIWC formatted dictionary
liwcdict <- dictionary(file = "~/Dropbox/QUANTESS/dictionaries/LIWC/LIWC2015_English_Flat.dic")
dictdfm <- dfm(data_corpus_inaugural, dictionary = liwcdict, verbose = TRUE)
## Creating a dfm from a corpus ...
##    ... tokenizing texts
##    ... lowercasing
## ...
## applying a dictionary consisting of 73 keys
##    ... found 58 documents, 72 features
##    ... created a 58 x 72 sparse dfm
##    ... complete. 
## Elapsed time: 0 seconds.
dictdfm[50:58, c("money", "power")]
## Document-feature matrix of: 9 documents, 2 features (0% sparse).
## 9 x 2 sparse Matrix of class "dfmSparse"
##               features
## docs           money power
##   1985-Reagan     45   120
##   1989-Bush       20    97
##   1993-Clinton    14    65
##   1997-Clinton    12    97
##   2001-Bush        8    81
##   2005-Bush       15    94
##   2009-Obama      24    97
##   2013-Obama      22    76
##   2017-Trump      16    73
```

We apply dictionaries to a dfm using the `dfm_lookup()` function. Through the `valuetype`, argument, we can match patterns of one of three types: `"glob"`, `"regex"`, or `"fixed"`.

``` r
myDict <- dictionary(list(christmas = c("Christmas", "Santa", "holiday"),
                          opposition = c("Opposition", "reject", "notincorpus"),
                          taxglob = "tax*",
                          taxregex = "tax.+$",
                          country = c("United_States", "Sweden")))
myDfm <- dfm(c("My Christmas was ruined by your opposition tax plan.",
               "Does the United_States or Sweden have more progressive taxation?"),
             remove = stopwords("english"), verbose = FALSE)
myDfm
## Document-feature matrix of: 2 documents, 11 features (50% sparse).
## 2 x 11 sparse Matrix of class "dfmSparse"
##        features
## docs    christmas ruined opposition tax plan . united_states sweden
##   text1         1      1          1   1    1 1             0      0
##   text2         0      0          0   0    0 0             1      1
##        features
## docs    progressive taxation ?
##   text1           0        0 0
##   text2           1        1 1

# glob format
dfm_lookup(myDfm, myDict, valuetype = "glob")
## Document-feature matrix of: 2 documents, 5 features (0% sparse).
## 2 x 5 sparse Matrix of class "dfmSparse"
##        features
## docs    christmas opposition taxglob taxregex country
##   text1         1          1       1        0       0
##   text2         0          0       1        0       2
dfm_lookup(myDfm, myDict, valuetype = "glob", case_insensitive = FALSE)
## Document-feature matrix of: 2 documents, 5 features (0% sparse).
## 2 x 5 sparse Matrix of class "dfmSparse"
##        features
## docs    christmas opposition taxglob taxregex country
##   text1         1          1       1        0       0
##   text2         0          0       1        0       2

# regex v. glob format: note that "united_states" is a regex match for "tax*"
dfm_lookup(myDfm, myDict, valuetype = "glob")
## Document-feature matrix of: 2 documents, 5 features (0% sparse).
## 2 x 5 sparse Matrix of class "dfmSparse"
##        features
## docs    christmas opposition taxglob taxregex country
##   text1         1          1       1        0       0
##   text2         0          0       1        0       2
dfm_lookup(myDfm, myDict, valuetype = "regex", case_insensitive = TRUE)
## Document-feature matrix of: 2 documents, 5 features (0% sparse).
## 2 x 5 sparse Matrix of class "dfmSparse"
##        features
## docs    christmas opposition taxglob taxregex country
##   text1         1          1       1        0       0
##   text2         0          0       2        1       2

# fixed format: no pattern matching
dfm_lookup(myDfm, myDict, valuetype = "fixed")
## Document-feature matrix of: 2 documents, 5 features (0% sparse).
## 2 x 5 sparse Matrix of class "dfmSparse"
##        features
## docs    christmas opposition taxglob taxregex country
##   text1         1          1       0        0       0
##   text2         0          0       0        0       2
dfm_lookup(myDfm, myDict, valuetype = "fixed", case_insensitive = FALSE)
## Document-feature matrix of: 2 documents, 5 features (0% sparse).
## 2 x 5 sparse Matrix of class "dfmSparse"
##        features
## docs    christmas opposition taxglob taxregex country
##   text1         1          1       0        0       0
##   text2         0          0       0        0       2
```

It is also possible to pass through a dictionary at the time of `dfm()` creation.

``` r
# dfm with dictionaries
mycorpus <- corpus_subset(data_corpus_inaugural, Year > 1900)
mydict <- dictionary(list(christmas = c("Christmas", "Santa", "holiday"),
                          opposition = c("Opposition", "reject", "notincorpus"),
                          taxing = "taxing",
                          taxation = "taxation",
                          taxregex = "tax*",
                          country = "united states"))
dictDfm <- dfm(mycorpus, dictionary = mydict)
head(dictDfm)
## Document-feature matrix of: 30 documents, 5 features (70% sparse).
## (showing first 6 documents and first 5 features)
##                 features
## docs             christmas opposition taxation taxregex country
##   1901-McKinley          0          2        1        1       9
##   1905-Roosevelt         0          0        0        0       0
##   1909-Taft              0          1        4        6       6
##   1913-Wilson            0          0        1        1       0
##   1917-Wilson            0          0        0        0       1
##   1921-Harding           0          0        1        2       1
```

Finally, there is a related "thesaurus" feature, which collapses words in a dictionary but is not exclusive.

``` r
mytexts <- c("British English tokenises differently, with more colour.",
             "American English tokenizes color as one word.")
mydict <- dictionary(list(color = "colo*r", tokenize = "tokeni?e*"))
dfm(mytexts, thesaurus = mydict)
## Document-feature matrix of: 2 documents, 13 features (34.6% sparse).
## 2 x 13 sparse Matrix of class "dfmSparse"
##        features
## docs    british english differently , with more . american as one word
##   text1       1       1           1 1    1    1 1        0  0   0    0
##   text2       0       1           0 0    0    0 1        1  1   1    1
##        features
## docs    COLOR TOKENIZE
##   text1     1        1
##   text2     1        1
```

### 5. Stemming

Stemming relies on the `SnowballC` package's implementation of the Porter stemmer, and is available for the following languages:

``` r
SnowballC::getStemLanguages()
##  [1] "danish"     "dutch"      "english"    "finnish"    "french"    
##  [6] "german"     "hungarian"  "italian"    "norwegian"  "porter"    
## [11] "portuguese" "romanian"   "russian"    "spanish"    "swedish"   
## [16] "turkish"
```

It's not perfect:

``` r
char_wordstem(c("win", "winning", "wins", "won", "winner"))
## [1] "win"    "win"    "win"    "won"    "winner"
```

but it's fast.

Stemmed objects must be tokenized, but can be of many different quanteda classes:

``` r
txt <- "From 10k packages, quanteda is an text analysis package, for analysing texts."
char_wordstem(txt)
## Error in char_wordstem(txt): whitespace detected: you can only stem tokenized texts
(toks <- tokens_wordstem(tokens(txt, remove_punct = TRUE)))
## tokens from 1 document.
## Component 1 :
##  [1] "From"     "10k"      "packag"   "quanteda" "i"        "an"      
##  [7] "text"     "analysi"  "packag"   "for"      "analys"   "text"
dfm_wordstem(dfm(toks))
## Document-feature matrix of: 1 document, 10 features (0% sparse).
## 1 x 10 sparse Matrix of class "dfmSparse"
##        features
## docs    from 10k packag quanteda i an text analysi for anali
##   text1    1   1      2        1 1  1    2       1   1     1
```

Some text operations can be conducted directly on the dfm:

``` r
dfm1 <- dfm(data_corpus_inaugural[1:2], verbose = FALSE)
head(featnames(dfm1))
```

    ## [1] "fellow"   "-"        "citizens" "of"       "the"      "senate"

``` r
head(featnames(dfm_wordstem(dfm1)))
```

    ## [1] "fellow"  "-"       "citizen" "of"      "the"     "senat"

``` r
# same as 
head(dfm(data_corpus_inaugural[1:2], stem = TRUE, verbose = FALSE))
```

    ## Document-feature matrix of: 2 documents, 579 features (44.3% sparse).
    ## (showing first 2 documents and first 6 features)
    ##                  features
    ## docs              fellow - citizen of the senat
    ##   1789-Washington      3 3       5 71 116     1
    ##   1793-Washington      1 0       1 11  13     0

### 6. `dfm()` and its many options

Operates on `character` (vectors), `corpus`, or `tokens` objects,

``` r
dfm(x, tolower = TRUE, stem = FALSE, select = NULL, remove = NULL,
  thesaurus = NULL, dictionary = NULL, 
  valuetype = c("glob", "regex", "fixed"), 
  groups = NULL, 
  verbose = quanteda_options("verbose"), ...)
```

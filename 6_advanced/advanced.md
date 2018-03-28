Advanced Analysis of Texts
==========================

### Kenneth Benoit

### 24 April 2017

In this section we will explore some text analysis and analysis of
metadata from a corpus of tweets retrieved from the Twitter API. The
tweets are a small sample from a collection of tweets relating to the
European Parliament elections of 2015.

Load the data frame containing the sample tweets:

``` r
require(quanteda)
## Loading required package: quanteda
## Package version: 1.1.4
## Parallel computing: 2 of 8 threads used.
## See https://quanteda.io for tutorials and examples.
## 
## Attaching package: 'quanteda'
## The following object is masked from 'package:utils':
## 
##     View
load("tweetSample.RData")
str(tweetSample)
## 'data.frame':    10000 obs. of  35 variables:
##  $ created_at          : chr  "2014-05-28 15:53:33+00:00" "2014-05-30 08:32:13+00:00" "2014-05-29 19:22:15+00:00" "2014-05-03 20:23:43+00:00" ...
##  $ geo_latitude        : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ geo_longitude       : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ hashtags            : chr  "['Pomeriggio5', 'Canale5']" NA NA NA ...
##  $ id                  : num  4.72e+17 4.72e+17 4.72e+17 4.63e+17 4.71e+17 ...
##  $ lang                : Factor w/ 43 levels "Arabic","Basque",..: 20 35 35 15 30 12 33 9 35 35 ...
##  $ text                : chr  "Oggi pomeriggio, a partire dalle 18.00, interverrò a #Pomeriggio5 su #Canale5 http://t.co/aqB64fH4et ST" ".@pacomarhuenda llamando El Coletas a @Pablo_Iglesias_... precisamente, si hay alguien que tiene que callarse s"| __truncated__ "Las declaraciones de Felipe Gonzalez hoy hablan por sí solas http://t.co/0LJo6zAXdc" "@KOPRITHS @GAPATZHS @MariaSpyraki και εκεί που λες εχουν πιάσει πάτο, θα καταφέρουν να σε διαψεύσουν." ...
##  $ type                : Factor w/ 3 levels "reply","retweet",..: 2 3 2 2 3 2 2 2 2 2 ...
##  $ user_followers_count: int  769 303 470 470 3662 470 67 124 1359 181 ...
##  $ user_friends_count  : int  557 789 419 647 793 910 36 90 793 258 ...
##  $ user_geo_enabled    : Factor w/ 2 levels "False","True": 1 1 2 1 2 1 2 1 1 2 ...
##  $ user_id             : num  8.40e+07 2.75e+08 4.61e+08 2.43e+09 1.62e+08 ...
##  $ user_id_str         : num  8.40e+07 2.75e+08 4.61e+08 2.43e+09 1.62e+08 ...
##  $ user_lang           : Factor w/ 40 levels "Arabic","Basque",..: 10 34 34 16 4 13 21 10 4 34 ...
##  $ user_listed_count   : int  6 13 1 1 133 4 0 3 31 7 ...
##  $ user_location       : chr  NA "Sanfer of Henares" "La Puebla ciry" NA ...
##  $ user_name           : chr  "Francesco Filini" "Carlos Marina" "Gabi Armario Cívico" "ΤΗΛΕΠΛΑΣΙΕ" ...
##  $ user_screen_name    : chr  "FrancescoFilini" "marina_carlos" "erpartecama" "THLEPLASHIE" ...
##  $ user_statuses_count : int  1880 7051 6776 666 19006 30239 1563 601 37237 2313 ...
##  $ user_time_zone      : chr  "Amsterdam" "Madrid" "Athens" NA ...
##  $ user_url            : chr  "http://rapportoaureo.wordpress.com" "http://carlosmarina.com" "http://www.cazuelaalamorisca.com" NA ...
##  $ user_created_at     : chr  "Wed, 21 Oct 2009 08:59:58 +0000" "2011-03-30 13:07:21+00:00" "Tue, 10 Jan 2012 23:23:18 +0000" "Mon, 07 Apr 2014 10:59:39 +0000" ...
##  $ user_geo_enabled.1  : Factor w/ 2 levels "False","True": 1 1 2 1 2 1 2 1 1 2 ...
##  $ user_screen_nameL   : chr  "francescofilini" "marina_carlos" "erpartecama" "thleplashie" ...
##  $ Party               : chr  NA NA NA NA ...
##  $ Party.Code          : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ Sitting_2009        : Factor w/ 2 levels "Non-incumbent",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ Sitting_2014        : Factor w/ 2 levels "Non-incumbent",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ Name                : chr  NA NA NA NA ...
##  $ Twitter             : chr  NA NA NA NA ...
##  $ Facebook            : chr  NA NA NA NA ...
##  $ gender              : Factor w/ 2 levels "Female","Male": NA NA NA NA NA NA NA NA NA NA ...
##  $ Country             : Factor w/ 27 levels "Austria","Belgium",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ hasTwitter          : Factor w/ 2 levels "No","Yes": NA NA NA NA NA NA NA NA NA NA ...
##  $ candidate           : Factor w/ 2 levels "candidate","non-candidate": NA NA NA NA NA NA NA NA NA NA ...
```

``` r
require(lubridate)
## Loading required package: lubridate
## 
## Attaching package: 'lubridate'
## The following object is masked from 'package:base':
## 
##     date
require(dplyr)
## Loading required package: dplyr
## 
## Attaching package: 'dplyr'
## The following objects are masked from 'package:lubridate':
## 
##     intersect, setdiff, union
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
tweetSample <- mutate(tweetSample, day = yday(created_at))
tweetSample <- mutate(tweetSample, dayDate = as.Date(day-1, origin = "2014-01-01"))
juncker <- filter(tweetSample, grepl('juncker', text, ignore.case = TRUE)) %>% 
    mutate(kand = 'Juncker')
schulz <-  filter(tweetSample, grepl('schulz', text, ignore.case = TRUE)) %>% 
    mutate(kand = 'Schulz')
verhof <-  filter(tweetSample, grepl('verhofstadt', text, ignore.case = TRUE)) %>% 
    mutate(kand = 'Verhofstadt')
spitzAll <- bind_rows(juncker, schulz, verhof)
```

Once the data is in the correct format, we can use ggplot to display the
candidate mentions on the a single plot:

``` r
require(ggplot2)
## Loading required package: ggplot2
require(scales)
## Loading required package: scales
# mentioning kandidates names over time
plotDf <- count(spitzAll, kand, day=day) %>% 
    mutate(day = as.Date(day-1, origin = "2014-01-01"))

ggplot(data=plotDf, aes(x=day, y=n, colour=kand)) + 
    geom_line(size=1) +
    scale_y_continuous(labels = comma) + geom_vline(xintercept=as.numeric(as.Date("2014-05-15")), linetype=4) +
    geom_vline(xintercept=as.numeric(as.Date("2014-05-25")), linetype=4) +
    theme(axis.text=element_text(size=12),
          axis.title=element_text(size=14,face="bold"))
```

![](advanced_files/figure-markdown_github/unnamed-chunk-4-1.png)

We can use the `keptFeatures` argument to `dfm()` to analyse only
hashtags for each candidate’s text.

``` r
# Top hashtags for tweets that mention Juncker
dv <- data.frame(user = juncker$user_screen_name)
jCorp <- corpus(juncker$text, docvars = dv)
jd <- dfm(jCorp)
jd <- dfm_select(jd, "^#.+", "keep", valuetype = "regex") 
# equivalent: jd <- dfm_select(jd, "#*", "keep", valuetype = "glob") 
topfeatures(jd, nfeature(jd))
## Warning: 'nfeature' is deprecated.
## Use 'nfeat' instead.
## See help("Deprecated")
##   #withjuncker        #ep2014    #telleurope           #afd       #tvduell 
##              5              4              3              2              2 
##     #nowschulz  #eudebate2014            #rt        #ee2014          #riga 
##              1              1              1              1              1 
##   #teammartens        #eu2014  #caraacaratve           #ppe        #votapp 
##              1              1              1              1              1 
##    #votacanete #publicviewing     #tvduell's        #euhaus          #eu14 
##              1              1              1              1              1 
##    #europawahl        #berlin         #linke        #merkel       #gabriel 
##              1              1              1              1              1 
##     #wahlarena 
##              1
```

Further analysis examples
-------------------------

Wordscores:

``` r
data(data_corpus_amicus, package = "quanteda.corpora")
refs <- docvars(data_corpus_amicus, "trainclass")
refs <- (as.numeric(refs) - 1.5)*2
amicusDfm <- dfm(data_corpus_amicus)
wm <- textmodel_wordscores(amicusDfm, y = refs)
summary(wm)
## 
## Call:
## textmodel_wordscores.dfm(x = amicusDfm, y = refs)
## 
## Reference Document Statistics:
##           score total min  max    mean median
## sP1.txt      -1 13878   0  973 0.61285      0
## sP2.txt      -1 15715   0  983 0.69397      0
## sR1.txt       1 16144   0 1040 0.71292      0
## sR2.txt       1 14359   0  838 0.63409      0
## sAP01.txt    NA  7795   0  409 0.34423      0
## sAP02.txt    NA  8545   0  560 0.37735      0
## sAP03.txt    NA 10007   0  620 0.44191      0
## sAP04.txt    NA  6119   0  395 0.27021      0
## sAP05.txt    NA  9131   0  572 0.40322      0
## sAP06.txt    NA  6310   0  339 0.27865      0
## sAP07.txt    NA  5979   0  360 0.26403      0
## sAP08.txt    NA  2112   0  121 0.09327      0
## sAP09.txt    NA  5663   0  305 0.25008      0
## sAP10.txt    NA  5262   0  317 0.23237      0
## sAP11.txt    NA  7604   0  439 0.33579      0
## sAP12.txt    NA  9189   0  554 0.40578      0
## sAP13.txt    NA  6941   0  468 0.30651      0
## sAP14.txt    NA  7759   0  496 0.34264      0
## sAP15.txt    NA  7869   0  451 0.34749      0
## sAP16.txt    NA  4754   0  280 0.20994      0
## sAP17.txt    NA  6478   0  380 0.28607      0
## sAP18.txt    NA  5124   0  257 0.22628      0
## sAP19.txt    NA  4286   0  285 0.18927      0
## sAR01.txt    NA  2665   0  168 0.11769      0
## sAR02.txt    NA  9914   0  718 0.43780      0
## sAR03.txt    NA  9491   0  635 0.41912      0
## sAR04.txt    NA  9670   0  518 0.42703      0
## sAR05.txt    NA  9422   0  667 0.41607      0
## sAR06.txt    NA 11363   0  813 0.50179      0
## sAR07.txt    NA 10491   0  580 0.46328      0
## sAR08.txt    NA  8601   0  570 0.37982      0
## sAR09.txt    NA  6803   0  410 0.30042      0
## sAR10.txt    NA 10364   0  697 0.45767      0
## sAR11.txt    NA 10754   0  611 0.47490      0
## sAR12.txt    NA  4960   0  275 0.21903      0
## sAR13.txt    NA 10433   0  717 0.46072      0
## sAR14.txt    NA  7490   0  466 0.33076      0
## sAR15.txt    NA 10191   0  568 0.45003      0
## sAR16.txt    NA  8413   0  548 0.37152      0
## sAR17.txt    NA  9154   0  567 0.40424      0
## sAR18.txt    NA  9759   0  607 0.43096      0
## sAR19.txt    NA  6294   0  362 0.27794      0
## sAR20.txt    NA 11129   0  775 0.49146      0
## sAR21.txt    NA  6271   0  424 0.27693      0
## sAR22.txt    NA  9375   0  565 0.41400      0
## sAR23.txt    NA  8728   0  527 0.38543      0
## sAR24.txt    NA  9737   0  567 0.42998      0
## sAR25.txt    NA  8516   0  451 0.37607      0
## sAR26.txt    NA  9966   0  583 0.44010      0
## sAR27.txt    NA  9881   0  559 0.43634      0
## sAR28.txt    NA  7061   0  392 0.31181      0
## sAR29.txt    NA 10091   0  656 0.44562      0
## sAR30.txt    NA  7963   0  598 0.35164      0
## sAR31.txt    NA  8998   0  634 0.39735      0
## sAR32.txt    NA  9076   0  632 0.40079      0
## sAR33.txt    NA 10213   0  537 0.45100      0
## sAR34.txt    NA  8060   0  456 0.35593      0
## sAR35.txt    NA  8973   0  530 0.39625      0
## sAR36.txt    NA  2677   0  154 0.11822      0
## sAR37.txt    NA  8097   0  497 0.35756      0
## sAR38.txt    NA  8239   0  435 0.36383      0
## sAR39.txt    NA  8443   0  453 0.37284      0
## sAR40.txt    NA  9927   0  538 0.43837      0
## sAR41.txt    NA  8700   0  518 0.38419      0
## sAR42.txt    NA  3067   0  219 0.13544      0
## sAR43.txt    NA  8528   0  420 0.37660      0
## sAR44.txt    NA 11769   0  680 0.51972      0
## sAR45.txt    NA  9297   0  592 0.41055      0
## sAR46.txt    NA 10248   0  606 0.45255      0
## sAR47.txt    NA  2266   0  116 0.10007      0
## sAR48.txt    NA  5251   0  264 0.23188      0
## sAR49.txt    NA  8401   0  451 0.37099      0
## sAR50.txt    NA  8200   0  452 0.36211      0
## sAR51.txt    NA  4096   0  233 0.18088      0
## sAR52.txt    NA  9528   0  562 0.42076      0
## sAR53.txt    NA  5343   0  344 0.23595      0
## sAR54.txt    NA 10514   0  692 0.46430      0
## sAR55.txt    NA   240   0   17 0.01060      0
## sAR56.txt    NA  9396   0  563 0.41493      0
## sAR58.txt    NA  4923   0  379 0.21740      0
## sAR59.txt    NA  6729   0  411 0.29715      0
## sAR60.txt    NA  7972   0  446 0.35204      0
## sAR61.txt    NA  7266   0  526 0.32087      0
## sAR62.txt    NA  4790   0  290 0.21153      0
## sAR63.txt    NA  5390   0  284 0.23802      0
## sAR64.txt    NA 10472   0  623 0.46244      0
## sAR65.txt    NA 10716   0  617 0.47322      0
## sAR66.txt    NA  8143   0  474 0.35959      0
## sAR67.txt    NA  5960   0  308 0.26319      0
## sAR68.txt    NA  7683   0  452 0.33928      0
## sAR71.txt    NA  9540   0  595 0.42129      0
## sAR72.txt    NA  7498   0  516 0.33111      0
## sAR73.txt    NA  8582   0  453 0.37898      0
## sAR74.txt    NA  3626   0  213 0.16012      0
## sAR75.txt    NA  7560   0  502 0.33385      0
## sAR76.txt    NA  5924   0  404 0.26160      0
## sAR77.txt    NA  5312   0  307 0.23458      0
## sAR78.txt    NA  3091   0  193 0.13650      0
## sAR79.txt    NA  5303   0  281 0.23418      0
## sAR80.txt    NA  7397   0  572 0.32665      0
## sAR81.txt    NA  2742   0  128 0.12109      0
## sAR83.txt    NA  6115   0  348 0.27004      0
## 
## Wordscores:
## (showing first 30 elements)
##         in   granting          a     strong preference admissions 
##   0.047853  -0.540637  -0.042990   0.522223  -0.820373  -0.130065 
##         to applicants       from     select      group         of 
##   0.023612   0.103039  -0.105820  -0.045440  -0.407826   0.050707 
##     racial        and     ethnic minorities          ,        the 
##  -0.628995   0.180073  -0.700242  -0.208520   0.028571   0.005564 
##        law     school    invokes         an   interest       that 
##  -0.268321  -0.046736  -1.000000  -0.134417  -0.653693   0.009562 
##      court        has      never   accepted         as compelling 
##   0.013899  -0.095673  -0.084363  -0.468231  -0.085846  -0.554968
preds <- predict(wm, newdata = amicusDfm)
summary(preds)
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.20673  0.02659  0.07694  0.05667  0.09922  0.23308
plot(preds ~ docvars(amicusDfm, "testclass"),
     horizontal = TRUE, xlab = "Predicted document score",
     ylab = "Test class", las = 1)
```

![](advanced_files/figure-markdown_github/unnamed-chunk-6-1.png)

Correspondence analysis:

``` r
dfm(data_corpus_irishbudget2010) %>%
    textmodel_ca() %>% 
    textplot_scale1d()
```

![](advanced_files/figure-markdown_github/unnamed-chunk-7-1.png)

Poisson scaling:

``` r
ieWF <- dfm(data_corpus_irishbudget2010, remove_punct = TRUE) %>%
    textmodel_wordfish(dir = c(6,5))
summary(ieWF)
## 
## Call:
## textmodel_wordfish.dfm(x = ., dir = c(6, 5))
## 
## Estimated Document Positions:
##                                          theta      se
## 2010_BUDGET_01_Brian_Lenihan_FF        1.79444 0.02010
## 2010_BUDGET_02_Richard_Bruton_FG      -0.61774 0.02844
## 2010_BUDGET_03_Joan_Burton_LAB        -1.14741 0.01561
## 2010_BUDGET_04_Arthur_Morgan_SF       -0.08380 0.02900
## 2010_BUDGET_05_Brian_Cowen_FF          1.77416 0.02333
## 2010_BUDGET_06_Enda_Kenny_FG          -0.75762 0.02642
## 2010_BUDGET_07_Kieran_ODonnell_FG     -0.48645 0.04310
## 2010_BUDGET_08_Eamon_Gilmore_LAB      -0.59455 0.02991
## 2010_BUDGET_09_Michael_Higgins_LAB    -0.99302 0.04021
## 2010_BUDGET_10_Ruairi_Quinn_LAB       -0.90657 0.04267
## 2010_BUDGET_11_John_Gormley_Green      1.18326 0.07235
## 2010_BUDGET_12_Eamon_Ryan_Green        0.17248 0.06336
## 2010_BUDGET_13_Ciaran_Cuffe_Green      0.72229 0.07269
## 2010_BUDGET_14_Caoimhghin_OCaolain_SF -0.05949 0.03873
## 
## Estimated Feature Scores:
##         when      i presented    the supplementary  budget     to  this
## beta -0.1558 0.3217    0.3582 0.1945         1.077 0.03563 0.3097 0.249
## psi   1.6246 2.7253   -1.7925 5.3324        -1.128 2.71082 4.5208 3.462
##       house   last   april    said     we   could   work    our    way
## beta 0.1461 0.2416 -0.1554 -0.8301 0.4193 -0.6067 0.5262 0.6918 0.2772
## psi  1.0407 0.9874 -0.5725 -0.4533 3.5140  1.0865 1.1164 2.5301 1.4208
##      through  period     of severe economic distress  today    can  report
## beta  0.6125  0.4989 0.2792  1.229   0.4245    1.804 0.0922 0.3057  0.6257
## psi   1.1636 -0.1747 4.4675 -2.007   1.5741   -4.457 0.8399 1.5663 -0.2466
##        that notwithstanding difficulties   past
## beta 0.0192           1.804        1.176 0.4777
## psi  3.8389          -4.457       -1.352 0.9339
textplot_scale1d(ieWF)
```

![](advanced_files/figure-markdown_github/unnamed-chunk-8-1.png)

Topic models:

``` r
require(topicmodels)
## Loading required package: topicmodels
mycorpus <- corpus_subset(data_corpus_inaugural, Year > 1950)
quantdfm <- dfm(mycorpus, verbose = FALSE, remove_punct = TRUE,
                remove = c(stopwords('english'), 'will', 'us', 'nation', 'can', 'peopl*', 'americ*'))
ldadfm <- convert(quantdfm, to = "topicmodels")
lda <- LDA(ldadfm, control = list(alpha = 0.1), k = 20)
terms(lda, 10)
##       Topic 1   Topic 2      Topic 3          Topic 4    Topic 5  
##  [1,] "free"    "new"        "peace"          "citizens" "great"  
##  [2,] "must"    "good"       "let"            "country"  "world"  
##  [3,] "freedom" "free"       "world"          "story"    "hand"   
##  [4,] "faith"   "work"       "responsibility" "must"     "friends"
##  [5,] "peace"   "like"       "great"          "every"    "mr"     
##  [6,] "world"   "must"       "abroad"         "new"      "day"    
##  [7,] "shall"   "government" "role"           "know"     "make"   
##  [8,] "know"    "made"       "shall"          "freedom"  "today"  
##  [9,] "hold"    "ask"        "history"        "promise"  "things" 
## [10,] "upon"    "part"       "make"           "common"   "word"   
##       Topic 6    Topic 7   Topic 8      Topic 9    Topic 10   Topic 11
##  [1,] "world"    "freedom" "government" "world"    "world"    "world" 
##  [2,] "must"     "liberty" "must"       "strength" "peace"    "must"  
##  [3,] "history"  "must"    "believe"    "faith"    "let"      "today" 
##  [4,] "one"      "one"     "world"      "life"     "know"     "new"   
##  [5,] "time"     "every"   "one"        "upon"     "make"     "change"
##  [6,] "progress" "world"   "time"       "peace"    "earth"    "let"   
##  [7,] "now"      "human"   "freedom"    "men"      "now"      "time"  
##  [8,] "security" "know"    "work"       "shall"    "new"      "work"  
##  [9,] "yet"      "country" "man"        "nations"  "together" "fellow"
## [10,] "human"    "time"    "let"        "country"  "voices"   "idea"  
##       Topic 12 Topic 13     Topic 14  Topic 15     Topic 16   Topic 17  
##  [1,] "new"    "government" "change"  "new"        "new"      "must"    
##  [2,] "must"   "freedom"    "must"    "together"   "let"      "time"    
##  [3,] "every"  "one"        "man"     "world"      "century"  "still"   
##  [4,] "less"   "new"        "union"   "let"        "world"    "together"
##  [5,] "let"    "god"        "world"   "spirit"     "time"     "journey" 
##  [6,] "work"   "peace"      "old"     "government" "every"    "now"     
##  [7,] "world"  "together"   "land"    "just"       "citizens" "act"     
##  [8,] "time"   "now"        "every"   "strength"   "land"     "new"     
##  [9,] "today"  "world"      "liberty" "respect"    "fellow"   "complete"
## [10,] "common" "weapons"    "justice" "strong"     "one"      "today"   
##       Topic 18  Topic 19   Topic 20 
##  [1,] "country" "must"     "may"    
##  [2,] "one"     "every"    "world"  
##  [3,] "every"   "country"  "nations"
##  [4,] "world"   "believe"  "peace"  
##  [5,] "great"   "equal"    "freedom"
##  [6,] "new"     "god"      "seek"   
##  [7,] "never"   "requires" "must"   
##  [8,] "now"     "citizens" "upon"   
##  [9,] "back"    "years"    "help"   
## [10,] "make"    "just"     "justice"
```

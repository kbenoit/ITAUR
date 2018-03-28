# Introduction and Workflow

### Kenneth Benoit

### Date: 20 April 2017

This file demonstrates a basic workflow to take some pre-loaded texts
and perform elementary text analysis tasks quickly. The `quanteda`
packages comes with a built-in set of inaugural addresses from US
Presidents. We begin by loading quanteda and examining these texts. The
`summary` command will output the name of each text along with the
number of types, tokens and sentences contained in the text. Below we
use R’s indexing syntax to selectivly use the summary command on the
first five texts.

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

summary(data_corpus_inaugural)
## Corpus consisting of 58 documents:
## 
##             Text Types Tokens Sentences Year  President       FirstName
##  1789-Washington   625   1538        23 1789 Washington          George
##  1793-Washington    96    147         4 1793 Washington          George
##       1797-Adams   826   2578        37 1797      Adams            John
##   1801-Jefferson   717   1927        41 1801  Jefferson          Thomas
##   1805-Jefferson   804   2381        45 1805  Jefferson          Thomas
##     1809-Madison   535   1263        21 1809    Madison           James
##     1813-Madison   541   1302        33 1813    Madison           James
##      1817-Monroe  1040   3680       121 1817     Monroe           James
##      1821-Monroe  1259   4886       129 1821     Monroe           James
##       1825-Adams  1003   3152        74 1825      Adams     John Quincy
##     1829-Jackson   517   1210        25 1829    Jackson          Andrew
##     1833-Jackson   499   1269        29 1833    Jackson          Andrew
##    1837-VanBuren  1315   4165        95 1837  Van Buren          Martin
##    1841-Harrison  1896   9144       210 1841   Harrison   William Henry
##        1845-Polk  1334   5193       153 1845       Polk      James Knox
##      1849-Taylor   496   1179        22 1849     Taylor         Zachary
##      1853-Pierce  1165   3641       104 1853     Pierce        Franklin
##    1857-Buchanan   945   3086        89 1857   Buchanan           James
##     1861-Lincoln  1075   4006       135 1861    Lincoln         Abraham
##     1865-Lincoln   360    776        26 1865    Lincoln         Abraham
##       1869-Grant   485   1235        40 1869      Grant      Ulysses S.
##       1873-Grant   552   1475        43 1873      Grant      Ulysses S.
##       1877-Hayes   831   2716        59 1877      Hayes   Rutherford B.
##    1881-Garfield  1021   3212       111 1881   Garfield        James A.
##   1885-Cleveland   676   1820        44 1885  Cleveland          Grover
##    1889-Harrison  1352   4722       157 1889   Harrison        Benjamin
##   1893-Cleveland   821   2125        58 1893  Cleveland          Grover
##    1897-McKinley  1232   4361       130 1897   McKinley         William
##    1901-McKinley   854   2437       100 1901   McKinley         William
##   1905-Roosevelt   404   1079        33 1905  Roosevelt        Theodore
##        1909-Taft  1437   5822       159 1909       Taft  William Howard
##      1913-Wilson   658   1882        68 1913     Wilson         Woodrow
##      1917-Wilson   549   1656        59 1917     Wilson         Woodrow
##     1921-Harding  1169   3721       148 1921    Harding       Warren G.
##    1925-Coolidge  1220   4440       196 1925   Coolidge          Calvin
##      1929-Hoover  1090   3865       158 1929     Hoover         Herbert
##   1933-Roosevelt   743   2062        85 1933  Roosevelt     Franklin D.
##   1937-Roosevelt   725   1997        96 1937  Roosevelt     Franklin D.
##   1941-Roosevelt   526   1544        68 1941  Roosevelt     Franklin D.
##   1945-Roosevelt   275    647        26 1945  Roosevelt     Franklin D.
##      1949-Truman   781   2513       116 1949     Truman        Harry S.
##  1953-Eisenhower   900   2757       119 1953 Eisenhower       Dwight D.
##  1957-Eisenhower   621   1931        92 1957 Eisenhower       Dwight D.
##     1961-Kennedy   566   1566        52 1961    Kennedy         John F.
##     1965-Johnson   568   1723        93 1965    Johnson   Lyndon Baines
##       1969-Nixon   743   2437       103 1969      Nixon Richard Milhous
##       1973-Nixon   544   2012        68 1973      Nixon Richard Milhous
##      1977-Carter   527   1376        52 1977     Carter           Jimmy
##      1981-Reagan   902   2790       128 1981     Reagan          Ronald
##      1985-Reagan   925   2921       123 1985     Reagan          Ronald
##        1989-Bush   795   2681       141 1989       Bush          George
##     1993-Clinton   642   1833        81 1993    Clinton            Bill
##     1997-Clinton   773   2449       111 1997    Clinton            Bill
##        2001-Bush   621   1808        97 2001       Bush       George W.
##        2005-Bush   773   2319       100 2005       Bush       George W.
##       2009-Obama   938   2711       110 2009      Obama          Barack
##       2013-Obama   814   2317        88 2013      Obama          Barack
##       2017-Trump   582   1660        88 2017      Trump       Donald J.
## 
## Source: Gerhard Peters and John T. Woolley. The American Presidency Project.
## Created: Tue Jun 13 14:51:47 2017
## Notes: http://www.presidency.ucsb.edu/inaugurals.php
summary(data_corpus_inaugural[1:5])
##    Length     Class      Mode 
##         5 character character

data_corpus_inaugural[1]
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            1789-Washington 
## "Fellow-Citizens of the Senate and of the House of Representatives:\n\nAmong the vicissitudes incident to life no event could have filled me with greater anxieties than that of which the notification was transmitted by your order, and received on the 14th day of the present month. On the one hand, I was summoned by my Country, whose voice I can never hear but with veneration and love, from a retreat which I had chosen with the fondest predilection, and, in my flattering hopes, with an immutable decision, as the asylum of my declining years -- a retreat which was rendered every day more necessary as well as more dear to me by the addition of habit to inclination, and of frequent interruptions in my health to the gradual waste committed on it by time. On the other hand, the magnitude and difficulty of the trust to which the voice of my country called me, being sufficient to awaken in the wisest and most experienced of her citizens a distrustful scrutiny into his qualifications, could not but overwhelm with despondence one who (inheriting inferior endowments from nature and unpracticed in the duties of civil administration) ought to be peculiarly conscious of his own deficiencies. In this conflict of emotions all I dare aver is that it has been my faithful study to collect my duty from a just appreciation of every circumstance by which it might be affected. All I dare hope is that if, in executing this task, I have been too much swayed by a grateful remembrance of former instances, or by an affectionate sensibility to this transcendent proof of the confidence of my fellow citizens, and have thence too little consulted my incapacity as well as disinclination for the weighty and untried cares before me, my error will be palliated by the motives which mislead me, and its consequences be judged by my country with some share of the partiality in which they originated.\n\nSuch being the impressions under which I have, in obedience to the public summons, repaired to the present station, it would be peculiarly improper to omit in this first official act my fervent supplications to that Almighty Being who rules over the universe, who presides in the councils of nations, and whose providential aids can supply every human defect, that His benediction may consecrate to the liberties and happiness of the people of the United States a Government instituted by themselves for these essential purposes, and may enable every instrument employed in its administration to execute with success the functions allotted to his charge. In tendering this homage to the Great Author of every public and private good, I assure myself that it expresses your sentiments not less than my own, nor those of my fellow citizens at large less than either. No people can be bound to acknowledge and adore the Invisible Hand which conducts the affairs of men more than those of the United States. Every step by which they have advanced to the character of an independent nation seems to have been distinguished by some token of providential agency; and in the important revolution just accomplished in the system of their united government the tranquil deliberations and voluntary consent of so many distinct communities from which the event has resulted can not be compared with the means by which most governments have been established without some return of pious gratitude, along with an humble anticipation of the future blessings which the past seem to presage. These reflections, arising out of the present crisis, have forced themselves too strongly on my mind to be suppressed. You will join with me, I trust, in thinking that there are none under the influence of which the proceedings of a new and free government can more auspiciously commence.\n\nBy the article establishing the executive department it is made the duty of the President \"to recommend to your consideration such measures as he shall judge necessary and expedient.\" The circumstances under which I now meet you will acquit me from entering into that subject further than to refer to the great constitutional charter under which you are assembled, and which, in defining your powers, designates the objects to which your attention is to be given. It will be more consistent with those circumstances, and far more congenial with the feelings which actuate me, to substitute, in place of a recommendation of particular measures, the tribute that is due to the talents, the rectitude, and the patriotism which adorn the characters selected to devise and adopt them. In these honorable qualifications I behold the surest pledges that as on one side no local prejudices or attachments, no separate views nor party animosities, will misdirect the comprehensive and equal eye which ought to watch over this great assemblage of communities and interests, so, on another, that the foundation of our national policy will be laid in the pure and immutable principles of private morality, and the preeminence of free government be exemplified by all the attributes which can win the affections of its citizens and command the respect of the world. I dwell on this prospect with every satisfaction which an ardent love for my country can inspire, since there is no truth more thoroughly established than that there exists in the economy and course of nature an indissoluble union between virtue and happiness; between duty and advantage; between the genuine maxims of an honest and magnanimous policy and the solid rewards of public prosperity and felicity; since we ought to be no less persuaded that the propitious smiles of Heaven can never be expected on a nation that disregards the eternal rules of order and right which Heaven itself has ordained; and since the preservation of the sacred fire of liberty and the destiny of the republican model of government are justly considered, perhaps, as deeply, as finally, staked on the experiment entrusted to the hands of the American people.\n\nBesides the ordinary objects submitted to your care, it will remain with your judgment to decide how far an exercise of the occasional power delegated by the fifth article of the Constitution is rendered expedient at the present juncture by the nature of objections which have been urged against the system, or by the degree of inquietude which has given birth to them. Instead of undertaking particular recommendations on this subject, in which I could be guided by no lights derived from official opportunities, I shall again give way to my entire confidence in your discernment and pursuit of the public good; for I assure myself that whilst you carefully avoid every alteration which might endanger the benefits of an united and effective government, or which ought to await the future lessons of experience, a reverence for the characteristic rights of freemen and a regard for the public harmony will sufficiently influence your deliberations on the question how far the former can be impregnably fortified or the latter be safely and advantageously promoted.\n\nTo the foregoing observations I have one to add, which will be most properly addressed to the House of Representatives. It concerns myself, and will therefore be as brief as possible. When I was first honored with a call into the service of my country, then on the eve of an arduous struggle for its liberties, the light in which I contemplated my duty required that I should renounce every pecuniary compensation. From this resolution I have in no instance departed; and being still under the impressions which produced it, I must decline as inapplicable to myself any share in the personal emoluments which may be indispensably included in a permanent provision for the executive department, and must accordingly pray that the pecuniary estimates for the station in which I am placed may during my continuance in it be limited to such actual expenditures as the public good may be thought to require.\n\nHaving thus imparted to you my sentiments as they have been awakened by the occasion which brings us together, I shall take my present leave; but not without resorting once more to the benign Parent of the Human Race in humble supplication that, since He has been pleased to favor the American people with opportunities for deliberating in perfect tranquillity, and dispositions for deciding with unparalleled unanimity on a form of government for the security of their union and the advancement of their happiness, so His divine blessing may be equally conspicuous in the enlarged views, the temperate consultations, and the wise measures on which the success of this Government must depend. "
cat(data_corpus_inaugural[2])
## Fellow citizens, I am again called upon by the voice of my country to execute the functions of its Chief Magistrate. When the occasion proper for it shall arrive, I shall endeavor to express the high sense I entertain of this distinguished honor, and of the confidence which has been reposed in me by the people of united America.
## 
## Previous to the execution of any official act of the President the Constitution requires an oath of office. This oath I am now about to take, and in your presence: That if it shall be found during my administration of the Government I have in any instance violated willingly or knowingly the injunctions thereof, I may (besides incurring constitutional punishment) be subject to the upbraidings of all who are now witnesses of the present solemn ceremony.
## 
## 

ndoc(data_corpus_inaugural)
## [1] 58
docnames(data_corpus_inaugural)
##  [1] "1789-Washington" "1793-Washington" "1797-Adams"     
##  [4] "1801-Jefferson"  "1805-Jefferson"  "1809-Madison"   
##  [7] "1813-Madison"    "1817-Monroe"     "1821-Monroe"    
## [10] "1825-Adams"      "1829-Jackson"    "1833-Jackson"   
## [13] "1837-VanBuren"   "1841-Harrison"   "1845-Polk"      
## [16] "1849-Taylor"     "1853-Pierce"     "1857-Buchanan"  
## [19] "1861-Lincoln"    "1865-Lincoln"    "1869-Grant"     
## [22] "1873-Grant"      "1877-Hayes"      "1881-Garfield"  
## [25] "1885-Cleveland"  "1889-Harrison"   "1893-Cleveland" 
## [28] "1897-McKinley"   "1901-McKinley"   "1905-Roosevelt" 
## [31] "1909-Taft"       "1913-Wilson"     "1917-Wilson"    
## [34] "1921-Harding"    "1925-Coolidge"   "1929-Hoover"    
## [37] "1933-Roosevelt"  "1937-Roosevelt"  "1941-Roosevelt" 
## [40] "1945-Roosevelt"  "1949-Truman"     "1953-Eisenhower"
## [43] "1957-Eisenhower" "1961-Kennedy"    "1965-Johnson"   
## [46] "1969-Nixon"      "1973-Nixon"      "1977-Carter"    
## [49] "1981-Reagan"     "1985-Reagan"     "1989-Bush"      
## [52] "1993-Clinton"    "1997-Clinton"    "2001-Bush"      
## [55] "2005-Bush"       "2009-Obama"      "2013-Obama"     
## [58] "2017-Trump"

nchar(data_corpus_inaugural[1:7])
## 1789-Washington 1793-Washington      1797-Adams  1801-Jefferson 
##            8618             790           13876           10136 
##  1805-Jefferson    1809-Madison    1813-Madison 
##           12907            7000            7156
ntoken(data_corpus_inaugural[1:7])
## 1789-Washington 1793-Washington      1797-Adams  1801-Jefferson 
##            1538             147            2578            1927 
##  1805-Jefferson    1809-Madison    1813-Madison 
##            2381            1263            1302
ntoken(data_corpus_inaugural[1:7], remove_punct = TRUE)
## 1789-Washington 1793-Washington      1797-Adams  1801-Jefferson 
##            1430             135            2318            1726 
##  1805-Jefferson    1809-Madison    1813-Madison 
##            2166            1175            1210
ntype(data_corpus_inaugural[1:7])
## 1789-Washington 1793-Washington      1797-Adams  1801-Jefferson 
##             625              96             826             717 
##  1805-Jefferson    1809-Madison    1813-Madison 
##             804             535             541
```

One of the most fundamental text analysis tasks is tokenization. To
tokenize a text is to split it into units, most commonly words, which
can be counted and to form the basis of a quantitative analysis. The
quanteda package has a function for tokenization: `tokens`, which
constructs a **quanteda** tokens object consisting of the texts
segmented by their terms (and by default, other elements such as
punctuation, numbers, symbols, etc.). Examine the manual page at
`?tokens` for this details about this function:

``` r
?tokens
```

**quanteda**’s `tokens` function can be used on a simple character
vector, a vector of character vectors, or a corpus. Here are some
examples:

``` r
tokens("Today is Thursday in Canberra. It is yesterday in London.")
## tokens from 1 document.
## text1 :
##  [1] "Today"     "is"        "Thursday"  "in"        "Canberra" 
##  [6] "."         "It"        "is"        "yesterday" "in"       
## [11] "London"    "."

vec <- c(one = "This is text one", 
         two = "This, however, is the second text")
tokens(vec)
## tokens from 2 documents.
## one :
## [1] "This" "is"   "text" "one" 
## 
## two :
## [1] "This"    ","       "however" ","       "is"      "the"     "second" 
## [8] "text"
```

Consider the default arguments to the `tokens()` function. To remove
punctuation, you should set the `remove_punct` argument to be `TRUE`. We
can combine this with the `char_tolower()` function to get a cleaned and
tokenized version of our text.

``` r
tokens(char_tolower(vec), remove_punct = TRUE)
## tokens from 2 documents.
## one :
## [1] "this" "is"   "text" "one" 
## 
## two :
## [1] "this"    "however" "is"      "the"     "second"  "text"
```

The way that `char_tolower()` is named reflects the [logic of
**quanteda**’s function
grammar](http://quanteda.io/articles/pkgdown_only/design.html). The
first part (before the underscore `_`) names the both class of object
that is input to the function and is returned by the function. To
lowercase an R `character` class object, for instance, you use
`char_tolower()`, and to lowercase a **quanteda** `tokens` class object,
you use `tokens_tolower()`. Some object classes are defined in base R,
and some have been defined by packages that extend R’s functionality
(**quanteda** is one example – there are [well over 10,000 contributed
packages](https://cran.r-project.org/web/packages/) on the CRAN archive
alone. CRAN stands for Comprehensive R Archive Network and is where the
**quanteda** package is published.)

Using this function with the inaugural addresses:

``` r
inaugTokens <- tokens(data_corpus_inaugural, remove_punct = TRUE)
tokens_tolower(inaugTokens[2])
## tokens from 1 document.
## 1793-Washington :
##   [1] "fellow"         "citizens"       "i"              "am"            
##   [5] "again"          "called"         "upon"           "by"            
##   [9] "the"            "voice"          "of"             "my"            
##  [13] "country"        "to"             "execute"        "the"           
##  [17] "functions"      "of"             "its"            "chief"         
##  [21] "magistrate"     "when"           "the"            "occasion"      
##  [25] "proper"         "for"            "it"             "shall"         
##  [29] "arrive"         "i"              "shall"          "endeavor"      
##  [33] "to"             "express"        "the"            "high"          
##  [37] "sense"          "i"              "entertain"      "of"            
##  [41] "this"           "distinguished"  "honor"          "and"           
##  [45] "of"             "the"            "confidence"     "which"         
##  [49] "has"            "been"           "reposed"        "in"            
##  [53] "me"             "by"             "the"            "people"        
##  [57] "of"             "united"         "america"        "previous"      
##  [61] "to"             "the"            "execution"      "of"            
##  [65] "any"            "official"       "act"            "of"            
##  [69] "the"            "president"      "the"            "constitution"  
##  [73] "requires"       "an"             "oath"           "of"            
##  [77] "office"         "this"           "oath"           "i"             
##  [81] "am"             "now"            "about"          "to"            
##  [85] "take"           "and"            "in"             "your"          
##  [89] "presence"       "that"           "if"             "it"            
##  [93] "shall"          "be"             "found"          "during"        
##  [97] "my"             "administration" "of"             "the"           
## [101] "government"     "i"              "have"           "in"            
## [105] "any"            "instance"       "violated"       "willingly"     
## [109] "or"             "knowingly"      "the"            "injunctions"   
## [113] "thereof"        "i"              "may"            "besides"       
## [117] "incurring"      "constitutional" "punishment"     "be"            
## [121] "subject"        "to"             "the"            "upbraidings"   
## [125] "of"             "all"            "who"            "are"           
## [129] "now"            "witnesses"      "of"             "the"           
## [133] "present"        "solemn"         "ceremony"
```

Here, we supplied one of the optional *arguments* to the `tokens()`
function: `remove_punct`. This functon takes a [“logical” type
value](https://stat.ethz.ch/R-manual/R-devel/library/base/html/logical.html)
(`TRUE` or `FALSE`) and specifies whether punctuation characters should
be removed or not. The help page for `tokens()`, which you can access
using the command `?tokens`, details all of the function arguments and
their valid values.

Every function in R and its contributed packages has a help page, and
this is the first place to look when examining a function. Well-written
help pages will also contain examples that you can run to see how a
function operates. For **quanteda**, the main functions also have help
pages with the results of executing their examples on
<http://quanteda.io/reference/>.

Returning to tokenization: Once each text has been split into words, we
can use the `dfm` function to create a matrix of counts of the
occurrences of each word in each document:

``` r
inaugDfm <- dfm(inaugTokens)
trimmedInaugDfm <- dfm_trim(inaugDfm, min_doc = 5, min_count = 10)
## Warning in dfm_trim.dfm(inaugDfm, min_doc = 5, min_count = 10): min_count
## is deprecated, use min_termfreq
weightedTrimmedDfm <- dfm_tfidf(trimmedInaugDfm)

require(magrittr)
## Loading required package: magrittr
inaugDfm2 <- dfm(inaugTokens) %>% 
    dfm_trim(min_doc = 5, min_count = 10) %>% 
        dfm_tfidf()
## Warning in dfm_trim.dfm(., min_doc = 5, min_count = 10): min_count is
## deprecated, use min_termfreq
```

Note that `dfm()` works on a variety of object types, including
character vectors, corpus objects, and tokenized text objects. This
gives the user maximum flexibility and power, while also making it easy
to achieve similar results by going directly from texts to a
document-by-feature matrix.

To see what objects for which any particular *method* (function) is
defined, you can use the `methods()` function:

``` r
methods(dfm)
## [1] dfm.character* dfm.corpus*    dfm.default*   dfm.dfm*      
## [5] dfm.tokens*   
## see '?methods' for accessing help and source code
```

Likewise, you can also figure out what methods are defined for any given
*class* of object, using the same function:

``` r
methods(class = "tokens")
##  [1] [                     [[                    [[<-                 
##  [4] [<-                   +                     $                    
##  [7] as.character          as.list               c                    
## [10] dfm                   docnames              docnames<-           
## [13] docvars               docvars<-             fcm                  
## [16] kwic                  lengths               metadoc              
## [19] ndoc                  nsentence             nsyllable            
## [22] ntoken                ntype                 phrase               
## [25] print                 textstat_collocations tokens_compound      
## [28] tokens_lookup         tokens_ngrams         tokens_replace       
## [31] tokens_segment        tokens_select         tokens_skipgrams     
## [34] tokens_subset         tokens_tolower        tokens_toupper       
## [37] tokens_wordstem       tokens                types                
## [40] unlist               
## see '?methods' for accessing help and source code
```

If we are interested in analysing the texts with respect to some other
variables, we can create a corpus object to associate the texts with
this metadata. For example, consider the last six inaugural addresses:

``` r
summary(data_corpus_inaugural[52:57])
##    Length     Class      Mode 
##         6 character character
```

We can use the `docvars` option to the `corpus` command to record the
party with which each text is associated:

``` r
dv <- data.frame(Party = c("dem", "dem", "rep", "rep", "dem", "dem"))
recentCorpus <- corpus(data_corpus_inaugural[52:57], docvars = dv)
summary(recentCorpus)
## Corpus consisting of 6 documents:
## 
##          Text Types Tokens Sentences Party
##  1993-Clinton   642   1833        81   dem
##  1997-Clinton   773   2449       111   dem
##     2001-Bush   621   1808        97   rep
##     2005-Bush   773   2319       100   rep
##    2009-Obama   938   2711       110   dem
##    2013-Obama   814   2317        88   dem
## 
## Source: /Users/kbenoit/GitHub/ITAUR/1_demo/* on x86_64 by kbenoit
## Created: Wed Mar 28 14:16:05 2018
## Notes:
```

We can use this metadata to combine features across documents when
creating a document-feature
matrix:

``` r
partyDfm <- dfm(recentCorpus, groups = "Party", remove = (stopwords("english")))
textplot_wordcloud(partyDfm, comparison = TRUE)
```

![](workflow_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

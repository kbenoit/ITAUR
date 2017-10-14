Manupulating text in R
======================

### Kenneth Benoit

### 27§ April 2017

In this section we will work through some basic string manipulation functions in R.

String handling in base R
-------------------------

There are several useful string manipulation functions in the R base library. In addition, we will look at the `stringr` package which provides an additional interface for simple text manipulation.

The fundamental type (or `mode`) in which R stores text is the character vector. The most simple case is a character vector of length one. The `nchar` function returns the number of characters in a character vector.

``` r
require(quanteda)
s1 <- 'my example text'
length(s1)
## [1] 1
nchar(s1)
## [1] 15
```

The `nchar` function is vectorized, meaning that when called on a vector it returns a value for each element of the vector.

``` r
s2 <- c('This is', 'my example text.', 'So imaginative.')
length(s2)
## [1] 3
nchar(s2)
## [1]  7 16 15
sum(nchar(s2))
## [1] 38
```

We can use this to answer some simple questions about the inaugural addresses.

Which were the longest and shortest speeches?

``` r
inaugTexts <- texts(data_corpus_inaugural)
which.max(nchar(inaugTexts))
## 1841-Harrison 
##            14
which.min(nchar(inaugTexts))
## 1793-Washington 
##               2
```

Unlike in some other programming languages, it is not possible to index into a "string" -- where a string is defined as a sequence of text characters -- in R:

``` r
s1 <- 'This file contains many fascinating example sentences.'
s1[6:9]
## [1] NA NA NA NA
```

To extract a substring, instead we use the `substr` function.

``` r
s1 <- 'This file contains many fascinating example sentences.'
substr(s1, 6,9)
## [1] "file"
```

Often we would like to split character vectors to extract a term of interest. This is possible using the `strsplit` function. Consider the names of the inaugural texts:

``` r
names(inaugTexts)
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
# returns a list of parts
s1 <- 'split this string'
strsplit(s1, 'this')
## [[1]]
## [1] "split "  " string"
parts <- strsplit(names(inaugTexts), '-')
years <- sapply(parts, function(x) x[1])
pres <-  sapply(parts, function(x) x[2])
```

The `paste` function is used to join character vectors together. The way in which the elements are combined depends on the values of the `sep` and `collapse` arguments:

``` r
paste('one', 'two', 'three')
## [1] "one two three"
paste('one', 'two', 'three', sep = '_')
## [1] "one_two_three"
paste(years, pres, sep = '-')
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
paste(years, pres, collapse = '-')
## [1] "1789 Washington-1793 Washington-1797 Adams-1801 Jefferson-1805 Jefferson-1809 Madison-1813 Madison-1817 Monroe-1821 Monroe-1825 Adams-1829 Jackson-1833 Jackson-1837 VanBuren-1841 Harrison-1845 Polk-1849 Taylor-1853 Pierce-1857 Buchanan-1861 Lincoln-1865 Lincoln-1869 Grant-1873 Grant-1877 Hayes-1881 Garfield-1885 Cleveland-1889 Harrison-1893 Cleveland-1897 McKinley-1901 McKinley-1905 Roosevelt-1909 Taft-1913 Wilson-1917 Wilson-1921 Harding-1925 Coolidge-1929 Hoover-1933 Roosevelt-1937 Roosevelt-1941 Roosevelt-1945 Roosevelt-1949 Truman-1953 Eisenhower-1957 Eisenhower-1961 Kennedy-1965 Johnson-1969 Nixon-1973 Nixon-1977 Carter-1981 Reagan-1985 Reagan-1989 Bush-1993 Clinton-1997 Clinton-2001 Bush-2005 Bush-2009 Obama-2013 Obama-2017 Trump"
```

`tolower` and `toupper` change the case of character vectors.

``` r
tolower(s1)
## [1] "split this string"
toupper(s1)
## [1] "SPLIT THIS STRING"
```

Character vectors can be compared using the `==` and `%in%` operators:

``` r
tolower(s1) == toupper(s1)
## [1] FALSE
'apples'=='oranges'
## [1] FALSE
tolower(s1) == tolower(s1)
## [1] TRUE
'pears' == 'pears'
## [1] TRUE

c1 <- c('apples', 'oranges', 'pears')
'pears' %in% c1
## [1] TRUE
c2 <- c('bananas', 'pears')
c2 %in% c1
## [1] FALSE  TRUE
```

The **stringi** and **stringr** packages
----------------------------------------

Note that quanteda has a special wrapper for changing case, called `char_tolower()`, which is better than the built-in `tolower()` and is defined for multiple objects:

``` r
require(quanteda)
tolower(c("This", "is", "Kεφαλαία Γράμματα"))
## [1] "this"              "is"                "kεφαλαία γράμματα"
methods(toLower)
## [1] toLower.character*      toLower.NULL*           toLower.tokenizedTexts*
## [4] toLower.tokens*        
## see '?methods' for accessing help and source code
```

Why is it better? It calls the [**stringi** package's](http://www.gagolewski.com/software/stringi/) (see more below) function `stri_trans_tolower()`, which is more sensitive to multi-byte encodings and the definition of case transformations for non-European languages (and even some "harder" European ones, such as Hungarian, which has characters not used in any other language).

For example, we could define a function to count vowels based on the `stringr::str_count()` function:

``` r
require(stringr)
## Loading required package: stringr
vCount <- function(inText) {
    vowels <- c('a', 'e', 'i', 'o', 'u')
    return(sum(str_count(inText, vowels)))
}
vCount('tts')
## [1] 0
```

Pattern matching and regular expressions
----------------------------------------

Matching texts based on generalized patterns is one of the most common, and the most useful, operations in text processing. The most powerful variant of these is known as a *regular expression*.

A regular expression (or "regex"" for short) is a special text string for describing a search pattern. You may have probably already used a simple form of regular expression, called a ["glob"](https://en.wikipedia.org/wiki/Glob_(programming)), that uses wildcards for pattern matching. For instance, `*.txt` in a command prompt or Terminal window will find all files ending in `.txt`. Regular expressions are like glob wildcards on steroids. The regex equivalent is `^.*\.txt$`. R even has a function to convert from glob expressions to regular expressions: `glob2rx()`.

In **quanteda**, all functions that take pattern matches allow [three types of matching](http://quanteda.io/reference/valuetype.html): fixed matching, where the match is exact and no wildcard characters are used; "glob" matching, which is simple but often sufficient for a user's needs; and regular expressions, which unleash the full power of highly sophisticated (but also complicated) pattern matches.

### Regular expressions in base R

The base R functions for searching and replacing within text are similar to familiar commands from the other text manipulation environments, `grep` and `gsub`. The `grep` manual page provides an overview of these functions.

The `grep` command tests whether a pattern occurs within a string:

``` r
grep('orangef', 'these are oranges')
## integer(0)
grep('pear', 'these are oranges')
## integer(0)
grep('orange', c('apples', 'oranges', 'pears'))
## [1] 2
grep('pears', c('apples', 'oranges', 'pears'))
## [1] 3
```

The `gsub` command substitutes one pattern for another within a string:

``` r
gsub('oranges', 'apples', 'these are oranges')
## [1] "these are apples"
```

### Regular expressions in **stringi** and **stringr**

The [**stringi** package](http://www.gagolewski.com/software/stringi/) is a large suite of character ("string") handling functions that are superior in almost every way to the equivalent base R functions. One reason that they are better lies in how they handle Unicode text, which includes character categories and covers all known languages. **stringi** boasts of being "THE R package for fast, correct, consistent, portable, as well as convenient string/text processing in every locale and any native character encoding". In this case, however, it's no idle boast. If you are serious about low-level text processing in R, you will want to spend time learning **stringi**. The **quanteda** package relies heavily on its functions.

A somewhat simpler-to-use package than **stringi** is the **stringr** package. It wraps many of **stringi**'s low level functions in more convenient wrappers, although with fewer options.
For an overview of the most frequently used functions, see the vignette: <https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html>.

#### Matching

Using some **stringr** functions, we can see more about how regular expression pattern matching works. In a regular expression, `.` means "any character". So using regular expressions with **stringr**, we have:

``` r
pattern <- "a.b"
strings <- c("abb", "a.b")
str_detect(strings, pattern)
## [1] TRUE TRUE
```

Some variations

``` r
# Regular expression variations
str_extract_all("The Cat in the Hat", "[a-z]+")
## [[1]]
## [1] "he"  "at"  "in"  "the" "at"
str_extract_all("The Cat in the Hat", regex("[a-z]+", TRUE))
## [[1]]
## [1] "The" "Cat" "in"  "the" "Hat"

str_extract_all("a\nb\nc", "^.")
## [[1]]
## [1] "a"
str_extract_all("a\nb\nc", regex("^.", multiline = TRUE))
## [[1]]
## [1] "a" "b" "c"

str_extract_all("a\nb\nc", "a.")
## [[1]]
## character(0)
str_extract_all("a\nb\nc", regex("a.", dotall = TRUE))
## [[1]]
## [1] "a\n"
```

#### Replacing

Besides extracting strings, we can also replace them:

``` r
fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-")
## [1] "-ne apple"     "tw- pears"     "thr-e bananas"
str_replace_all(fruits, "[aeiou]", "-")
## [1] "-n- -ppl-"     "tw- p--rs"     "thr-- b-n-n-s"

str_replace(fruits, "([aeiou])", "")
## [1] "ne apple"     "tw pears"     "thre bananas"
str_replace(fruits, "([aeiou])", "\\1\\1")
## [1] "oone apple"     "twoo pears"     "threee bananas"
str_replace(fruits, "[aeiou]", c("1", "2", "3"))
## [1] "1ne apple"     "tw2 pears"     "thr3e bananas"
str_replace(fruits, c("a", "e", "i"), "-")
## [1] "one -pple"     "two p-ars"     "three bananas"
```

#### Detecting

Functions also exist for word detection:

``` r
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "e")
## [1]  TRUE FALSE  TRUE  TRUE
fruit[str_detect(fruit, "e")]
## [1] "apple"    "pear"     "pinapple"
str_detect(fruit, "^a")
## [1]  TRUE FALSE FALSE FALSE
str_detect(fruit, "a$")
## [1] FALSE  TRUE FALSE FALSE
str_detect(fruit, "b")
## [1] FALSE  TRUE FALSE FALSE
str_detect(fruit, "[aeiou]")
## [1] TRUE TRUE TRUE TRUE

# Also vectorised over pattern
str_detect("aecfg", letters)
##  [1]  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
## [12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [23] FALSE FALSE FALSE FALSE
```

We can override the default regular expression matching using wrapper functions. See the difference in behaviour:

``` r
str_detect(strings, fixed(pattern))
## [1] FALSE  TRUE
str_detect(strings, coll(pattern))
## [1] FALSE  TRUE
```

#### Segmentation

We can also segment words by their boundary definitions, which is part of the Unicode definition. **quanteda** relies heavily on this for *tokenization*, which is the segmentation of texts into sub-units (normally, terms).

``` r
# Word boundaries
words <- c("These are   some words.")
str_count(words, boundary("word"))
## [1] 4
str_split(words, " ")[[1]]
## [1] "These"  "are"    ""       ""       "some"   "words."
str_split(words, boundary("word"))[[1]]
## [1] "These" "are"   "some"  "words"
```

#### Other operations

**stringr** can also be used to remove leading and trailing whitespace. "Whitespace" has an [extensive definition](http://www.fileformat.info/info/unicode/category/Zs/list.htm), but can be thought of in its most basic form as spaces (`" "`), tab characters (""), and newline characters (""). `str_trim()` will remove these:

``` r
str_trim("  String with trailing and leading white space\t")
## [1] "String with trailing and leading white space"
str_trim("\n\nString with trailing and leading white space\n\n")
## [1] "String with trailing and leading white space"
```

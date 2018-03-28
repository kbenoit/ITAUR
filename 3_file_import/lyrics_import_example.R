## Example from First Day of Class
## Thanks to Tobias for the files

require(quanteda)
require(readtext)

songcorp <- 
    readtext("3_file_import/Lyrics_2017-06-06.txt") %>%
    corpus() %>%
    corpus_segment()
summary(songcorp, 6)

songcorp2 <- corpus_subset(songcorp, pattern == "##LYRICS")
docvars(songcorp2, "Artist") <-
    texts(corpus_subset(songcorp, pattern == "##ARTIST"))
docvars(songcorp2, "Title") <-
    texts(corpus_subset(songcorp, pattern == "##SONG"))

# get rid of "tag" docvar
docvars(songcorp2, "tag") <- NULL

# name the documents something nicer
docnames(songcorp2) <- paste(
    docvars(songcorp2, "Artist"), 
    docvars(songcorp2, "Title"), sep = ", "
)

LIWCdict <- 
    dictionary(file = "~/Dropbox/QUANTESS/dictionaries/LIWC/LIWC2001_German_UTF8.dic")
LIWCdfm <- dfm(songcorp2, dictionary = LIWCdict, verbose = TRUE)






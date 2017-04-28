require(stringr)

## read in the files
require(readtext)
tfile <- readtext("presdebates.zip",
                  docvarsfrom = "filenames",
                  docvarnames = c("del1", "del2", "party", "date", "city"))

# tidy up some of the labels
tfile$text <- paste("DELETEME:", tfile$text)
tfile$text <- str_replace_all(tfile$text, "Citation:", "CITATION:")
tfile$text <- str_replace_all(tfile$text, "O'\\s*MALLEY", "O'MALLEY")

# tidy up the metadata
tfile$del1 <- tfile$del2 <- NULL
tfile$date <- as.Date(tfile$date)
tfile$party <- factor(tfile$party)
rownames(tfile) <- paste(str_sub(tfile$party, start = 1, end = 3), 
                         tfile$date, sep = "_")
tfile

## create the corpus
require(quanteda)
presDebateCorpus2016 <- 
    corpus(tfile, metacorpus = list(source = "American Presidency Project"))
summary(presDebateCorpus2016)

## segment the corpus
presDebateCorpus2016seg <- 
    corpus_segment(presDebateCorpus2016, what = "tags", 
                   delimiter = "\\b([[:upper:]]\\w{0,1})*(\\s|')*[[:upper:]]{2,}:\\s+")
# clean up the tags
docvars(presDebateCorpus2016seg, "tag") <- 
    str_replace_all(docvars(presDebateCorpus2016seg, "tag"), "\\p{P}", "") %>%
    str_trim()
table(docvars(presDebateCorpus2016seg, "tag"))
# get rid of some meaningless tags
presDebateCorpus2016seg <- 
    corpus_subset(presDebateCorpus2016seg, !(tag %in% c("DELETEME", "PARTICIPANTS", "CITATION")))

# get the moderator names from the moderators field
moderatorNamesDfm <- 
moderatorNames <- 
    corpus_subset(presDebateCorpus2016seg, tag %in% c("MODERATORS")) %>% 
    dfm(remove_punct = TRUE, tolower = FALSE) %>%
    featnames() %>%
    char_toupper() %>%
    sort()
panelistNamesDfm <- 
    corpus_subset(presDebateCorpus2016seg, tag %in% c("PANELISTS"))  %>% 
    dfm(remove_punct = TRUE, tolower = FALSE) %>%
    featnames() %>%
    char_toupper()

# add new document variables for speaker
presDebateCorpus2016seg[["speakertype"]] <- 
    ifelse(docvars(presDebateCorpus2016seg, "tag") %in% moderatorNames, "moderator", 
           ifelse(docvars(presDebateCorpus2016seg, "tag") %in% panelistNames, "panelist", 
                  "candidate"))
docvars(presDebateCorpus2016seg, "speakertype")[docvars(presDebateCorpus2016seg, "tag") == "ANNOUNCER"] <- "announcer"
docvars(presDebateCorpus2016seg, "speakertype")[docvars(presDebateCorpus2016seg, "tag") == "AUDIENCE"] <- "audience"

docvars(presDebateCorpus2016seg, "speakertype")[grep("QUESTION|UNKNOWN|STUDENT|(FE)*MALE|AUDIENCE|UNIDENT.*(\\w(FE)*MALE){0,1}", 
                                                     docvars(presDebateCorpus2016seg, "tag"))] <- "other"

docvars(presDebateCorpus2016seg, "speakertype")[docvars(presDebateCorpus2016seg, "tag") %in% names(table(presDebateCorpus2016seg[["tag"]])[table(docvars(presDebateCorpus2016seg, "tag"))<=6])] <- "other"

# inspect
with(docvars(presDebateCorpus2016seg), table(tag, speakertype))

# remove MODERATOR* and PARTICIPANT* tags
presDebateCorpus2016seg <- 
    corpus_subset(presDebateCorpus2016seg, 
                  !str_detect(tag, c("^(MODERATOR|PARTICIPANT|PANELIST|UNIDENT|AUDIENCE|COLLEGE|announcer|audience)")))

# add some more "panelists"
docvars(presDebateCorpus2016seg, "speakertype")[docvars(presDebateCorpus2016seg, "tag") == "SANTELLI"] <- "panelist"
docvars(presDebateCorpus2016seg, "speakertype")[docvars(presDebateCorpus2016seg, "tag") == "WILKINS"] <- "panelist"
docvars(presDebateCorpus2016seg, "speakertype")[docvars(presDebateCorpus2016seg, "tag") == "HAM"] <- "panelist"

# inspect again
with(docvars(presDebateCorpus2016seg), table(tag, speakertype))

save(presDebateCorpus2016seg, file = "~/Dropbox/QUANTESS/corpora/Presidential Debates/presDebateCorpus2016seg.RData")

nonVerbal <- kwic(presDebateCorpus2016seg, "\\[ \\w+ \\]", valuetype = "regex")$keyword
table(nonVerbal)



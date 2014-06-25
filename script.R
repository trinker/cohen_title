library(qdap); library(RCurl)

cohen_url <- "https://raw.githubusercontent.com/trinker/cohen_title/master/data/Cohen1994.txt"
cohen <- getURL(cohen_url, ssl.verifypeer = FALSE)

## remove reference section and title
cohen <- substring(strsplit(cohen, "REFERENCES")[[c(1, 1)]], 34)

## convert format so we can eliminate strange characters
cohen <- iconv(cohen, "", "ASCII", "byte")

## replacement parts
bads <- c("-", "<e2><80><9c>", "<e2><80><9d>", "<e2><80><98>", 
    "<e2><80><99>", "<e2><80><9b>", "<ef><bc><87>", "<e2><80><a6>", 
    "<e2><80><93>", "<e2><80><94>", "<c3><a1>", "<c3><a9>", 
    "<c2><bd>", "<ef><ac><81>", "<c2><a7>", "<ef><ac><82>", 
    "<ef><ac><81>", "<c2><a2>", "/j")

goods <- c(" ", " ", " ", "'", "'", "'", "'", "...", " ", 
    " ", "a", "e", "half", "fi", " | ", "ff", "ff", " ", "ff")


cohen <- mgsub(bads, goods, clean(cohen))

## Find top words
cohen_stem <- stemmer(cohen)

cohen_top_20 <- freq_terms(cohen_stem, top = 20, stopwords = Top200Words)
plot(cohen_top_20)
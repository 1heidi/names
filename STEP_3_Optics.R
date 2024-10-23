## STEP 3 - Analyze Optic Classifications
## Package(s): tidyverse, ggplot2
## Input file(s): names_output_common_full.csv
## Output file(s): names_output_common_full_optics.csv, optics_agreement_2024-06-14.jpeg (figure 2)

library(tidyverse)
library(ggplot2)

## read file
o <- read.csv("names_output_common_full.csv")

## prep
o <-o %>% 
  mutate(across(where(is.character), str_trim))

## reorder data frame
o <- select(o, 1:3, 7:10, 4, 11:14, 5, 6)

## summarize counts for each coder
stat_count <- o %>% count(stat, sort = TRUE)
bio_count <- o %>% count(bio, sort = TRUE)

## calculate agreements for matrix
o <- o %>%
  mutate(optics_count = ifelse(test = (o$stat == "opaque" & o$bio == "opaque"),
    yes = sum(o$stat == "opaque" & o$bio == "opaque"),
    no = ifelse(test = (o$stat == "opaque" & o$bio == "translucent"),
      yes = sum(o$stat == "opaque" & o$bio == "translucent"),
      no = ifelse(test = (o$stat == "opaque" & o$bio == "transparent"),
        yes = sum(o$stat == "opaque" & o$bio == "transparent"),
        no = ifelse(test = (o$stat == "translucent" & o$bio == "opaque"),
         yes = sum(o$stat == "translucent" & o$bio == "opaque"),
         no = ifelse(test = (o$stat == "translucent" & o$bio == "translucent"),
           yes = sum(o$stat == "translucent" & o$bio == "translucent"),
           no = ifelse(test = (o$stat == "translucent" & o$bio == "transparent"),
             yes = sum(o$stat == "translucent" & o$bio == "transparent"),
             no = ifelse(test = (o$stat == "transparent" & o$bio == "opaque"),
               yes = sum(o$stat == "transparent" & o$bio == "opaque"),
               no = ifelse(test = (o$stat == "transparent" & o$bio == "translucent"),
                 yes = sum(o$stat == "transparent" & o$bio == "translucent"),
                 no = sum(o$stat == "transparent" & o$bio == "transparent"))))))))))
## save file
write.csv(o,"names_output_common_full_optics.csv", row.names = FALSE)

## plot agreement matrix
ggplot(data = o, aes(x=stat, y=bio, fill=optics_count)) + 
  geom_tile() +
  scale_fill_gradient(low = "white", high = "cyan3", limits=c(0, 1200)) + 
  geom_text(aes(label = optics_count)) +
  xlab("Statistician") +
  ylab("Biologist") +
  labs(fill='Data Resource Count') 
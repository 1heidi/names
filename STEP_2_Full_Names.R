## STEP 2 - Analyze Full Names
## Package(s): tidyverse, ggplot2
## Input file(s): names_output_common.csv
## Output file(s): names_output_common_full.csv, full_name_histogram_2024-06-14.jpeg (figure 3)

library(tidyverse)
library(ggplot2)

## read file
f <- read.csv("names_output_common.csv")

## prep

f <- f %>% 
  mutate(across(where(is.character), str_trim))

f$best_full <- str_to_lower(f$best_full)

## count number of words and extract first word, middle word(s), and last word

f <- f %>%
  mutate(full_first = word(f$best_full, 1)) %>%
  mutate(full_mid = word(f$best_full, 2  , -2)) %>%
  mutate(full_last = word(f$best_full, -1)) %>%
  mutate(full_word_count = str_count(f$best_full, "\\w+"))

## check summary stats for word counts
summary <- summary(f$full_word_count)
sd <- sd(f$full_word_count)
q1 <- quantile(f$full_word_count, 0.25)
q2 <- quantile(f$full_word_count, 0.5)
q3 <- quantile(f$full_word_count, 0.75)

## calculate frequencies
full_last_count <- f %>% count(full_last, sort = TRUE)
full_first_count <- f %>% count(full_first, sort = TRUE)
full_word_count <- f %>% count(full_word_count, sort = TRUE)

## save file
write.csv(f,"names_output_common_full.csv", row.names = FALSE)

## plot histogram
p <- ggplot(f, aes(x=full_word_count)) + geom_histogram(color="black", fill="white", bins=35, binwidth = 1) +
scale_x_continuous(breaks = seq(1, 15, 1), lim = c(1, 15)) +
  xlab("Number of Words in Full Name") +
  ylab("Data Resource Count")
p+ geom_vline(aes(xintercept=mean(full_word_count)),
  color="red", linetype="dashed", linewidth=1)

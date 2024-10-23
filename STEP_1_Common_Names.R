## STEP 1 - Analyze Common Names
## Package(s): tidyverse, ggplot2
## Input file(s): names_input.csv
## Output file(s): names_output_common.csv, common_name_histogram_2024-06-14.jpeg (figure 1)

library(tidyverse)
library(ggplot2)

## read file
c <- read.csv("names_input.csv")

## prep
c <- c %>% 
  mutate(across(where(is.character), str_trim))

c$best_common <- str_to_lower(c$best_common)

## count number of characters and extract first 3, last 3, and last 2 characters
c <- c %>%
  mutate(common_length = str_length(c$best_common)) %>%
  mutate(common_first_3 = str_sub(c$best_common, 1, 3)) %>%
  mutate(common_last_3 = str_sub(c$best_common, start= -3)) %>%
  mutate(common_last_2 = str_sub(c$best_common, start= -2))

## calculate frequencies
last_2_count <- c %>% count(common_last_2, sort = TRUE)
last_3_count <- c %>% count(common_last_3, sort = TRUE)
first_3_count <- c %>% count(common_first_3, sort = TRUE)
common_length_count <- c %>% count(common_length, sort = TRUE)

## check summary stats
summary <- summary(c$common_length)
sd <- sd(c$common_length)
q1 <- quantile(c$common_length, 0.25)
q2 <- quantile(c$common_length, 0.5)
q3 <- quantile(c$common_length, 0.75)
redun <- c %>% count(c$best_common, sort = TRUE)

## save file
write.csv(c,"names_output_common.csv", row.names = FALSE)

## plot histogram
p <- ggplot(c, aes(x=common_length)) + geom_histogram(color="black", fill="white", bins=3, binwidth = 1) +
scale_x_continuous(breaks = seq(1, 16, 1), lim = c(1, 16)) +
  xlab("Number of Characters in Common Name") +
  ylab("Data Resource Count")
p+ geom_vline(aes(xintercept=mean(common_length)),
  color="red", linetype="dashed", linewidth=1)


library(ggplot2)

dens <- density(c$common_length)
df <- data.frame(x=dens$x, y=dens$y)

quantiles <- quantile(dt$scores, prob=c(0.25, 0.5, 0.75))
df$quantile <- factor(findInterval(df$x, quantiles))
levels(df$quantile) <- c("<25%", "25%-50%", "50-75%", "75-100%")

cols <- c("red", "green", "blue", "purple")
names(cols) <- levels(df$quantile)

ggplot(df, aes(x, y)) + 
  geom_line() + 
  geom_ribbon(aes(ymin=0, ymax=y, fill=quantile), alpha = .2) + 
  scale_x_continuous(breaks = unname(quantiles), labels = scales::number) +
  scale_fill_manual(values = cols)

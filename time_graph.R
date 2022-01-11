# Install required packages:

library(readr)
library(tidyverse)

time <- read_delim("time_copy.txt", 
                        ";", escape_double = FALSE, trim_ws = TRUE)

# Get mean and sd:

sumdata= time %>% group_by(Function,Tools) %>% summarize(Mean=mean(Runtime),SD=sd(Runtime)) %>% ungroup() %>% mutate(Tools=fct_relevel(Tools, c("FAtools", "Seqmagick", "SeqTK","SeqKit")))


# Plot
ggplot(sumdata,aes(x=Tools,y=Mean,fill=Tools)) + geom_bar(stat='identity', color='black') + facet_wrap(~Function) + ylab("Runtime Mean (s)") + theme_classic() +   geom_errorbar(aes(ymin=Mean, ymax=Mean+SD), width=.2,
                                                                                                                                                                                 position=position_dodge(.9)) 
library(tidyverse)    
library(tidytext)     
library(tm)           
library(wordcloud)    
library(syuzhet)     
library(SnowballC)    


text_data <- tibble(
  doc_id = 1:4,
  text = c(
    "The quick brown fox jumps over the lazy dog. What a beautiful day!",
    "Natural language processing is fascinating and powerful.",
    "I love R programming for data analysis and text mining tasks.",
    "The weather is terrible today, and I feel unhappy about it."
  ),
  author = c("A", "B", "A", "B")
)


clean_text <- function(text) {
  text %>%
    str_to_lower() %>%                   # Convert to lowercase
    str_replace_all("[^[:alnum:]]", " ") %>% # Remove special chars
    str_replace_all("\\s+", " ") %>%      # Replace multiple spaces
    str_trim()                           # Remove leading/trailing spaces
}


text_data_clean <- text_data %>%
  mutate(clean_text = map_chr(text, clean_text))


tokenized_data <- text_data_clean %>%
  unnest_tokens(word, clean_text)


data("stop_words")
cleaned_tokens <- tokenized_data %>%
  anti_join(stop_words, by = "word")

stemmed_tokens <- cleaned_tokens %>%
  mutate(stemmed_word = wordStem(word))


word_freq <- cleaned_tokens %>%
  count(word, sort = TRUE)


top_words_plot <- word_freq %>%
  filter(n > 1) %>%
  mutate(word = fct_reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col(fill = "steelblue") +
  labs(x = "Frequency", y = "Word", 
       title = "Most Frequent Words in the Text")

print(top_words_plot)


wordcloud(words = word_freq$word, 
          freq = word_freq$n,
          max.words = 50,
          colors = brewer.pal(8, "Dark2"))


sentiment_analysis <- cleaned_tokens %>%
  inner_join(get_sentiments("nrc"), by = "word") %>%
  count(doc_id, sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0)


dtm <- text_data_clean %>%
  select(doc_id, clean_text) %>%
  unnest_tokens(word, clean_text) %>%
  count(doc_id, word) %>%
  cast_dtm(doc_id, word, n)


list(
  original_data = text_data,
  cleaned_data = text_data_clean,
  tokenized_data = tokenized_data,
  cleaned_tokens = cleaned_tokens,
  stemmed_tokens = stemmed_tokens,
  word_frequencies = word_freq,
  sentiment_analysis = sentiment_analysis,
  document_term_matrix = dtm
)
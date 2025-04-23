
if(!file.exists("demo.txt")) {
  writeLines(c("Hello World", "R is awesome", "File operations"), "demo.txt")
}


text_data <- readLines("demo.txt")
cat("=== Original Content ===\n")
print(text_data)

data_table <- data.frame(
  ID = 1:3,
  Content = text_data
)
cat("\n=== Tabular Format ===\n")
print(data_table)


writeLines(text_data, "output_text.txt")

write.csv(data_table, "output_table.csv", row.names = FALSE)


cat("\nFiles created successfully:")
cat("\n- Text output: output_text.txt")
cat("\n- CSV output: output_table.csv\n")

cat("\n=== CSV File Preview ===\n")
print(read.csv("output_table.csv"))
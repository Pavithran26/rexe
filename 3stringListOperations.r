
cat("\n=== STRING OPERATIONS ===\n\n")

texts <- c("Data Science", "Machine Learning", "R Programming", "Artificial Intelligence")
cat("Original strings:\n")
print(texts)

cat("\nString lengths:\n")
print(nchar(texts))

cat("\nUppercase conversion:\n")
print(toupper(texts))

cat("\nLowercase conversion:\n")
print(tolower(texts))

# Substring extraction
cat("\nFirst 5 characters:\n")
print(substr(texts, 1, 5))

# String concatenation
cat("\nConcatenated with separator:\n")
print(paste(texts, collapse = " | "))

# String splitting
sentence <- "This is a sample sentence for demonstration"
cat("\nSplit sentence:\n")
print(strsplit(sentence, " "))

# Pattern matching
cat("\nElements containing 'ing':\n")
print(grep("ing", texts, value = TRUE))

# String replacement
cat("\nReplace 'a' with '@':\n")
print(gsub("a", "@", texts))

# String formatting
cat("\nFormatted strings:\n")
print(sprintf("Topic %d: %s", 1:length(texts), texts))

## ----------------------------
## 2. LIST OPERATIONS
## ----------------------------

cat("\n\n=== LIST OPERATIONS ===\n\n")

# Create a complex list
course_info <- list(
  course_name = "Advanced R Programming",
  instructor = "Dr. Smith",
  students = c("Alice", "Bob", "Charlie"),
  grades = list(Alice = 85, Bob = 92, Charlie = 78),
  schedule = list(
    lectures = c("Mon 9AM", "Wed 9AM"),
    lab = "Fri 2PM"
  ),
  active = TRUE
)

cat("Original list structure:\n")
print(str(course_info))

# Accessing list elements
cat("\nAccessing elements:\n")
cat("Course name:", course_info$course_name, "\n")
cat("First student:", course_info$students[1], "\n")
cat("Bob's grade:", course_info$grades$Bob, "\n")

# Modifying lists
cat("\nModifying list:\n")
course_info$instructor <- "Dr. Johnson"
course_info$semester <- "Fall 2023"
print(str(course_info))

# Removing elements
cat("\nRemoving 'active' flag:\n")
course_info$active <- NULL
print(str(course_info))

# List concatenation
additional_info <- list(
  credits = 3,
  department = "Computer Science"
)
cat("\nCombined list:\n")
full_course_info <- c(course_info, additional_info)
print(str(full_course_info))

# Applying functions to lists
cat("\nNumber of students:\n")
print(length(full_course_info$students))

cat("\nAverage grade:\n")
print(mean(unlist(full_course_info$grades)))

## ----------------------------
## 3. COMBINED OPERATIONS
## ----------------------------

cat("\n\n=== COMBINED STRING AND LIST OPERATIONS ===\n\n")

# Process strings within lists
cat("\nStudent names in uppercase:\n")
print(lapply(full_course_info$students, toupper))

# Extract information using string operations
cat("\nExtract days from schedule:\n")
schedule_days <- gsub(" .*", "", unlist(full_course_info$schedule))
print(schedule_days)

# Create formatted output
cat("\nFormatted course summary:\n")
summary_text <- sprintf(
  "Course: %s\nInstructor: %s\nStudents: %s\nCredits: %d",
  full_course_info$course_name,
  full_course_info$instructor,
  paste(full_course_info$students, collapse = ", "),
  full_course_info$credits
)
cat(summary_text)

## ----------------------------
## 4. CLEANUP AND OUTPUT
## ----------------------------

# Save results
output <- list(
  string_operations = list(
    original_strings = texts,
    modified_strings = gsub("a", "@", texts)
  ),
  list_operations = list(
    original_list = course_info,
    modified_list = full_course_info
  )
)

cat("\n\n=== PROGRAM COMPLETED ===\n")
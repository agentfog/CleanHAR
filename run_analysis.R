# Extract the variable names:
variable_names <- read.table('./features.txt', 
                           colClasses='character')
variable_names <- variable_names$V2

# Extract activity labels:
act_ref <- read.table('./activity_labels.txt',
                             colClasses='character',
                             col.names=c('levels', 'labels'))

# Read the training and test data sets, storing in memory just the variables 
# which represent means or standard deviations:
variable_types <- ifelse(grepl('mean\\(\\)|std\\(\\)', variable_names), 
                         'numeric', 
                         'NULL')
training_data <- read.table('./train/X_train.txt', 
                            sep="", 
                            col.names=variable_names, 
                            check.names=FALSE,
                            colClasses=variable_types, 
                            nrows=8000)
activity <- scan('./train/y_train.txt', integer(), 8000)
training_data$Activity <- factor(activity, act_ref$levels, act_ref$labels)
subject <- scan('./train/subject_train.txt', integer(), 8000)
training_data$Subject <- factor(subject, 1:30, label='SUBJECT')
test_data <- read.table('./test/X_test.txt', 
                        sep="", 
                        col.names=variable_names,
                        check.names=FALSE,
                        colClasses=variable_types, 
                        nrows=3000)
activity <- scan('./test/y_test.txt', integer(), 3000)
test_data$Activity <- factor(activity, act_ref$levels, act_ref$labels)
subject <- scan('./test/subject_test.txt', integer(), 3000)
test_data$Subject <- factor(subject, 1:30, label='SUBJECT')

# Merge the two data sets:
all_data <- rbind2(training_data, test_data)
rm(training_data, test_data)

# Fix variable names: no hyphens, no parentheses, and make names CamelCase
names(all_data) <- gsub('-', '', names(all_data))
names(all_data) <- sub('mean\\(\\)', 'Mean', names(all_data))
names(all_data) <- sub('std\\(\\)', 'Std', names(all_data))

# Split into 180 categories (6 activities X 30 subjects) and for each category
# calculate the mean of each variable. The resulting matrix is turned back to a 
# data frame, with categories as rows and variables as columns.
split_data <- split(all_data[,1:66], list(all_data$Subject, all_data$Activity))
tidy_data <- data.frame(t(sapply(split_data, colMeans)))
write.table(tidy_data, './UCI_HAR_summarized.txt', row.names=FALSE)

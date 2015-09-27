# CleanHAR
A script to summarize the Human Activity Recognition Using Smartphones Dataset

The original HAR dataset contains a processed dataset with thousands 
of observations of a 561-feature vector.

run_analysis.R is a standalone script that summarizes the HAR dataset by 
performing the following steps:

1.  Read the training and test data sets, storing in data frames just the 66 
    variables which correspond to means or standard deviations of direct and
    indirect measurements.
    
2.  Activity and Subject variables for the training and test datasets are read, 
    transformed into factors with appropiate levels and labels, and appended as
    columns to the training and test data frames.
    
3.  Concatenate the two data sets (using rbind2).

4.  Fix variable names: hyphens and parentheses are supressed and the words
    mean and std are capitalized to make all variable names CamelCase.

5.  Split into 180 categories (6 activities X 30 subjects) and for each category
    calculate the mean of each variable. The resulting matrix is turned back to  
    a data frame, with categories as rows and variables as columns.
    
6.  Finally, the tidy dataset is exported to a file 'UCI_HAR_summarized.txt'
    in the current working directory (using write.table with row.names=FALSE).

For more detailed information about the resulting dataset, see codebook.md.
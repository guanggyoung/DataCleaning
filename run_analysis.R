################# Code to do data cleaning #############

# First, download and unzip the data. Set the unzipped folder 
# containing the datasets as working directory.


#################### Step 1. Merge the data ################

### Read the feature
features <- read.table("./features.txt",header=FALSE,colClasses=c("numeric","character"))
### Read the activity labels
activity_labels <- read.table("./activity_labels.txt",
                              colClasses=c("numeric","factor"),header=FALSE)
### Read all the test datasets
subject_test <-read.table("./test/subject_test.txt",header=FALSE)
# Use some tricks to figure out number of rows(it is 2947 here) 
X_test <- read.table ("./test/X_test.txt", nrows=2947,header=FALSE)
y_test <- read.table ("./test/y_test.txt",header=FALSE)

# Transfer y_test from num code to actual activity
# using activity_labels
y_test_name <- activity_labels[y_test[[1]], ][[2]]

# Merge the test datasets together
merge_test<-cbind(X_test,y_test_name,subject_test)


# Give column names of merge_test
# Column 1 to 561: indicate data of which feature
# Column 562: indicate activity for collecting data
# Column 563: Subject who performed the activity
colnames(merge_test) <- c(features[[2]], "activity", "subject")

# Add a new column data_type to figure out origin of the data  for further merging
# Label merged_test data type as "test"
merge_test$data_type="test"


### Read all the train datasets. 
subject_train <- read.table("./train/subject_train.txt",header=FALSE)
# Use some tricks to figure out number of rows(it is 7352 here) 
X_train <- read.table("./train/X_train.txt",header=FALSE,nrows= 7352)
y_train <- read.table("./train/y_train.txt",header=FALSE)

# Transfer y_test from num code to actual activity
# using activity_labels
# This is useful for Step 3
y_train_name <- activity_labels[y_train[[1]], ][[2]]

# Merge the train datasets together
merge_train <- cbind (X_train, y_train_name, subject_train)

# Give column names of merge_train
# Column 1 to 561: indicate data of which feature
# Column 562: indicate activity for collecting data
# Column 563: Subject who performed the activity
# This process is useful for Step 4.
colnames(merge_train) <- c(features[[2]], "activity", "subject")

# Label merged_train data type as "train" for further merging
merge_train$data_type <- "train"

# Merge train dataset with test dataset
merge_data <- rbind( merge_train, merge_test)

## OK, Now I have merged the data together, and also clearly showed all the 
## activity_label as well as the data feature in the 1~561 columns of the data frame


####### Step 2. Extracts columns according to the requirement #############

# columns with mean() key word to extracts "measurements on the mean"
# I ignored data of meanFreq or angle(xxxxMean)

meanColNum <- grep("mean()", feature[[2]], ignore.case = FALSE, fixed=TRUE)
stdColNum <- grep("std()", feature[[2]], ignore.case = FALSE, fixed=TRUE)

#Extract data here
# I added a column "data_type" to indicate whether certain row is from
# the original test dataset or the train dataset. I believe this column is
# useful in real-world task, but obviously it is not useful in this project.
# (See codes and comments in Step 1 for detail)
extracted_data <- merge_data[, c(meanColNum,stdColNum, 562,563,564)]

################## Step 2. Finished #####################

## Meanwhile, I believe I have also finished step 3 and step 4  
## as I have fully cleaned the data in Step 1. 
## See codes and comments in Step 1 for detail.
############ Step 3 and Step 4 Finished ###############

############# Step 5 Construct the new data set and write to a file ###########
# In this step, I drop the "data_type" column following the FAQ in the forum
# provided by David so as to make the data set look the same as others.
# Thanks to David ;)

# Construct the dataset for output
out_data <- aggregate (extracted_data[,1:66], 
                       by= list(activity=extracted_data$activity,subject=extracted_data$subject), FUN= mean)
# Put activity and subject to the end of the dataset
out_data <- out_data[,c(3:ncol(out_data),1,2)]

# Write the dataset to text file using "," as the separator(The ".CSV" file style).
write.table(out_data,"run_analysis_output.txt",sep = ",",row.names = FALSE)



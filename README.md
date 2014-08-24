DataCleaning
============

R code for the project of Coursera class Getting and Cleaning Data

I did not follow all the steps as required but still got the tidy dataset needed.
Here are the detailed steps:

Step 1. I imported all the test datasets and merged these datasets using cbind() function. 
Then I named the activities and different features with their names provided in 
"activity_labels.txt" and "features.txt" files which had been also imported.

Step 2. I imported and merged the train datasets and provided the descriptive names of all 
the feature columns and activity column just as step 1.

Step 3. I merged the processed test datasets and train datasets in step 1 and 2 using rbind(). 
Since I had already given all the descriptive names of  different variables and activities. 
Here I finished the 1st step required in the class project and meanwhile I have finished all
the annotating work needed for the 3rd and 4th step. While merging the two datasets, I added
a column named "data_type" to indicate where the data was originally come from( the test dataset
or the train dataset). Althrough the "data_type" variable was never used in this project,
I believe a column like this is useful in real world tasks.

Step 4. Using regular expression( the grep code), I extracted the column indexes relative to
the mean() and std() data. Using the indexes, I then got the subset of the merged dataset. 
Till then, I finished the 2nd step in the class project. As I mentioned above, I had already
given the descriptive names to the feature and activity variables, meanwhile, I also finished
the 3rd and 4th steps.

And the final step!
Step 5. Using "aggregate()" function, I calculated the average of each variable for each activity
and each subject. After making some little modifications, the resulted data frame is ready to be
outputed. Using write.table() function and parameter sep=",", the dataset was finally written
down in the .CSV file style. If the data would be needed in the future, it could be easily
imported using read.csv() function. 

filename <- "dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

#getting the index of the columns that we want
features = read.table(file.path("UCI\ HAR\ Dataset/features.txt"))
meanstdfeatures = grep(".*mean.*|.*std.*",features[[2]])
meanstdfeaturesnames = as.character(features[meanstdfeatures,2])

#preparation of the test set for the future merge
subjects_test = read.table(file.path("UCI\ HAR\ Dataset/test/subject_test.txt"))
set_test = read.table(file.path("UCI\ HAR\ Dataset/test/X_test.txt"))[,meanstdfeatures]
labels_test = read.table(file.path("UCI\ HAR\ Dataset/test/y_test.txt"))

set_test = cbind(subjects_test,labels_test,set_test)

#preparation of the train set for the future merge
subjects_train = read.table(file.path("UCI\ HAR\ Dataset/train/subject_train.txt"))
set_train = read.table(file.path("UCI\ HAR\ Dataset/train/X_train.txt"))[,meanstdfeatures]
labels_train = read.table(file.path("UCI\ HAR\ Dataset/train/y_train.txt"))

set_train = cbind(subjects_train,labels_train,set_train)

#merging both data sets
data_set = rbind(set_test,set_train)

#renaming the columns
colnames(data_set) = c("subject","activity",meanstdfeaturesnames)

#Use descriptive activity names to name the activities in the data set
activities = read.table(file.path("UCI\ HAR\ Dataset/activity_labels.txt"))
activity_labels = as.character(activities[,2])

#create a second, independent tidy data set with the average of each variable
#for each activity and each subject.
data_set$activity = factor(data_set$activity,levels = activities[[1]],labels=activity_labels)
data_set$subject = as.factor(data_set$subject)

aggregatesmeans = aggregate(.~activity+subject, data_set, mean)

#writting the output in a text file
write.table(aggregatesmeans, "tidy.txt", row.names = FALSE, quote = FALSE)


## download the zip file from given directory
 download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./Rdocuments/Activity.zip")

## unzip the file in current work directory
unzip("./Rdocuments/Activity.zip", list=FALSE, exdir = "./Rdocuments")


# read the diferent txt files that are needed
subject_test <- read.table('./Rdocuments/UCI HAR Dataset/test/subject_test.txt')
test_x <- read.table('./Rdocuments/UCI HAR Dataset/test/X_test.txt')
test_y <- read.table('./Rdocuments/UCI HAR Dataset/test/y_test.txt')

subject_train <- read.table('./Rdocuments/UCI HAR Dataset/train/subject_train.txt')
train_x <- read.table('./Rdocuments/UCI HAR Dataset/train/X_train.txt')
train_y <- read.table('./Rdocuments/UCI HAR Dataset/train/y_train.txt')

features <- read.table('./Rdocuments/UCI HAR Dataset/features.txt')

# set column names for the different datasets
colnames(test_x)<- features[,2]
colnames(test_y)<- "Labels"
colnames(subject_test)<- "Subject"

test_x_un<-test_x[,!duplicated(colnames(test_x))]

colnames(train_x)<- features[,2]
colnames(train_y)<- "Labels"
colnames(subject_train)<- "Subject"

# delete the not unique columns
train_x_un<-train_x[,!duplicated(colnames(train_x))]

## combine the different files to one dataset for train and one for test
dataset_test <- cbind(subject_test, test_y, test_x_un)
dataset_train <- cbind(subject_train, train_y, train_x_un)

# combine the test and train datasets
dataset_tot<-rbind(dataset_test, dataset_train)

# select the first 2 columns and alle columns with mean or standarddeviation
dataset_mnsd<-select(dataset_tot, 1,2, contains("mean"), contains("std"))

# make a factor of Labels column and add names per level
dataset_mnsd$Labels <- factor(dataset_mnsd$Labels, levels = c(1,2,3,4,5,6), labels=c("Walking", "Walking upstairs", "Walking downstair", "Sitting", "Standing", "Lying"))

# redesign the tabel: 
# 1) one column with all different measurements. 
# 2) group by person and level. 
# 3) Calculate average off all measurements per person and level
# 4) write table
tidy<-gather(dataset_mnsd, Activity, Value  ,-Subject, -Labels)
tidy2<-group_by(tidy, Subject, Labels, Activity)
tidy3<-summarize(tidy2,mean(Value))
tidy4<-spread(tidy3,Activity, "mean(Value)")
write.table(tidy4,file="Rdocuments/tidy dataset.txt",  row.name=FALSE)
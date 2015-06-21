# run_analysis - get, collect, clean and write the tidy data
# The function expects the Samsung data is in the working directory

run_analysis <- function() {
  library(dplyr);
  
  # Step 1:
  # read the features.txt-Dataset to produce descriptive variable name
  uciname <- read.table("UCI HAR Dataset/features.txt", sep=" ", colClasses = c("numeric", "character"))[2];
  uciname <- lapply(uciname, gsub, pattern = "-", replacement = "");
  uciname <- lapply(uciname, gsub, pattern = "\\(\\)", replacement = "");
  ucivars <- lapply(uciname, grep, pattern = "mean|std");
  uciname <- c(uciname$V2[ucivars$V2]);
  uciname <- lapply(uciname, gsub, pattern = "mean", replacement = "Mean");
  uciname <- lapply(uciname, gsub, pattern = "std", replacement = "Std");
  
  # Step 2: read an reduce the test and train data
  x.t <- read.table("UCI HAR Dataset/test/X_test.txt");
  x.t <- select(x.t, ucivars$V2);
  x.r <- read.table("UCI HAR Dataset/train/X_train.txt");
  x.r <- select(x.r, ucivars$V2);

  # Step 3: read the test an train activity data and merge it with the descriptive activity names
  uciact <- read.table("UCI HAR Dataset/activity_labels.txt", sep=" ", colClasses = c("numeric", "character"));
  y.t <- read.table("UCI HAR Dataset/test/y_test.txt");
  y.t <- merge(y.t, uciact, by.x="V1", by.y="V1", sort = FALSE);
  y.r <- read.table("UCI HAR Dataset/train/y_train.txt");
  y.r <- merge(y.r, uciact, by.x="V1", by.y="V1", sort = FALSE);

  # Step 4: read the test and data subject data
  s.t <- read.table("UCI HAR Dataset/test/subject_test.txt");
  s.r <- read.table("UCI HAR Dataset/train/subject_train.txt");

  # Step 5: bind activity, subject and measurement columns; naming the columns
  ucid1 <- cbind(y.t$V2,s.t,x.t);
  names(ucid1) <- c("activity", "subject", uciname);
  ucid2 <- cbind(y.r$V2,s.r,x.r);
  names(ucid2) <- c("activity", "subject", uciname);
  ucidata <- rbind(ucid1, ucid2);
  
  # Step 6: group activity and subject and create (a second tidy dataset) with the average for measurements
  #         write it to txt-file
  ucigroup <- group_by(ucidata, activity, subject);
  uciout <- summarise_each(ucigroup, funs(mean));
  write.table(uciout, file = "UCIsumData.txt", row.names = FALSE);
  
  # Step 7: return the first tidy dataset
  return(ucidata);
}

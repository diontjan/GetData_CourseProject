analyse <- function(directory = "UCI HAR Dataset") {
    library(dplyr)

    features <- read.table(file.path(directory, "features.txt"))
    features_pos <- as.numeric(features[,1])
    features_name <- as.character(features[,2])

    #Keep only labels ended with mean() or std()
    features_pos_mean <- grep("[-]+mean[()]+", features_name, value = F)
    features_pos_std <- grep("[-]+std()[()]+", features_name, value = F)
    features_pos <- features_pos[c(features_pos_mean, features_pos_std)]
    features_name <- features_name[c(features_pos_mean, features_pos_std)]

    #Make labels' name friendly
    features_name <- gsub("()-", "_", features_name, fixed = T) #e.g.: -mean()-X
    features_name <- gsub("-", "_", features_name, fixed = T)   #e.g.: Acc-mean
    features_name <- gsub("()", "", features_name, fixed = T)   #e.g.: mean()
    features_name <- sub("^f", "freq_", features_name)          #e.g.: fBody
    features_name <- sub("^t", "time_", features_name)          #e.g.: tBody

    #Read activity names
    activity_label <- read.table(file.path(directory, "activity_labels.txt"))
    colnames(activity_label) <- c("id", "name")
    #View(activity_label)

    #Prepare subject data
    test_subject <- read.table(file.path(directory, "test/subject_test.txt"))
    train_subject <- read.table(file.path(directory, "train/subject_train.txt"))
    subject <- rbind(test_subject, train_subject)
    colnames(subject) <- c("subject")
    #View(subject)

    #Prepare activity data
    test_y <- read.table(file.path(directory, "test/y_test.txt"))
    train_y <- read.table(file.path(directory, "train/y_train.txt"))
    activity <- rbind(test_y, train_y)
    activity_name <- as.factor(activity_label$name)[activity$V1]
    activity <- cbind(activity, activity_name)
    colnames(activity) <- c("activity", "activity_name")
    #View(activity)

    #Prepare measurement data
    test_X <- read.table(file.path(directory, "test/X_test.txt"))
    train_X <- read.table(file.path(directory, "train/X_train.txt"))
    measurement <- rbind(test_X, train_X)
    measurement <- measurement[, features_pos]
    colnames(measurement) <- features_name

    #Combine three data sets: subject, activity, measurement
    tidy_data <- cbind(subject, activity, measurement)
    tidy_data <- arrange(tidy_data, subject, activity)
    #View(tidy_data)

    ##Group and summarise dataset
    data_grouped <- tidy_data %>% group_by(subject, activity, activity_name)
    #View(data_grouped)
    data_summ <- data_grouped %>% summarise_each(funs(mean))
    #View(data_summ)

    ##Prepare output
    write.table(data_summ, file = "second_dataset.txt", row.names = FALSE)
}
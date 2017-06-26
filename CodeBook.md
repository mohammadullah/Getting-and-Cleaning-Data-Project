# CodeBook

This file describes the variables, data and the code file named **run_analysis.R** 

## The code is divided into several sections
1. Download and unzip the data file
2. Load all required data files
3. Prepare and marge the training and test data sets
4. Data Manipulation
5. Descriptive variable names and their explanation
6. New Tidy data.frame
7. Save the new data.frame

### Download and unzip the data file

1. Create **"data"** folder
2. Download the zip file **(UCIData.zip)**
3. unzip the **"UCI HAR Dataset"** folder in **"data"** folder

### Load all required data files

1. **"read.table"** function is used to read all required data files.
2. The files and variables are given below.

 | Variables           | Files              |
 | ------------------- |:------------------:|
 |activityname         | activity_labels.txt|
 |feature			   | features.txt       |
 |xtrain               | X_train.txt        |
 |ytrain			   | y_train.txt        |
 |sub_tr               | subject_train.txt  |
 |xtest				   | X_test.txt         |
 |ytest				   | y_test.txt         |
 |sub_tes              | subject_test.txt   |
 
### Prepare and marge the training and test data sets

1. Feature names are added as column variables in **"xtrain"** data set 
2. **"Subject"** and **"Activity"** variables are added to **"ytrain"** and **"sub_tr"** data sets.
3. The training data set is prepared from above three data sets.
4. Similarly test data set is prepared.
5. Both test and training data sets are marged in **"xmarged"** variable.

### Data manipulation

1. New data frame **"meanstd"** is created containing only **"mean()"** and **"std()"** values. 
2. **"meanstd"** data frame is arranged according to **"Activity"** column.
3. **"Activity"** column is tranformed to factor.
4. **"activityname"** is used as labels in **"Activity"** factor.

### Descriptive variable names and their explanation

1. Activity = Name of the activities 
2. Subject = Unique personal id
3. Time = Calculation is done in Time domain
4. BodyAcc = Linear Body acceleration calculated using accelerometer
5. GravityAcc = Gravitational acceleration calculated using accelerometer
6. BodyAccJerk = Jerk signal from body linear acceleration using accelerometer
7. BodyGyroJerk = Jerk signal from angular velocity using gyroscope
8. FFT = Fast Fourier Transform was applied
9. Mean = Average 
10. Std = Standard deviation
11. Mag = Magnitude
12. X/Y/Z = Calculation was done in X , Y and Z directions

### New Tidy data.frame

1. The **"meanstd"** data frame is grouped by **"Activity"** and **"Subject"**.
2. A tidy data set is created by taking avegare of each variable according to the **"Activity"** and **"Subject"** groups.

### Save the new data.frame

1. The tidy data frame is saved in **"tidydataout.csv"** file.
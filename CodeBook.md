The dataset used for this assignement refers to an experiment in which 30 volunteers had to do 6 specific activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone. Detailed information concerning the experiment can be found in the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The code used to produce the desired results is written in the script "run_analysis.R".
It consists of several steps to achieve all 5 prerequisites for the assignement:

	1. Read features.txt, which contains variable names for each measurement in the data sets
	2. Read test and train files as data frames
	3. Read activity_labels.txt, which contains activities' names and the respective id number for each one
	4. Use features to give descriptive names to trainSet and testSet variables
	5. Merge both sets into one, named merged in the script
	6. Extract only those variables that are the mean or the standard deviation of a measured variable
	7. Replace activity id numbers with their respective activity name
	8. After having created a tidy data set, where each variable has a descriptive name, each observation is in a single row and each column 
	   contains one variable, the merged data frame is melted and the recasted in the desired shape. That is a wide tidy data set, named cast in the script, whose first two columns contain information about the combination of subject and activity followed by 79 columns. These columns contain the mean value of each variable that was measured, taking into account all the data accumulated by the specific subject doing the specific activity
	9. The cast data frame is the output of the script and it is written in a new file called "tidy_data_step5.txt", which will be located 	in the working directory
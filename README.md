# separdianz

A project currently under development by Xaferdian and Sep 

## Commit log

[16/05/2023] - Creation of the log


## Version 0.1 changes
(This is the first ever proper test version)
1) Add slidable dispose for main task widgets
2) Fixed midnight task reset working

Added new features: 
1) At everyday 2 A.M, the tasks are reset. Incomplete tasks are moved to outdated tasks below the add tasks button, where the user can choose to restore it or permanently delete it. 
2) Swipe to dispose option is added
3) Tasks can be added and deleted whenever the user wishes
4) An internal map is created to store the progress of everyday. This can be later used in the graph widget to plot everyday efficiency trened


## Version 0.2.1 changes

1) Graph widget now works with retrieving performance of current week 
2) A sound plays after timer is over

## In next version (v.0.2.2)

Flutter task list work
1) Make the timer run in background and give a notification when time is complete
2) Make provision to store seconds elapsed value

## To do

Enhancements
1) Make the progress percent reflect the tasks completed duration than the number of cycles
2) Make each task widget reflect the total remaining time to complete the task, and a running color if the task is currently running. 
3) If user attempts to run another task while previous task is running, then user must be prompted with a warning to pause the previous task before starting this task. 
4) Add a proper icon for the splash screen
5) Organize the files and codes properly



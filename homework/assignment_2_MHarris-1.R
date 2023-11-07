#############################################

#### Assignment 2, M Harris

#### programmer: madison harris
#### harr8597@vandals.uidaho.edu

#### purpose: read in csv data and import USGS streamflow gauge data and manipulate the data

#### updated sept 12, 2023

#############################################

##### Packages to install

install.packages("waterData")
library(waterData)


###     Step 1 - 3) read data into script


water_parameters = read.csv('assignment_2_NEW_REVISED.csv', header = TRUE, skip = 2)
    ### will give error/warning message but still works
    ### Check if it worked
View(water_parameters)


    ## Read in 1N_dendro. use column headers, and skip first row
dendro_2020 = read.csv('1N_dendro_2020.csv', header = TRUE, skip = 2)  
View(dendro_2020)

    ## Read in .txt file to data
temp_data = read.delim('temperature_data.txt', header = TRUE, sep = "\t", dec = ".")
#     temp_data = read.table('temperature_data.txt', header = TRUE, sep = "\t", dec = ".")



###     Step 4) Extract values, rows 13-15


temp_data[13:15,1]


###     Step 5) Read in the daily USGS streamflow data collected between January 2015 to 
##              December 2019 at the Boise River at Glenwood Bridge site and save separately


glenwood = importDVs("13206000", code = "00060", stat = "00003", sdate = "2015-01-01", edate = "2019-12-31")
View(glenwood)
    ##### val = discharge cfs


###     Step 6) Save to hard drive


write.table(glenwood, "~/Desktop/Assignment_2_Result.csv", sep=",",  col.names=FALSE)
    ## no column names


#############################################
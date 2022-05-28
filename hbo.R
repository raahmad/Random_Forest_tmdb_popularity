rm(list=ls())

#Load CSV files
HBO<-read.csv("HBO_Centuries_Added.csv",sep = ",",header = T)
Movie<-read.csv("Movie.csv",sep = ",",header = T)

#Change Column Name to ID
HBO$ï..id
Movie$ï..Row.Labels
names(HBO)[names(HBO) == "ï..id"]<-"ID"
names(Movie)[names(Movie) == "ï..Row.Labels"]<-"ID"

#Merge 2 Data Frames together
library(dplyr)
model_df<-HBO %>% left_join(Movie, by="ID")

#Delete Columns That Are Not Needed
model_df<-model_df[, -c(1:6,8:11)]

#Mode the tmdb_popularity column to the end
library(dplyr)
model_df<-model_df %>%
  select(-tmdb_popularity, everything())

#Convert all NA in the Movie column to 0
model_df$MOVIE[is.na(model_df$MOVIE)]<-0

#Check to see if there are any missing values
colSums(is.na(model_df))

#Delete the rows that have missing values
model_df <- model_df[!(model_df$imdb_score %in% c(NA)),]
model_df <- model_df[!(model_df$imdb_votes %in% c(NA)),]
model_df <- model_df[!(model_df$tmdb_score %in% c(NA)),]
model_df <- model_df[!(model_df$tmdb_popularity %in% c(NA)),]

#Check again to see if there are any missing values
colSums(is.na(model_df))

#Check to see the 3rd Quartile for tmdb_popularity
#This represents the value that is the 75th percentile
summary(model_df$tmdb_popularity)
#3rd Quartile (75th Percentile) is 19.571 for tmdb_popularity

#Create a new column called third quartile
#If the row had a tmdp_popularity score in the 75th percentile and above, it'll have a 1
#If the row had a tmdp_popularity score below the 75th percentile, it'll have a 0
model_df$third_quartile<-ifelse(model_df$tmdb_popularity>=19.571,"1","0")

#We do not need the tmdb_popularity score anymore so we can null it
model_df$tmdb_popularity<-NULL

#Make sure all features are numeric or categorical
model_df$X20th.Century<-as.factor(model_df$X20th.Century)
model_df$MOVIE<-as.factor(model_df$MOVIE)
model_df$third_quartile<-as.factor(model_df$third_quartile)
str(model_df)

#Create Training and Testing Set for Random Forest Model
#Partition 80/20
sample = sample.split(model_df$third_quartile, SplitRatio = .8)
train = subset(model_df, sample == TRUE)
test  = subset(model_df, sample == FALSE)

#Random Forest Model
#third_quartile is the target variable
library(randomForest)
require(caTools)
rf <- randomForest(third_quartile ~ .,data=train)
rf
#Roughly only a 13.64% error rate which is good 

#Prediction
pred = predict(rf, newdata=test[-7])
pred

#Confusion Matrix
cm = table(test[,7], pred)
cm

#Probability of movie/show having 75th percentile or above tmdb_popularity score 
prob=predict(rf,test,type="prob")

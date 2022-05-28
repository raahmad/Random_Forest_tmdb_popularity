# Random_Forest_tmdb_popularity


### Intro
"Popularity is a very important metric on TMDB. It helps them boost search results, adds an incredibly useful sort value for discover, and is also just kind of fun to see items chart up and down". The purpose of this analysis is to predict the probability that a movie/show will have a tmdb popularity score in the 75th percentile or higher. This was accomplished through creating a pivot table in Microsoft Excel, data cleanining in RStudio, and running a random forest model in RStudio as well.

https://developers.themoviedb.org/3/getting-started/popularity

https://www.kaggle.com/datasets/victorsoeiro/hbo-max-tv-shows-and-movies

### Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

1. Download and save all csv files, workbooks, and r script
2. Open all csv files and workbooks with Microsft Excel
3. Open hbo.r with RStudio
4. Within RStudio, set working directory to wherever you completed step 1

### Prerequisites
1. R 3.3.2
2. RStudio 1.0.135
3. Packages to install: dplyr, randomForest, caTools.

### Breakdown
1. hbo.xlsx contains original dataset, dataset with if function columns added, and a pivot table to produce all csv files produced for hbo.r
2. hbo.r uses input of all csv files and and produces the random forest model, the error rate, the confusion matrix, and the predicted probability of a movie/show having a 75th percentile or above tmdb_popularity score  

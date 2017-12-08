Scrape\_data
================
Yidie Feng
11/30/2017

``` r
library(dplyr)
library(tidyverse)
library(magrittr)
library(purrr)
library(glue)
library(stringr)
library(rvest)
library(xml2)
```

Download the html and turn it into an XML file.

``` r
cocoweb<-read_html("http://www.imdb.com/title/tt2380307/?ref_=nv_sr_1")
```

Create a dataframe that has four variables:

-   `Movie` is the name of the movie.

-   `Cast` are the actors/actress in the movie.

-   `ProfileLink` provides the link to the actor's/actress' profile page.

-   `Role` is the role each actor/actress played in the movie.

``` r
coco_df<-data.frame(Movie = "Coco",
                    
                    Cast = cocoweb %>%
                        html_nodes("#titleCast span.itemprop") %>%
                        html_text(),

                    ProfileLink = cocoweb %>%
                        # The tag is "a"
                        html_nodes("a") %>%
                        # Get the "href" from it
                        html_attr("href") %>%
                        # Unfortunately, the above code also gives me the information 
                        # I don't need. The link I want has the pattern: starting with
                        # "/name", ending with "tt_cl_t" following by one or more digits.
                        # So I use str_subset() to get those links that match this pattern.
                        str_subset("^/name.*tt_cl_t\\d+$") %>%
                        paste0("http://www.imdb.com",.),
                    
                    Role = cocoweb %>%
                        html_nodes(".character div") %>%
                        html_text(),
                    
                    stringsAsFactors=F
                            
                        )
```

This is a function that takes an url link as input and returns the filmography from the web.

``` r
get_filmography <- function(link){
    read_html(link) %>%
    html_nodes("#filmography :nth-child(2) .filmo-row b a") %>%
    html_text() %>%
    collapse(sep=", ")%>%   
    return()
}
```

Add in the 5th variable `Filmography` by using `get_filmography()` function to return the filmography of every actor/actress from their profile page.

``` r
coco_df<-mutate(coco_df, Filmography=map_chr(ProfileLink, get_filmography))
```

Save `coco_df` to file. Take a look at the [clean and tidy dataframe](https://github.com/yidie/STAT545-hw-Feng-Yidie/blob/master/hw10/coco.csv) I created.

``` r
write_csv(coco_df,"coco.csv")
```

Glimpse of `coco_df`

``` r
glimpse(coco_df)
```

    ## Observations: 15
    ## Variables: 5
    ## $ Movie       <chr> "Coco", "Coco", "Coco", "Coco", "Coco", "Coco", "C...
    ## $ Cast        <chr> "Anthony Gonzalez", "Gael García Bernal", "Benjami...
    ## $ ProfileLink <chr> "http://www.imdb.com/name/nm5645519/?ref_=tt_cl_t1...
    ## $ Role        <chr> "\n            Miguel \n  \n  \n  (voice)\n  \n   ...
    ## $ Filmography <chr> "The Gospel Truth, Icebox, Coco, Dante's Lunch: A ...

``` r
dim(coco_df)
```

    ## [1] 15  5

Since the dataframe consists of only characters. There is nothing to plot. Below are what I did for exploratory analysis.

If everything is right, It should have "Coco" appearing in `Filmography` for every actor/actress. Let's check using `str_detect()`. Indeed, I get 15 `TRUE`'s, which means "Coco" is detected for all 15 actors/actress in their filmography.

``` r
str_detect(coco_df$Filmography, "Coco")
```

    ##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    ## [15] TRUE

And it should have "voice" appearing in `Role` for every actor/actress because this is an animation film. I get 15 `TRUE`'s, which means "voice" is detected for all 15 actors/actress in `Role` column.

``` r
str_detect(coco_df$Role, "voice")
```

    ##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    ## [15] TRUE

Look at the number of films that each actor/actress has played a role in. And determine which actor/actress has the highest/lowest number of films in his/her filmography respectively so far.

``` r
# initialization
number_of_film <- rep(NA, 15)

# for loop to get the number of films in filmography for each actor/actress.
for (i in 1:15){
    film.vt<-(str_split(coco_df$Filmography[i], ","))[[1]]
    number_of_film[i]<-length(film.vt)
}

#This is the number of films in each actor/actress' filmography.
number_of_film
```

    ##  [1]   9  54  64 138  63  37  55  30  38 119 102  19  25 116  31

Alanna Ubach has the highest number of films in her filmography so far, which is 137.

``` r
coco_df$Cast[which.max(number_of_film)]
```

    ## [1] "Alanna Ubach"

``` r
number_of_film[which.max(number_of_film)]
```

    ## [1] 138

Anthony Gonzalez has the lowest number of films in his filmography so far. Indeed, he is very young (12 years old). But still, he has played a role in 9 films so far.

``` r
coco_df$Cast[which.min(number_of_film)]
```

    ## [1] "Anthony Gonzalez"

``` r
number_of_film[which.min(number_of_film)]
```

    ## [1] 9

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

    ## Warning: package 'bindrcpp' was built under R version 3.3.2

Save `coco_df` to file

``` r
write_csv(coco_df,"coco.csv")
```

Take a look at the clean and tidy dataframe I created.

``` r
head(coco_df)
```

    ##   Movie               Cast
    ## 1  Coco   Anthony Gonzalez
    ## 2  Coco Gael García Bernal
    ## 3  Coco     Benjamin Bratt
    ## 4  Coco       Alanna Ubach
    ## 5  Coco       Renee Victor
    ## 6  Coco        Jaime Camil
    ##                                         ProfileLink
    ## 1 http://www.imdb.com/name/nm5645519/?ref_=tt_cl_t1
    ## 2 http://www.imdb.com/name/nm0305558/?ref_=tt_cl_t2
    ## 3 http://www.imdb.com/name/nm0000973/?ref_=tt_cl_t3
    ## 4 http://www.imdb.com/name/nm0005513/?ref_=tt_cl_t4
    ## 5 http://www.imdb.com/name/nm0896149/?ref_=tt_cl_t5
    ## 6 http://www.imdb.com/name/nm0131781/?ref_=tt_cl_t6
    ##                                                                                                         Role
    ## 1                     \n            Miguel \n  \n  \n  (voice)\n  \n                      \n\n              
    ## 2                     \n            Héctor \n  \n  \n  (voice)\n  \n                      \n\n              
    ## 3         \n            Ernesto de la Cruz \n  \n  \n  (voice)\n  \n                      \n\n              
    ## 4                \n            Mamá Imelda \n  \n  \n  (voice)\n  \n                      \n\n              
    ## 5 \n            Abuelita \n  \n  \n  (voice) (as Renée Victor)\n  \n                      \n\n              
    ## 6                       \n            Papá \n  \n  \n  (voice)\n  \n                      \n\n              
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Filmography
    ## 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               The Gospel Truth, Icebox, Coco, Dante's Lunch: A Short Tail, Criminal Minds: Beyond Borders, Icebox, Imagination of Young, The Bridge, Como mi hermano
    ## 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Aquí en la Tierra, Museo, The Kindergarten Teacher, Z, Coco, Si tu voyais son coeur, Dante's Lunch: A Short Tail, Mozart in the Jungle, Salt and Fire, Neruda, Me estás matando Susana, Desierto, Eva no duerme, Zoom, Rosewater, El Ardor, Vamps, No, Casa de mi Padre, Zalet, The Loneliest Planet, A Little Bit of Heaven, También la lluvia, Letters to Juliet, The Limits of Control, Mammoth, Rudo y Cursi, Blindness, El pasado, Déficit, La science des rêves - Film B, Babel, Soy tu fan, La science des rêves, The King, La mala educación, Diarios de motocicleta, Dreaming of Julia, Dot the I, I'm with Lucy, El crimen del Padre Amaro, Fidel, The Last Post, Sin noticias de Dios, Vidas privadas, El ojo en la nuca, Y tu mamá también, Cerebro, Queen of Swords, Amores perros, De tripas, corazón, El abuelo y yo, Teresa
    ## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Star, Coco, Shot Caller, Modern Family, Doctor Strange, The Infiltrator, Special Correspondents, Ride Along 2, Justice League: Gods and Monsters, Justice League: Gods and Monsters Chronicles, 24: Live Another Day, Super Manny, Cloudy with a Chance of Meatballs 2, Despicable Me 2, Despicable Me: Minion Rush, Snitch, Private Practice, The Lesser Blessed, Freedom Riders, Law & Order, Cloudy with a Chance of Meatballs, The Cleaner, American Experience, La Mission, Trucker, The Andromeda Strain, Love in the Time of Cholera, E-Ring, The Great Raid, Thumbsucker, Catwoman, The Woodsman, Frasier, Abandon, Piñero, After the Storm, Red Planet: Deleted Scenes, Miss Congeniality, Traffic, Red Planet, The Last Producer, The Next Best Thing, Homicide: Life on the Street, Exiled, Woman Undone, Late Night with Conan O'Brien, Follow Me Home, Texas, The River Wild, Clear and Present Danger, Demolition Man, Shadowhunter, Bound by Honor, One Good Cop, Chains of Gold, Bright Angel, Nasty Boys, Capital News, Nasty Boys, Knightwatch, Police Story: Gladiator School, Lovers, Partners & Spies, Juarez
    ## 4 Tyrant, Coco, Girlfriends' Guide to Divorce, Welcome to the Wayne, Puppy Dog Pals, August Falls, Hand of God, The Last Word, To the Bone, TripTank, American Horror Story, Helen Keller vs. Nightwolves, Wallykazam!, NCIS: Naval Criminal Investigative Service, See Dad Run, Ben 10: Omniverse, Welcome to the Wayne, Stan Lee's Mighty 7, Things You Shouldn't Say Past Midnight, Kaijudo: Rise of the Duel Masters, Pound Puppies, Revolution, Grand Theft Auto V, Being Us, Marvel Heroes, Mad, Garbage, Californication, A Haunted House, Envelope, Fairly Legal, Should've Been Romeo, Ringer, Madagascar 3: The Video Game, Summer Song, Hung, It's Always Sunny in Philadelphia, Poolboy: Drowning Out the Fury, Men of a Certain Age, Bad Teacher, Losing Control, The Mentalist, Rango, Rango, Little in Common, Darnell Dawkins: Mouth Guitar Legend, Screwball: The Ted Whitfield Story, A Reuben by Any Other Name, Numb3rs, Stuntmen, Eli Stone, The Spectacular Spider-Man, My Manny, Still Waiting..., Shrinks, El Tigre: The Adventures of Manny Rivera, Batman: Gotham Knight, El Tigre: The Adventures of Manny Rivera, Playing Chicken, Jekyll, Friday Night Lights, Shrinks, Equal Opportunity, The Pre Nup, Random! Cartoons, Brandy & Mr. Whiskers, Hard Scrambled, Open Window, Higglytown Heroes, Uncommon Sense, House M.D., Waiting..., The Closer, Herbie Fully Loaded, CSI: NY, Meet the Fockers, Karroll's Christmas, Monk, Ozzy & Drix, 30 Days Until I'm Famous, Teamo Supremo, Nobody Knows Anything!, Wasabi Tuna, A mi amor mi dulce, Legally Blonde 2: Red, White & Blonde, John Doe, The Perfect You, The West Wing, Legally Blonde, What They Wanted, What They Got, The Division, Two Guys, a Girl and a Pizza Place, Gary & Mike, The Huntress, Tikiville, Slice & Dice, Shriek If You Know What I Did Last Friday the Thirteenth, Sports Night, Blue Moon, The Big Day, The Sterling Chase, Chicago Hope, Providence, Enough Already, All of It, Touched by an Angel, Tracey Takes On..., Pink as the Day She Was Born, Apt. 2F, Clockwatchers, Trading Favors, Just Your Luck, Layin' Low, Johns, Party of Five, Love Is All There Is, Seduced by Madness: The Diane Borchardt Story, Freeway, Out of Order, Virtuosity, Denise Calls Up, The Brady Bunch Movie, ER, Hits!, ABC Afterschool Specials, Renaissance Man, Diagnosis Murder, Sister Act 2: Back in the Habit, Airborne, Beakman's World, L.A. Law, Moment of Truth: Why My Daughter?, The Torkelsons, Just Life, The Blue Men
    ## 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       The Unspeakable, The Green Ghost, That Motherf**Ker, Coco, In My Mother's Arms, A Time of Love and War, Entanglement, Witches of East End, Major Crimes, Saint George, Paranormal Activity: The Marked Ones, A Night in Old Mexico, Weeds, Forever Young at Heart, The Elder Scrolls V: Skyrim, Wake, Boyle Heights, Childrens Hospital, La carretera, Stuntmen, House of Payne, Confessions of a Shopaholic, Moe, Women's Murder Club, Good Morning Agrestic, Tears & Tortillas, Hollywood Familia, All You've Got, Hot Tamale, ER, Prospect, The Ortegas, What Really Happened During the Cuban Missile Crisis, Mister Sterling, Assassination Tango, Never Trust a Serial Killer, Strong Medicine, Wake-Up Call, Island Prey, Kid Quick, That's Life, A Family in Crisis: The Elian Gonzales Story, My Brother the Pig, Team Knight Rider, Four Corners, The Wonderful Ice Cream Suit, The Prophecy II, The Tony Danza Show, The Apostle, Time Well Spent, Men Behaving Badly, Libertad, The Parent 'Hood, Steal Big Steal Little, The Addams Family, Bob, The Doctor, The Flight, Salsa, Matlock, George Burns Comedy Week, Hotel, Scarecrow and Mrs. King
    ## 6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Little Bitches, Glass Jaw, Maurice, Modisto de Señoras, Jane the Virgin, Coco, Elena of Avalor, The Secret Life of Pets, Los árboles mueren de pie, Qué pobres tan ricos, Elsa & Fred, Pulling Strings, Devious Maids, 200 Cartas, Zero Hour, Chiapas, el Corazón del Café, Por ella soy Eva, El cielo en tu mirada, Salvando al Soldado Pérez, Los exitosos Pérez, Regresa, Recién cazado, El agente 00-P2, All Inclusive, Las tontas no van al cielo, Una familia de diez, La fea más bella, I Love Miami, 7 días, Volver, volver, Zapata - El sueño del héroe, Puños rosas, Mujer de madera, Diseñador ambos sexos, Mi destino eres tú

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

# hw06
Yidie Feng  
11/4/2017  


```r
library(tidyverse)
library(stringr)
library(stringi)
library(dplyr)
library(gapminder)
```

###Topic 1: Character Data

####14.2.5 Exercises
- In code that doesn’t use stringr, you’ll often see paste() and paste0(). What’s the difference between the two functions? What stringr function are they equivalent to? How do the functions differ in their handling of NA?

The difference is that `paste()` has default argument of sep=" ". There will be a space between the onjects we want to concatenate. While the argument spe by default for `paste0()` is "".  

```r
paste("Chi", "na")
```

```
## [1] "Chi na"
```

```r
paste0("Chi", "na")
```

```
## [1] "China"
```

They are equivalent to `str_c()` stringr function.

```r
str_c("Chi", "na")
```

```
## [1] "China"
```

We can see that as long as there is a missing value in `str_c()`, it returns a missing value. However, paste functions will convert NA to a string "NA".

```r
str_c("a", NA)
```

```
## [1] NA
```

```r
paste("a", NA)
```

```
## [1] "a NA"
```

```r
paste0("a", NA)
```

```
## [1] "aNA"
```

- In your own words, describe the difference between the sep and collapse arguments to str_c().
sep specifies what will be inserted between every _term_. If we specify collapse, it will return a character vector of length 1 and insert the thing we specified between every _result_.

```r
x <- c("Apple", "Banana", "Pear")

str_c("a", x, "c", sep = "")
```

```
## [1] "aApplec"  "aBananac" "aPearc"
```

```r
str_c("a", x, "c", sep = "-")
```

```
## [1] "a-Apple-c"  "a-Banana-c" "a-Pear-c"
```

```r
str_c("a", x, "c")
```

```
## [1] "aApplec"  "aBananac" "aPearc"
```

```r
str_c("a", x, "c", collapse = "")
```

```
## [1] "aApplecaBananacaPearc"
```

```r
str_c("a", x, "c", collapse = "=")
```

```
## [1] "aApplec=aBananac=aPearc"
```


- Use str_length() and str_sub() to extract the middle character from a string. What will you do if the string has an even number of characters?
If it has an odd number of characters, I will choose the ceiling of the length/2.
If it has an even number of characters. I will just choose length/2, which is the same as its ceiling.
So ceiling of length/2 will work in both cases.

```r
l<-ceiling(str_length(x)/2)
str_sub(x,l,l)
```

```
## [1] "p" "n" "e"
```

- What does str_trim() do? What’s the opposite of str_trim()?
It trims the whitespace from start and end of string. The side argument controls which side you want to remove whitespace.

```r
str_trim(" a ", side = "both")
```

```
## [1] "a"
```

```r
str_trim(" a ", side = "left")
```

```
## [1] "a "
```

```r
str_trim(" a ", side = "right")
```

```
## [1] " a"
```

The opposite is `str_pad()`, which adds white space.

```r
str_pad("a", width=2, side = "left")
```

```
## [1] " a"
```


- Write a function that turns (e.g.) a vector c("a", "b", "c") into the string a, b, and c. Think carefully about what it should do if given a vector of length 0, 1, or 2.

```r
v_to_s<-function(v) {
  l<-length(v)
  if (l>1) {
    part1<-str_c(v[1:l-1], collapse=", ")
    part2<-str_c(part1, v[l], sep=", and ")
    part2
  }
  else {
    v
  }
}

v_to_s(c(""))
```

```
## [1] ""
```

```r
v_to_s(c("a"))
```

```
## [1] "a"
```

```r
v_to_s(c("a","b"))
```

```
## [1] "a, and b"
```

```r
v_to_s(c("a","b","c"))
```

```
## [1] "a, b, and c"
```

```r
v_to_s(c("a","b","c","d"))
```

```
## [1] "a, b, c, and d"
```

####14.3.1.1 Exercises

- What patterns will the regular expression \..\..\.. match? How would you represent it as a string?
It will match any patterns that are a dot followed by anything, a dot followed by anything, a dot followed by anything. 

####14.3.2.1 Exercises

- How would you match the literal string "$^$"?

```r
str_view(c("a$^$", "b$^$b"),"\\$\\^\\$")
```

<!--html_preserve--><div id="htmlwidget-9f87a54dc0e26fb3b8f6" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-9f87a54dc0e26fb3b8f6">{"x":{"html":"<ul>\n  <li>a<span class='match'>$^$\u003c/span>\u003c/li>\n  <li>b<span class='match'>$^$\u003c/span>b\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

- Given the corpus of common words in stringr::words, create regular expressions that find all words that:

Start with “y”.

```r
str_view(stringr::words, "^y", match = T)
```

<!--html_preserve--><div id="htmlwidget-f7d25e61349b4cee805f" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-f7d25e61349b4cee805f">{"x":{"html":"<ul>\n  <li><span class='match'>y\u003c/span>ear\u003c/li>\n  <li><span class='match'>y\u003c/span>es\u003c/li>\n  <li><span class='match'>y\u003c/span>esterday\u003c/li>\n  <li><span class='match'>y\u003c/span>et\u003c/li>\n  <li><span class='match'>y\u003c/span>ou\u003c/li>\n  <li><span class='match'>y\u003c/span>oung\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

End with “x”

```r
str_view(stringr::words, "^x", match = T)
```

<!--html_preserve--><div id="htmlwidget-c3dcb85f7e94094539b9" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-c3dcb85f7e94094539b9">{"x":{"html":"<ul>\n  <li>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Are exactly three letters long. (Don’t cheat by using str_length()!)

```r
str_view(stringr::words, "^...$", match = T)
```

<!--html_preserve--><div id="htmlwidget-a674d052d62a0d12a197" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-a674d052d62a0d12a197">{"x":{"html":"<ul>\n  <li><span class='match'>act\u003c/span>\u003c/li>\n  <li><span class='match'>add\u003c/span>\u003c/li>\n  <li><span class='match'>age\u003c/span>\u003c/li>\n  <li><span class='match'>ago\u003c/span>\u003c/li>\n  <li><span class='match'>air\u003c/span>\u003c/li>\n  <li><span class='match'>all\u003c/span>\u003c/li>\n  <li><span class='match'>and\u003c/span>\u003c/li>\n  <li><span class='match'>any\u003c/span>\u003c/li>\n  <li><span class='match'>arm\u003c/span>\u003c/li>\n  <li><span class='match'>art\u003c/span>\u003c/li>\n  <li><span class='match'>ask\u003c/span>\u003c/li>\n  <li><span class='match'>bad\u003c/span>\u003c/li>\n  <li><span class='match'>bag\u003c/span>\u003c/li>\n  <li><span class='match'>bar\u003c/span>\u003c/li>\n  <li><span class='match'>bed\u003c/span>\u003c/li>\n  <li><span class='match'>bet\u003c/span>\u003c/li>\n  <li><span class='match'>big\u003c/span>\u003c/li>\n  <li><span class='match'>bit\u003c/span>\u003c/li>\n  <li><span class='match'>box\u003c/span>\u003c/li>\n  <li><span class='match'>boy\u003c/span>\u003c/li>\n  <li><span class='match'>bus\u003c/span>\u003c/li>\n  <li><span class='match'>but\u003c/span>\u003c/li>\n  <li><span class='match'>buy\u003c/span>\u003c/li>\n  <li><span class='match'>can\u003c/span>\u003c/li>\n  <li><span class='match'>car\u003c/span>\u003c/li>\n  <li><span class='match'>cat\u003c/span>\u003c/li>\n  <li><span class='match'>cup\u003c/span>\u003c/li>\n  <li><span class='match'>cut\u003c/span>\u003c/li>\n  <li><span class='match'>dad\u003c/span>\u003c/li>\n  <li><span class='match'>day\u003c/span>\u003c/li>\n  <li><span class='match'>die\u003c/span>\u003c/li>\n  <li><span class='match'>dog\u003c/span>\u003c/li>\n  <li><span class='match'>dry\u003c/span>\u003c/li>\n  <li><span class='match'>due\u003c/span>\u003c/li>\n  <li><span class='match'>eat\u003c/span>\u003c/li>\n  <li><span class='match'>egg\u003c/span>\u003c/li>\n  <li><span class='match'>end\u003c/span>\u003c/li>\n  <li><span class='match'>eye\u003c/span>\u003c/li>\n  <li><span class='match'>far\u003c/span>\u003c/li>\n  <li><span class='match'>few\u003c/span>\u003c/li>\n  <li><span class='match'>fit\u003c/span>\u003c/li>\n  <li><span class='match'>fly\u003c/span>\u003c/li>\n  <li><span class='match'>for\u003c/span>\u003c/li>\n  <li><span class='match'>fun\u003c/span>\u003c/li>\n  <li><span class='match'>gas\u003c/span>\u003c/li>\n  <li><span class='match'>get\u003c/span>\u003c/li>\n  <li><span class='match'>god\u003c/span>\u003c/li>\n  <li><span class='match'>guy\u003c/span>\u003c/li>\n  <li><span class='match'>hit\u003c/span>\u003c/li>\n  <li><span class='match'>hot\u003c/span>\u003c/li>\n  <li><span class='match'>how\u003c/span>\u003c/li>\n  <li><span class='match'>job\u003c/span>\u003c/li>\n  <li><span class='match'>key\u003c/span>\u003c/li>\n  <li><span class='match'>kid\u003c/span>\u003c/li>\n  <li><span class='match'>lad\u003c/span>\u003c/li>\n  <li><span class='match'>law\u003c/span>\u003c/li>\n  <li><span class='match'>lay\u003c/span>\u003c/li>\n  <li><span class='match'>leg\u003c/span>\u003c/li>\n  <li><span class='match'>let\u003c/span>\u003c/li>\n  <li><span class='match'>lie\u003c/span>\u003c/li>\n  <li><span class='match'>lot\u003c/span>\u003c/li>\n  <li><span class='match'>low\u003c/span>\u003c/li>\n  <li><span class='match'>man\u003c/span>\u003c/li>\n  <li><span class='match'>may\u003c/span>\u003c/li>\n  <li><span class='match'>mrs\u003c/span>\u003c/li>\n  <li><span class='match'>new\u003c/span>\u003c/li>\n  <li><span class='match'>non\u003c/span>\u003c/li>\n  <li><span class='match'>not\u003c/span>\u003c/li>\n  <li><span class='match'>now\u003c/span>\u003c/li>\n  <li><span class='match'>odd\u003c/span>\u003c/li>\n  <li><span class='match'>off\u003c/span>\u003c/li>\n  <li><span class='match'>old\u003c/span>\u003c/li>\n  <li><span class='match'>one\u003c/span>\u003c/li>\n  <li><span class='match'>out\u003c/span>\u003c/li>\n  <li><span class='match'>own\u003c/span>\u003c/li>\n  <li><span class='match'>pay\u003c/span>\u003c/li>\n  <li><span class='match'>per\u003c/span>\u003c/li>\n  <li><span class='match'>put\u003c/span>\u003c/li>\n  <li><span class='match'>red\u003c/span>\u003c/li>\n  <li><span class='match'>rid\u003c/span>\u003c/li>\n  <li><span class='match'>run\u003c/span>\u003c/li>\n  <li><span class='match'>say\u003c/span>\u003c/li>\n  <li><span class='match'>see\u003c/span>\u003c/li>\n  <li><span class='match'>set\u003c/span>\u003c/li>\n  <li><span class='match'>sex\u003c/span>\u003c/li>\n  <li><span class='match'>she\u003c/span>\u003c/li>\n  <li><span class='match'>sir\u003c/span>\u003c/li>\n  <li><span class='match'>sit\u003c/span>\u003c/li>\n  <li><span class='match'>six\u003c/span>\u003c/li>\n  <li><span class='match'>son\u003c/span>\u003c/li>\n  <li><span class='match'>sun\u003c/span>\u003c/li>\n  <li><span class='match'>tax\u003c/span>\u003c/li>\n  <li><span class='match'>tea\u003c/span>\u003c/li>\n  <li><span class='match'>ten\u003c/span>\u003c/li>\n  <li><span class='match'>the\u003c/span>\u003c/li>\n  <li><span class='match'>tie\u003c/span>\u003c/li>\n  <li><span class='match'>too\u003c/span>\u003c/li>\n  <li><span class='match'>top\u003c/span>\u003c/li>\n  <li><span class='match'>try\u003c/span>\u003c/li>\n  <li><span class='match'>two\u003c/span>\u003c/li>\n  <li><span class='match'>use\u003c/span>\u003c/li>\n  <li><span class='match'>war\u003c/span>\u003c/li>\n  <li><span class='match'>way\u003c/span>\u003c/li>\n  <li><span class='match'>wee\u003c/span>\u003c/li>\n  <li><span class='match'>who\u003c/span>\u003c/li>\n  <li><span class='match'>why\u003c/span>\u003c/li>\n  <li><span class='match'>win\u003c/span>\u003c/li>\n  <li><span class='match'>yes\u003c/span>\u003c/li>\n  <li><span class='match'>yet\u003c/span>\u003c/li>\n  <li><span class='match'>you\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Have seven letters or more.

```r
str_view(stringr::words, ".......", match = T)
```

<!--html_preserve--><div id="htmlwidget-1a1f7f3671eec7b009f4" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-1a1f7f3671eec7b009f4">{"x":{"html":"<ul>\n  <li><span class='match'>absolut\u003c/span>e\u003c/li>\n  <li><span class='match'>account\u003c/span>\u003c/li>\n  <li><span class='match'>achieve\u003c/span>\u003c/li>\n  <li><span class='match'>address\u003c/span>\u003c/li>\n  <li><span class='match'>adverti\u003c/span>se\u003c/li>\n  <li><span class='match'>afterno\u003c/span>on\u003c/li>\n  <li><span class='match'>against\u003c/span>\u003c/li>\n  <li><span class='match'>already\u003c/span>\u003c/li>\n  <li><span class='match'>alright\u003c/span>\u003c/li>\n  <li><span class='match'>althoug\u003c/span>h\u003c/li>\n  <li><span class='match'>america\u003c/span>\u003c/li>\n  <li><span class='match'>another\u003c/span>\u003c/li>\n  <li><span class='match'>apparen\u003c/span>t\u003c/li>\n  <li><span class='match'>appoint\u003c/span>\u003c/li>\n  <li><span class='match'>approac\u003c/span>h\u003c/li>\n  <li><span class='match'>appropr\u003c/span>iate\u003c/li>\n  <li><span class='match'>arrange\u003c/span>\u003c/li>\n  <li><span class='match'>associa\u003c/span>te\u003c/li>\n  <li><span class='match'>authori\u003c/span>ty\u003c/li>\n  <li><span class='match'>availab\u003c/span>le\u003c/li>\n  <li><span class='match'>balance\u003c/span>\u003c/li>\n  <li><span class='match'>because\u003c/span>\u003c/li>\n  <li><span class='match'>believe\u003c/span>\u003c/li>\n  <li><span class='match'>benefit\u003c/span>\u003c/li>\n  <li><span class='match'>between\u003c/span>\u003c/li>\n  <li><span class='match'>brillia\u003c/span>nt\u003c/li>\n  <li><span class='match'>britain\u003c/span>\u003c/li>\n  <li><span class='match'>brother\u003c/span>\u003c/li>\n  <li><span class='match'>busines\u003c/span>s\u003c/li>\n  <li><span class='match'>certain\u003c/span>\u003c/li>\n  <li><span class='match'>chairma\u003c/span>n\u003c/li>\n  <li><span class='match'>charact\u003c/span>er\u003c/li>\n  <li><span class='match'>Christm\u003c/span>as\u003c/li>\n  <li><span class='match'>colleag\u003c/span>ue\u003c/li>\n  <li><span class='match'>collect\u003c/span>\u003c/li>\n  <li><span class='match'>college\u003c/span>\u003c/li>\n  <li><span class='match'>comment\u003c/span>\u003c/li>\n  <li><span class='match'>committ\u003c/span>ee\u003c/li>\n  <li><span class='match'>communi\u003c/span>ty\u003c/li>\n  <li><span class='match'>company\u003c/span>\u003c/li>\n  <li><span class='match'>compare\u003c/span>\u003c/li>\n  <li><span class='match'>complet\u003c/span>e\u003c/li>\n  <li><span class='match'>compute\u003c/span>\u003c/li>\n  <li><span class='match'>concern\u003c/span>\u003c/li>\n  <li><span class='match'>conditi\u003c/span>on\u003c/li>\n  <li><span class='match'>conside\u003c/span>r\u003c/li>\n  <li><span class='match'>consult\u003c/span>\u003c/li>\n  <li><span class='match'>contact\u003c/span>\u003c/li>\n  <li><span class='match'>continu\u003c/span>e\u003c/li>\n  <li><span class='match'>contrac\u003c/span>t\u003c/li>\n  <li><span class='match'>control\u003c/span>\u003c/li>\n  <li><span class='match'>convers\u003c/span>e\u003c/li>\n  <li><span class='match'>correct\u003c/span>\u003c/li>\n  <li><span class='match'>council\u003c/span>\u003c/li>\n  <li><span class='match'>country\u003c/span>\u003c/li>\n  <li><span class='match'>current\u003c/span>\u003c/li>\n  <li><span class='match'>decisio\u003c/span>n\u003c/li>\n  <li><span class='match'>definit\u003c/span>e\u003c/li>\n  <li><span class='match'>departm\u003c/span>ent\u003c/li>\n  <li><span class='match'>describ\u003c/span>e\u003c/li>\n  <li><span class='match'>develop\u003c/span>\u003c/li>\n  <li><span class='match'>differe\u003c/span>nce\u003c/li>\n  <li><span class='match'>difficu\u003c/span>lt\u003c/li>\n  <li><span class='match'>discuss\u003c/span>\u003c/li>\n  <li><span class='match'>distric\u003c/span>t\u003c/li>\n  <li><span class='match'>documen\u003c/span>t\u003c/li>\n  <li><span class='match'>economy\u003c/span>\u003c/li>\n  <li><span class='match'>educate\u003c/span>\u003c/li>\n  <li><span class='match'>electri\u003c/span>c\u003c/li>\n  <li><span class='match'>encoura\u003c/span>ge\u003c/li>\n  <li><span class='match'>english\u003c/span>\u003c/li>\n  <li><span class='match'>environ\u003c/span>ment\u003c/li>\n  <li><span class='match'>especia\u003c/span>l\u003c/li>\n  <li><span class='match'>evening\u003c/span>\u003c/li>\n  <li><span class='match'>evidenc\u003c/span>e\u003c/li>\n  <li><span class='match'>example\u003c/span>\u003c/li>\n  <li><span class='match'>exercis\u003c/span>e\u003c/li>\n  <li><span class='match'>expense\u003c/span>\u003c/li>\n  <li><span class='match'>experie\u003c/span>nce\u003c/li>\n  <li><span class='match'>explain\u003c/span>\u003c/li>\n  <li><span class='match'>express\u003c/span>\u003c/li>\n  <li><span class='match'>finance\u003c/span>\u003c/li>\n  <li><span class='match'>fortune\u003c/span>\u003c/li>\n  <li><span class='match'>forward\u003c/span>\u003c/li>\n  <li><span class='match'>functio\u003c/span>n\u003c/li>\n  <li><span class='match'>further\u003c/span>\u003c/li>\n  <li><span class='match'>general\u003c/span>\u003c/li>\n  <li><span class='match'>germany\u003c/span>\u003c/li>\n  <li><span class='match'>goodbye\u003c/span>\u003c/li>\n  <li><span class='match'>history\u003c/span>\u003c/li>\n  <li><span class='match'>holiday\u003c/span>\u003c/li>\n  <li><span class='match'>hospita\u003c/span>l\u003c/li>\n  <li><span class='match'>however\u003c/span>\u003c/li>\n  <li><span class='match'>hundred\u003c/span>\u003c/li>\n  <li><span class='match'>husband\u003c/span>\u003c/li>\n  <li><span class='match'>identif\u003c/span>y\u003c/li>\n  <li><span class='match'>imagine\u003c/span>\u003c/li>\n  <li><span class='match'>importa\u003c/span>nt\u003c/li>\n  <li><span class='match'>improve\u003c/span>\u003c/li>\n  <li><span class='match'>include\u003c/span>\u003c/li>\n  <li><span class='match'>increas\u003c/span>e\u003c/li>\n  <li><span class='match'>individ\u003c/span>ual\u003c/li>\n  <li><span class='match'>industr\u003c/span>y\u003c/li>\n  <li><span class='match'>instead\u003c/span>\u003c/li>\n  <li><span class='match'>interes\u003c/span>t\u003c/li>\n  <li><span class='match'>introdu\u003c/span>ce\u003c/li>\n  <li><span class='match'>involve\u003c/span>\u003c/li>\n  <li><span class='match'>kitchen\u003c/span>\u003c/li>\n  <li><span class='match'>languag\u003c/span>e\u003c/li>\n  <li><span class='match'>machine\u003c/span>\u003c/li>\n  <li><span class='match'>meaning\u003c/span>\u003c/li>\n  <li><span class='match'>measure\u003c/span>\u003c/li>\n  <li><span class='match'>mention\u003c/span>\u003c/li>\n  <li><span class='match'>million\u003c/span>\u003c/li>\n  <li><span class='match'>ministe\u003c/span>r\u003c/li>\n  <li><span class='match'>morning\u003c/span>\u003c/li>\n  <li><span class='match'>necessa\u003c/span>ry\u003c/li>\n  <li><span class='match'>obvious\u003c/span>\u003c/li>\n  <li><span class='match'>occasio\u003c/span>n\u003c/li>\n  <li><span class='match'>operate\u003c/span>\u003c/li>\n  <li><span class='match'>opportu\u003c/span>nity\u003c/li>\n  <li><span class='match'>organiz\u003c/span>e\u003c/li>\n  <li><span class='match'>origina\u003c/span>l\u003c/li>\n  <li><span class='match'>otherwi\u003c/span>se\u003c/li>\n  <li><span class='match'>paragra\u003c/span>ph\u003c/li>\n  <li><span class='match'>particu\u003c/span>lar\u003c/li>\n  <li><span class='match'>pension\u003c/span>\u003c/li>\n  <li><span class='match'>percent\u003c/span>\u003c/li>\n  <li><span class='match'>perfect\u003c/span>\u003c/li>\n  <li><span class='match'>perhaps\u003c/span>\u003c/li>\n  <li><span class='match'>photogr\u003c/span>aph\u003c/li>\n  <li><span class='match'>picture\u003c/span>\u003c/li>\n  <li><span class='match'>politic\u003c/span>\u003c/li>\n  <li><span class='match'>positio\u003c/span>n\u003c/li>\n  <li><span class='match'>positiv\u003c/span>e\u003c/li>\n  <li><span class='match'>possibl\u003c/span>e\u003c/li>\n  <li><span class='match'>practis\u003c/span>e\u003c/li>\n  <li><span class='match'>prepare\u003c/span>\u003c/li>\n  <li><span class='match'>present\u003c/span>\u003c/li>\n  <li><span class='match'>pressur\u003c/span>e\u003c/li>\n  <li><span class='match'>presume\u003c/span>\u003c/li>\n  <li><span class='match'>previou\u003c/span>s\u003c/li>\n  <li><span class='match'>private\u003c/span>\u003c/li>\n  <li><span class='match'>probabl\u003c/span>e\u003c/li>\n  <li><span class='match'>problem\u003c/span>\u003c/li>\n  <li><span class='match'>proceed\u003c/span>\u003c/li>\n  <li><span class='match'>process\u003c/span>\u003c/li>\n  <li><span class='match'>produce\u003c/span>\u003c/li>\n  <li><span class='match'>product\u003c/span>\u003c/li>\n  <li><span class='match'>program\u003c/span>me\u003c/li>\n  <li><span class='match'>project\u003c/span>\u003c/li>\n  <li><span class='match'>propose\u003c/span>\u003c/li>\n  <li><span class='match'>protect\u003c/span>\u003c/li>\n  <li><span class='match'>provide\u003c/span>\u003c/li>\n  <li><span class='match'>purpose\u003c/span>\u003c/li>\n  <li><span class='match'>quality\u003c/span>\u003c/li>\n  <li><span class='match'>quarter\u003c/span>\u003c/li>\n  <li><span class='match'>questio\u003c/span>n\u003c/li>\n  <li><span class='match'>realise\u003c/span>\u003c/li>\n  <li><span class='match'>receive\u003c/span>\u003c/li>\n  <li><span class='match'>recogni\u003c/span>ze\u003c/li>\n  <li><span class='match'>recomme\u003c/span>nd\u003c/li>\n  <li><span class='match'>relatio\u003c/span>n\u003c/li>\n  <li><span class='match'>remembe\u003c/span>r\u003c/li>\n  <li><span class='match'>represe\u003c/span>nt\u003c/li>\n  <li><span class='match'>require\u003c/span>\u003c/li>\n  <li><span class='match'>researc\u003c/span>h\u003c/li>\n  <li><span class='match'>resourc\u003c/span>e\u003c/li>\n  <li><span class='match'>respect\u003c/span>\u003c/li>\n  <li><span class='match'>respons\u003c/span>ible\u003c/li>\n  <li><span class='match'>saturda\u003c/span>y\u003c/li>\n  <li><span class='match'>science\u003c/span>\u003c/li>\n  <li><span class='match'>scotlan\u003c/span>d\u003c/li>\n  <li><span class='match'>secreta\u003c/span>ry\u003c/li>\n  <li><span class='match'>section\u003c/span>\u003c/li>\n  <li><span class='match'>separat\u003c/span>e\u003c/li>\n  <li><span class='match'>serious\u003c/span>\u003c/li>\n  <li><span class='match'>service\u003c/span>\u003c/li>\n  <li><span class='match'>similar\u003c/span>\u003c/li>\n  <li><span class='match'>situate\u003c/span>\u003c/li>\n  <li><span class='match'>society\u003c/span>\u003c/li>\n  <li><span class='match'>special\u003c/span>\u003c/li>\n  <li><span class='match'>specifi\u003c/span>c\u003c/li>\n  <li><span class='match'>standar\u003c/span>d\u003c/li>\n  <li><span class='match'>station\u003c/span>\u003c/li>\n  <li><span class='match'>straigh\u003c/span>t\u003c/li>\n  <li><span class='match'>strateg\u003c/span>y\u003c/li>\n  <li><span class='match'>structu\u003c/span>re\u003c/li>\n  <li><span class='match'>student\u003c/span>\u003c/li>\n  <li><span class='match'>subject\u003c/span>\u003c/li>\n  <li><span class='match'>succeed\u003c/span>\u003c/li>\n  <li><span class='match'>suggest\u003c/span>\u003c/li>\n  <li><span class='match'>support\u003c/span>\u003c/li>\n  <li><span class='match'>suppose\u003c/span>\u003c/li>\n  <li><span class='match'>surpris\u003c/span>e\u003c/li>\n  <li><span class='match'>telepho\u003c/span>ne\u003c/li>\n  <li><span class='match'>televis\u003c/span>ion\u003c/li>\n  <li><span class='match'>terribl\u003c/span>e\u003c/li>\n  <li><span class='match'>therefo\u003c/span>re\u003c/li>\n  <li><span class='match'>thirtee\u003c/span>n\u003c/li>\n  <li><span class='match'>thousan\u003c/span>d\u003c/li>\n  <li><span class='match'>through\u003c/span>\u003c/li>\n  <li><span class='match'>thursda\u003c/span>y\u003c/li>\n  <li><span class='match'>togethe\u003c/span>r\u003c/li>\n  <li><span class='match'>tomorro\u003c/span>w\u003c/li>\n  <li><span class='match'>tonight\u003c/span>\u003c/li>\n  <li><span class='match'>traffic\u003c/span>\u003c/li>\n  <li><span class='match'>transpo\u003c/span>rt\u003c/li>\n  <li><span class='match'>trouble\u003c/span>\u003c/li>\n  <li><span class='match'>tuesday\u003c/span>\u003c/li>\n  <li><span class='match'>underst\u003c/span>and\u003c/li>\n  <li><span class='match'>univers\u003c/span>ity\u003c/li>\n  <li><span class='match'>various\u003c/span>\u003c/li>\n  <li><span class='match'>village\u003c/span>\u003c/li>\n  <li><span class='match'>wednesd\u003c/span>ay\u003c/li>\n  <li><span class='match'>welcome\u003c/span>\u003c/li>\n  <li><span class='match'>whether\u003c/span>\u003c/li>\n  <li><span class='match'>without\u003c/span>\u003c/li>\n  <li><span class='match'>yesterd\u003c/span>ay\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

####14.3.3.1 Exercises

- Create regular expressions to find all words that:

Start with a vowel.

```r
str_view(stringr::words, "^[aeiou]", match = T)
```

<!--html_preserve--><div id="htmlwidget-4a5fc0e11abac18414d5" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-4a5fc0e11abac18414d5">{"x":{"html":"<ul>\n  <li><span class='match'>a\u003c/span>\u003c/li>\n  <li><span class='match'>a\u003c/span>ble\u003c/li>\n  <li><span class='match'>a\u003c/span>bout\u003c/li>\n  <li><span class='match'>a\u003c/span>bsolute\u003c/li>\n  <li><span class='match'>a\u003c/span>ccept\u003c/li>\n  <li><span class='match'>a\u003c/span>ccount\u003c/li>\n  <li><span class='match'>a\u003c/span>chieve\u003c/li>\n  <li><span class='match'>a\u003c/span>cross\u003c/li>\n  <li><span class='match'>a\u003c/span>ct\u003c/li>\n  <li><span class='match'>a\u003c/span>ctive\u003c/li>\n  <li><span class='match'>a\u003c/span>ctual\u003c/li>\n  <li><span class='match'>a\u003c/span>dd\u003c/li>\n  <li><span class='match'>a\u003c/span>ddress\u003c/li>\n  <li><span class='match'>a\u003c/span>dmit\u003c/li>\n  <li><span class='match'>a\u003c/span>dvertise\u003c/li>\n  <li><span class='match'>a\u003c/span>ffect\u003c/li>\n  <li><span class='match'>a\u003c/span>fford\u003c/li>\n  <li><span class='match'>a\u003c/span>fter\u003c/li>\n  <li><span class='match'>a\u003c/span>fternoon\u003c/li>\n  <li><span class='match'>a\u003c/span>gain\u003c/li>\n  <li><span class='match'>a\u003c/span>gainst\u003c/li>\n  <li><span class='match'>a\u003c/span>ge\u003c/li>\n  <li><span class='match'>a\u003c/span>gent\u003c/li>\n  <li><span class='match'>a\u003c/span>go\u003c/li>\n  <li><span class='match'>a\u003c/span>gree\u003c/li>\n  <li><span class='match'>a\u003c/span>ir\u003c/li>\n  <li><span class='match'>a\u003c/span>ll\u003c/li>\n  <li><span class='match'>a\u003c/span>llow\u003c/li>\n  <li><span class='match'>a\u003c/span>lmost\u003c/li>\n  <li><span class='match'>a\u003c/span>long\u003c/li>\n  <li><span class='match'>a\u003c/span>lready\u003c/li>\n  <li><span class='match'>a\u003c/span>lright\u003c/li>\n  <li><span class='match'>a\u003c/span>lso\u003c/li>\n  <li><span class='match'>a\u003c/span>lthough\u003c/li>\n  <li><span class='match'>a\u003c/span>lways\u003c/li>\n  <li><span class='match'>a\u003c/span>merica\u003c/li>\n  <li><span class='match'>a\u003c/span>mount\u003c/li>\n  <li><span class='match'>a\u003c/span>nd\u003c/li>\n  <li><span class='match'>a\u003c/span>nother\u003c/li>\n  <li><span class='match'>a\u003c/span>nswer\u003c/li>\n  <li><span class='match'>a\u003c/span>ny\u003c/li>\n  <li><span class='match'>a\u003c/span>part\u003c/li>\n  <li><span class='match'>a\u003c/span>pparent\u003c/li>\n  <li><span class='match'>a\u003c/span>ppear\u003c/li>\n  <li><span class='match'>a\u003c/span>pply\u003c/li>\n  <li><span class='match'>a\u003c/span>ppoint\u003c/li>\n  <li><span class='match'>a\u003c/span>pproach\u003c/li>\n  <li><span class='match'>a\u003c/span>ppropriate\u003c/li>\n  <li><span class='match'>a\u003c/span>rea\u003c/li>\n  <li><span class='match'>a\u003c/span>rgue\u003c/li>\n  <li><span class='match'>a\u003c/span>rm\u003c/li>\n  <li><span class='match'>a\u003c/span>round\u003c/li>\n  <li><span class='match'>a\u003c/span>rrange\u003c/li>\n  <li><span class='match'>a\u003c/span>rt\u003c/li>\n  <li><span class='match'>a\u003c/span>s\u003c/li>\n  <li><span class='match'>a\u003c/span>sk\u003c/li>\n  <li><span class='match'>a\u003c/span>ssociate\u003c/li>\n  <li><span class='match'>a\u003c/span>ssume\u003c/li>\n  <li><span class='match'>a\u003c/span>t\u003c/li>\n  <li><span class='match'>a\u003c/span>ttend\u003c/li>\n  <li><span class='match'>a\u003c/span>uthority\u003c/li>\n  <li><span class='match'>a\u003c/span>vailable\u003c/li>\n  <li><span class='match'>a\u003c/span>ware\u003c/li>\n  <li><span class='match'>a\u003c/span>way\u003c/li>\n  <li><span class='match'>a\u003c/span>wful\u003c/li>\n  <li><span class='match'>e\u003c/span>ach\u003c/li>\n  <li><span class='match'>e\u003c/span>arly\u003c/li>\n  <li><span class='match'>e\u003c/span>ast\u003c/li>\n  <li><span class='match'>e\u003c/span>asy\u003c/li>\n  <li><span class='match'>e\u003c/span>at\u003c/li>\n  <li><span class='match'>e\u003c/span>conomy\u003c/li>\n  <li><span class='match'>e\u003c/span>ducate\u003c/li>\n  <li><span class='match'>e\u003c/span>ffect\u003c/li>\n  <li><span class='match'>e\u003c/span>gg\u003c/li>\n  <li><span class='match'>e\u003c/span>ight\u003c/li>\n  <li><span class='match'>e\u003c/span>ither\u003c/li>\n  <li><span class='match'>e\u003c/span>lect\u003c/li>\n  <li><span class='match'>e\u003c/span>lectric\u003c/li>\n  <li><span class='match'>e\u003c/span>leven\u003c/li>\n  <li><span class='match'>e\u003c/span>lse\u003c/li>\n  <li><span class='match'>e\u003c/span>mploy\u003c/li>\n  <li><span class='match'>e\u003c/span>ncourage\u003c/li>\n  <li><span class='match'>e\u003c/span>nd\u003c/li>\n  <li><span class='match'>e\u003c/span>ngine\u003c/li>\n  <li><span class='match'>e\u003c/span>nglish\u003c/li>\n  <li><span class='match'>e\u003c/span>njoy\u003c/li>\n  <li><span class='match'>e\u003c/span>nough\u003c/li>\n  <li><span class='match'>e\u003c/span>nter\u003c/li>\n  <li><span class='match'>e\u003c/span>nvironment\u003c/li>\n  <li><span class='match'>e\u003c/span>qual\u003c/li>\n  <li><span class='match'>e\u003c/span>special\u003c/li>\n  <li><span class='match'>e\u003c/span>urope\u003c/li>\n  <li><span class='match'>e\u003c/span>ven\u003c/li>\n  <li><span class='match'>e\u003c/span>vening\u003c/li>\n  <li><span class='match'>e\u003c/span>ver\u003c/li>\n  <li><span class='match'>e\u003c/span>very\u003c/li>\n  <li><span class='match'>e\u003c/span>vidence\u003c/li>\n  <li><span class='match'>e\u003c/span>xact\u003c/li>\n  <li><span class='match'>e\u003c/span>xample\u003c/li>\n  <li><span class='match'>e\u003c/span>xcept\u003c/li>\n  <li><span class='match'>e\u003c/span>xcuse\u003c/li>\n  <li><span class='match'>e\u003c/span>xercise\u003c/li>\n  <li><span class='match'>e\u003c/span>xist\u003c/li>\n  <li><span class='match'>e\u003c/span>xpect\u003c/li>\n  <li><span class='match'>e\u003c/span>xpense\u003c/li>\n  <li><span class='match'>e\u003c/span>xperience\u003c/li>\n  <li><span class='match'>e\u003c/span>xplain\u003c/li>\n  <li><span class='match'>e\u003c/span>xpress\u003c/li>\n  <li><span class='match'>e\u003c/span>xtra\u003c/li>\n  <li><span class='match'>e\u003c/span>ye\u003c/li>\n  <li><span class='match'>i\u003c/span>dea\u003c/li>\n  <li><span class='match'>i\u003c/span>dentify\u003c/li>\n  <li><span class='match'>i\u003c/span>f\u003c/li>\n  <li><span class='match'>i\u003c/span>magine\u003c/li>\n  <li><span class='match'>i\u003c/span>mportant\u003c/li>\n  <li><span class='match'>i\u003c/span>mprove\u003c/li>\n  <li><span class='match'>i\u003c/span>n\u003c/li>\n  <li><span class='match'>i\u003c/span>nclude\u003c/li>\n  <li><span class='match'>i\u003c/span>ncome\u003c/li>\n  <li><span class='match'>i\u003c/span>ncrease\u003c/li>\n  <li><span class='match'>i\u003c/span>ndeed\u003c/li>\n  <li><span class='match'>i\u003c/span>ndividual\u003c/li>\n  <li><span class='match'>i\u003c/span>ndustry\u003c/li>\n  <li><span class='match'>i\u003c/span>nform\u003c/li>\n  <li><span class='match'>i\u003c/span>nside\u003c/li>\n  <li><span class='match'>i\u003c/span>nstead\u003c/li>\n  <li><span class='match'>i\u003c/span>nsure\u003c/li>\n  <li><span class='match'>i\u003c/span>nterest\u003c/li>\n  <li><span class='match'>i\u003c/span>nto\u003c/li>\n  <li><span class='match'>i\u003c/span>ntroduce\u003c/li>\n  <li><span class='match'>i\u003c/span>nvest\u003c/li>\n  <li><span class='match'>i\u003c/span>nvolve\u003c/li>\n  <li><span class='match'>i\u003c/span>ssue\u003c/li>\n  <li><span class='match'>i\u003c/span>t\u003c/li>\n  <li><span class='match'>i\u003c/span>tem\u003c/li>\n  <li><span class='match'>o\u003c/span>bvious\u003c/li>\n  <li><span class='match'>o\u003c/span>ccasion\u003c/li>\n  <li><span class='match'>o\u003c/span>dd\u003c/li>\n  <li><span class='match'>o\u003c/span>f\u003c/li>\n  <li><span class='match'>o\u003c/span>ff\u003c/li>\n  <li><span class='match'>o\u003c/span>ffer\u003c/li>\n  <li><span class='match'>o\u003c/span>ffice\u003c/li>\n  <li><span class='match'>o\u003c/span>ften\u003c/li>\n  <li><span class='match'>o\u003c/span>kay\u003c/li>\n  <li><span class='match'>o\u003c/span>ld\u003c/li>\n  <li><span class='match'>o\u003c/span>n\u003c/li>\n  <li><span class='match'>o\u003c/span>nce\u003c/li>\n  <li><span class='match'>o\u003c/span>ne\u003c/li>\n  <li><span class='match'>o\u003c/span>nly\u003c/li>\n  <li><span class='match'>o\u003c/span>pen\u003c/li>\n  <li><span class='match'>o\u003c/span>perate\u003c/li>\n  <li><span class='match'>o\u003c/span>pportunity\u003c/li>\n  <li><span class='match'>o\u003c/span>ppose\u003c/li>\n  <li><span class='match'>o\u003c/span>r\u003c/li>\n  <li><span class='match'>o\u003c/span>rder\u003c/li>\n  <li><span class='match'>o\u003c/span>rganize\u003c/li>\n  <li><span class='match'>o\u003c/span>riginal\u003c/li>\n  <li><span class='match'>o\u003c/span>ther\u003c/li>\n  <li><span class='match'>o\u003c/span>therwise\u003c/li>\n  <li><span class='match'>o\u003c/span>ught\u003c/li>\n  <li><span class='match'>o\u003c/span>ut\u003c/li>\n  <li><span class='match'>o\u003c/span>ver\u003c/li>\n  <li><span class='match'>o\u003c/span>wn\u003c/li>\n  <li><span class='match'>u\u003c/span>nder\u003c/li>\n  <li><span class='match'>u\u003c/span>nderstand\u003c/li>\n  <li><span class='match'>u\u003c/span>nion\u003c/li>\n  <li><span class='match'>u\u003c/span>nit\u003c/li>\n  <li><span class='match'>u\u003c/span>nite\u003c/li>\n  <li><span class='match'>u\u003c/span>niversity\u003c/li>\n  <li><span class='match'>u\u003c/span>nless\u003c/li>\n  <li><span class='match'>u\u003c/span>ntil\u003c/li>\n  <li><span class='match'>u\u003c/span>p\u003c/li>\n  <li><span class='match'>u\u003c/span>pon\u003c/li>\n  <li><span class='match'>u\u003c/span>se\u003c/li>\n  <li><span class='match'>u\u003c/span>sual\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

That only contain consonants. (Hint: thinking about matching “not”-vowels.)

```r
str_view(stringr::words, "[^aeiou]", match = T)
```

<!--html_preserve--><div id="htmlwidget-fa314a2ec54acba45461" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-fa314a2ec54acba45461">{"x":{"html":"<ul>\n  <li>a<span class='match'>b\u003c/span>le\u003c/li>\n  <li>a<span class='match'>b\u003c/span>out\u003c/li>\n  <li>a<span class='match'>b\u003c/span>solute\u003c/li>\n  <li>a<span class='match'>c\u003c/span>cept\u003c/li>\n  <li>a<span class='match'>c\u003c/span>count\u003c/li>\n  <li>a<span class='match'>c\u003c/span>hieve\u003c/li>\n  <li>a<span class='match'>c\u003c/span>ross\u003c/li>\n  <li>a<span class='match'>c\u003c/span>t\u003c/li>\n  <li>a<span class='match'>c\u003c/span>tive\u003c/li>\n  <li>a<span class='match'>c\u003c/span>tual\u003c/li>\n  <li>a<span class='match'>d\u003c/span>d\u003c/li>\n  <li>a<span class='match'>d\u003c/span>dress\u003c/li>\n  <li>a<span class='match'>d\u003c/span>mit\u003c/li>\n  <li>a<span class='match'>d\u003c/span>vertise\u003c/li>\n  <li>a<span class='match'>f\u003c/span>fect\u003c/li>\n  <li>a<span class='match'>f\u003c/span>ford\u003c/li>\n  <li>a<span class='match'>f\u003c/span>ter\u003c/li>\n  <li>a<span class='match'>f\u003c/span>ternoon\u003c/li>\n  <li>a<span class='match'>g\u003c/span>ain\u003c/li>\n  <li>a<span class='match'>g\u003c/span>ainst\u003c/li>\n  <li>a<span class='match'>g\u003c/span>e\u003c/li>\n  <li>a<span class='match'>g\u003c/span>ent\u003c/li>\n  <li>a<span class='match'>g\u003c/span>o\u003c/li>\n  <li>a<span class='match'>g\u003c/span>ree\u003c/li>\n  <li>ai<span class='match'>r\u003c/span>\u003c/li>\n  <li>a<span class='match'>l\u003c/span>l\u003c/li>\n  <li>a<span class='match'>l\u003c/span>low\u003c/li>\n  <li>a<span class='match'>l\u003c/span>most\u003c/li>\n  <li>a<span class='match'>l\u003c/span>ong\u003c/li>\n  <li>a<span class='match'>l\u003c/span>ready\u003c/li>\n  <li>a<span class='match'>l\u003c/span>right\u003c/li>\n  <li>a<span class='match'>l\u003c/span>so\u003c/li>\n  <li>a<span class='match'>l\u003c/span>though\u003c/li>\n  <li>a<span class='match'>l\u003c/span>ways\u003c/li>\n  <li>a<span class='match'>m\u003c/span>erica\u003c/li>\n  <li>a<span class='match'>m\u003c/span>ount\u003c/li>\n  <li>a<span class='match'>n\u003c/span>d\u003c/li>\n  <li>a<span class='match'>n\u003c/span>other\u003c/li>\n  <li>a<span class='match'>n\u003c/span>swer\u003c/li>\n  <li>a<span class='match'>n\u003c/span>y\u003c/li>\n  <li>a<span class='match'>p\u003c/span>art\u003c/li>\n  <li>a<span class='match'>p\u003c/span>parent\u003c/li>\n  <li>a<span class='match'>p\u003c/span>pear\u003c/li>\n  <li>a<span class='match'>p\u003c/span>ply\u003c/li>\n  <li>a<span class='match'>p\u003c/span>point\u003c/li>\n  <li>a<span class='match'>p\u003c/span>proach\u003c/li>\n  <li>a<span class='match'>p\u003c/span>propriate\u003c/li>\n  <li>a<span class='match'>r\u003c/span>ea\u003c/li>\n  <li>a<span class='match'>r\u003c/span>gue\u003c/li>\n  <li>a<span class='match'>r\u003c/span>m\u003c/li>\n  <li>a<span class='match'>r\u003c/span>ound\u003c/li>\n  <li>a<span class='match'>r\u003c/span>range\u003c/li>\n  <li>a<span class='match'>r\u003c/span>t\u003c/li>\n  <li>a<span class='match'>s\u003c/span>\u003c/li>\n  <li>a<span class='match'>s\u003c/span>k\u003c/li>\n  <li>a<span class='match'>s\u003c/span>sociate\u003c/li>\n  <li>a<span class='match'>s\u003c/span>sume\u003c/li>\n  <li>a<span class='match'>t\u003c/span>\u003c/li>\n  <li>a<span class='match'>t\u003c/span>tend\u003c/li>\n  <li>au<span class='match'>t\u003c/span>hority\u003c/li>\n  <li>a<span class='match'>v\u003c/span>ailable\u003c/li>\n  <li>a<span class='match'>w\u003c/span>are\u003c/li>\n  <li>a<span class='match'>w\u003c/span>ay\u003c/li>\n  <li>a<span class='match'>w\u003c/span>ful\u003c/li>\n  <li><span class='match'>b\u003c/span>aby\u003c/li>\n  <li><span class='match'>b\u003c/span>ack\u003c/li>\n  <li><span class='match'>b\u003c/span>ad\u003c/li>\n  <li><span class='match'>b\u003c/span>ag\u003c/li>\n  <li><span class='match'>b\u003c/span>alance\u003c/li>\n  <li><span class='match'>b\u003c/span>all\u003c/li>\n  <li><span class='match'>b\u003c/span>ank\u003c/li>\n  <li><span class='match'>b\u003c/span>ar\u003c/li>\n  <li><span class='match'>b\u003c/span>ase\u003c/li>\n  <li><span class='match'>b\u003c/span>asis\u003c/li>\n  <li><span class='match'>b\u003c/span>e\u003c/li>\n  <li><span class='match'>b\u003c/span>ear\u003c/li>\n  <li><span class='match'>b\u003c/span>eat\u003c/li>\n  <li><span class='match'>b\u003c/span>eauty\u003c/li>\n  <li><span class='match'>b\u003c/span>ecause\u003c/li>\n  <li><span class='match'>b\u003c/span>ecome\u003c/li>\n  <li><span class='match'>b\u003c/span>ed\u003c/li>\n  <li><span class='match'>b\u003c/span>efore\u003c/li>\n  <li><span class='match'>b\u003c/span>egin\u003c/li>\n  <li><span class='match'>b\u003c/span>ehind\u003c/li>\n  <li><span class='match'>b\u003c/span>elieve\u003c/li>\n  <li><span class='match'>b\u003c/span>enefit\u003c/li>\n  <li><span class='match'>b\u003c/span>est\u003c/li>\n  <li><span class='match'>b\u003c/span>et\u003c/li>\n  <li><span class='match'>b\u003c/span>etween\u003c/li>\n  <li><span class='match'>b\u003c/span>ig\u003c/li>\n  <li><span class='match'>b\u003c/span>ill\u003c/li>\n  <li><span class='match'>b\u003c/span>irth\u003c/li>\n  <li><span class='match'>b\u003c/span>it\u003c/li>\n  <li><span class='match'>b\u003c/span>lack\u003c/li>\n  <li><span class='match'>b\u003c/span>loke\u003c/li>\n  <li><span class='match'>b\u003c/span>lood\u003c/li>\n  <li><span class='match'>b\u003c/span>low\u003c/li>\n  <li><span class='match'>b\u003c/span>lue\u003c/li>\n  <li><span class='match'>b\u003c/span>oard\u003c/li>\n  <li><span class='match'>b\u003c/span>oat\u003c/li>\n  <li><span class='match'>b\u003c/span>ody\u003c/li>\n  <li><span class='match'>b\u003c/span>ook\u003c/li>\n  <li><span class='match'>b\u003c/span>oth\u003c/li>\n  <li><span class='match'>b\u003c/span>other\u003c/li>\n  <li><span class='match'>b\u003c/span>ottle\u003c/li>\n  <li><span class='match'>b\u003c/span>ottom\u003c/li>\n  <li><span class='match'>b\u003c/span>ox\u003c/li>\n  <li><span class='match'>b\u003c/span>oy\u003c/li>\n  <li><span class='match'>b\u003c/span>reak\u003c/li>\n  <li><span class='match'>b\u003c/span>rief\u003c/li>\n  <li><span class='match'>b\u003c/span>rilliant\u003c/li>\n  <li><span class='match'>b\u003c/span>ring\u003c/li>\n  <li><span class='match'>b\u003c/span>ritain\u003c/li>\n  <li><span class='match'>b\u003c/span>rother\u003c/li>\n  <li><span class='match'>b\u003c/span>udget\u003c/li>\n  <li><span class='match'>b\u003c/span>uild\u003c/li>\n  <li><span class='match'>b\u003c/span>us\u003c/li>\n  <li><span class='match'>b\u003c/span>usiness\u003c/li>\n  <li><span class='match'>b\u003c/span>usy\u003c/li>\n  <li><span class='match'>b\u003c/span>ut\u003c/li>\n  <li><span class='match'>b\u003c/span>uy\u003c/li>\n  <li><span class='match'>b\u003c/span>y\u003c/li>\n  <li><span class='match'>c\u003c/span>ake\u003c/li>\n  <li><span class='match'>c\u003c/span>all\u003c/li>\n  <li><span class='match'>c\u003c/span>an\u003c/li>\n  <li><span class='match'>c\u003c/span>ar\u003c/li>\n  <li><span class='match'>c\u003c/span>ard\u003c/li>\n  <li><span class='match'>c\u003c/span>are\u003c/li>\n  <li><span class='match'>c\u003c/span>arry\u003c/li>\n  <li><span class='match'>c\u003c/span>ase\u003c/li>\n  <li><span class='match'>c\u003c/span>at\u003c/li>\n  <li><span class='match'>c\u003c/span>atch\u003c/li>\n  <li><span class='match'>c\u003c/span>ause\u003c/li>\n  <li><span class='match'>c\u003c/span>ent\u003c/li>\n  <li><span class='match'>c\u003c/span>entre\u003c/li>\n  <li><span class='match'>c\u003c/span>ertain\u003c/li>\n  <li><span class='match'>c\u003c/span>hair\u003c/li>\n  <li><span class='match'>c\u003c/span>hairman\u003c/li>\n  <li><span class='match'>c\u003c/span>hance\u003c/li>\n  <li><span class='match'>c\u003c/span>hange\u003c/li>\n  <li><span class='match'>c\u003c/span>hap\u003c/li>\n  <li><span class='match'>c\u003c/span>haracter\u003c/li>\n  <li><span class='match'>c\u003c/span>harge\u003c/li>\n  <li><span class='match'>c\u003c/span>heap\u003c/li>\n  <li><span class='match'>c\u003c/span>heck\u003c/li>\n  <li><span class='match'>c\u003c/span>hild\u003c/li>\n  <li><span class='match'>c\u003c/span>hoice\u003c/li>\n  <li><span class='match'>c\u003c/span>hoose\u003c/li>\n  <li><span class='match'>C\u003c/span>hrist\u003c/li>\n  <li><span class='match'>C\u003c/span>hristmas\u003c/li>\n  <li><span class='match'>c\u003c/span>hurch\u003c/li>\n  <li><span class='match'>c\u003c/span>ity\u003c/li>\n  <li><span class='match'>c\u003c/span>laim\u003c/li>\n  <li><span class='match'>c\u003c/span>lass\u003c/li>\n  <li><span class='match'>c\u003c/span>lean\u003c/li>\n  <li><span class='match'>c\u003c/span>lear\u003c/li>\n  <li><span class='match'>c\u003c/span>lient\u003c/li>\n  <li><span class='match'>c\u003c/span>lock\u003c/li>\n  <li><span class='match'>c\u003c/span>lose\u003c/li>\n  <li><span class='match'>c\u003c/span>loses\u003c/li>\n  <li><span class='match'>c\u003c/span>lothe\u003c/li>\n  <li><span class='match'>c\u003c/span>lub\u003c/li>\n  <li><span class='match'>c\u003c/span>offee\u003c/li>\n  <li><span class='match'>c\u003c/span>old\u003c/li>\n  <li><span class='match'>c\u003c/span>olleague\u003c/li>\n  <li><span class='match'>c\u003c/span>ollect\u003c/li>\n  <li><span class='match'>c\u003c/span>ollege\u003c/li>\n  <li><span class='match'>c\u003c/span>olour\u003c/li>\n  <li><span class='match'>c\u003c/span>ome\u003c/li>\n  <li><span class='match'>c\u003c/span>omment\u003c/li>\n  <li><span class='match'>c\u003c/span>ommit\u003c/li>\n  <li><span class='match'>c\u003c/span>ommittee\u003c/li>\n  <li><span class='match'>c\u003c/span>ommon\u003c/li>\n  <li><span class='match'>c\u003c/span>ommunity\u003c/li>\n  <li><span class='match'>c\u003c/span>ompany\u003c/li>\n  <li><span class='match'>c\u003c/span>ompare\u003c/li>\n  <li><span class='match'>c\u003c/span>omplete\u003c/li>\n  <li><span class='match'>c\u003c/span>ompute\u003c/li>\n  <li><span class='match'>c\u003c/span>oncern\u003c/li>\n  <li><span class='match'>c\u003c/span>ondition\u003c/li>\n  <li><span class='match'>c\u003c/span>onfer\u003c/li>\n  <li><span class='match'>c\u003c/span>onsider\u003c/li>\n  <li><span class='match'>c\u003c/span>onsult\u003c/li>\n  <li><span class='match'>c\u003c/span>ontact\u003c/li>\n  <li><span class='match'>c\u003c/span>ontinue\u003c/li>\n  <li><span class='match'>c\u003c/span>ontract\u003c/li>\n  <li><span class='match'>c\u003c/span>ontrol\u003c/li>\n  <li><span class='match'>c\u003c/span>onverse\u003c/li>\n  <li><span class='match'>c\u003c/span>ook\u003c/li>\n  <li><span class='match'>c\u003c/span>opy\u003c/li>\n  <li><span class='match'>c\u003c/span>orner\u003c/li>\n  <li><span class='match'>c\u003c/span>orrect\u003c/li>\n  <li><span class='match'>c\u003c/span>ost\u003c/li>\n  <li><span class='match'>c\u003c/span>ould\u003c/li>\n  <li><span class='match'>c\u003c/span>ouncil\u003c/li>\n  <li><span class='match'>c\u003c/span>ount\u003c/li>\n  <li><span class='match'>c\u003c/span>ountry\u003c/li>\n  <li><span class='match'>c\u003c/span>ounty\u003c/li>\n  <li><span class='match'>c\u003c/span>ouple\u003c/li>\n  <li><span class='match'>c\u003c/span>ourse\u003c/li>\n  <li><span class='match'>c\u003c/span>ourt\u003c/li>\n  <li><span class='match'>c\u003c/span>over\u003c/li>\n  <li><span class='match'>c\u003c/span>reate\u003c/li>\n  <li><span class='match'>c\u003c/span>ross\u003c/li>\n  <li><span class='match'>c\u003c/span>up\u003c/li>\n  <li><span class='match'>c\u003c/span>urrent\u003c/li>\n  <li><span class='match'>c\u003c/span>ut\u003c/li>\n  <li><span class='match'>d\u003c/span>ad\u003c/li>\n  <li><span class='match'>d\u003c/span>anger\u003c/li>\n  <li><span class='match'>d\u003c/span>ate\u003c/li>\n  <li><span class='match'>d\u003c/span>ay\u003c/li>\n  <li><span class='match'>d\u003c/span>ead\u003c/li>\n  <li><span class='match'>d\u003c/span>eal\u003c/li>\n  <li><span class='match'>d\u003c/span>ear\u003c/li>\n  <li><span class='match'>d\u003c/span>ebate\u003c/li>\n  <li><span class='match'>d\u003c/span>ecide\u003c/li>\n  <li><span class='match'>d\u003c/span>ecision\u003c/li>\n  <li><span class='match'>d\u003c/span>eep\u003c/li>\n  <li><span class='match'>d\u003c/span>efinite\u003c/li>\n  <li><span class='match'>d\u003c/span>egree\u003c/li>\n  <li><span class='match'>d\u003c/span>epartment\u003c/li>\n  <li><span class='match'>d\u003c/span>epend\u003c/li>\n  <li><span class='match'>d\u003c/span>escribe\u003c/li>\n  <li><span class='match'>d\u003c/span>esign\u003c/li>\n  <li><span class='match'>d\u003c/span>etail\u003c/li>\n  <li><span class='match'>d\u003c/span>evelop\u003c/li>\n  <li><span class='match'>d\u003c/span>ie\u003c/li>\n  <li><span class='match'>d\u003c/span>ifference\u003c/li>\n  <li><span class='match'>d\u003c/span>ifficult\u003c/li>\n  <li><span class='match'>d\u003c/span>inner\u003c/li>\n  <li><span class='match'>d\u003c/span>irect\u003c/li>\n  <li><span class='match'>d\u003c/span>iscuss\u003c/li>\n  <li><span class='match'>d\u003c/span>istrict\u003c/li>\n  <li><span class='match'>d\u003c/span>ivide\u003c/li>\n  <li><span class='match'>d\u003c/span>o\u003c/li>\n  <li><span class='match'>d\u003c/span>octor\u003c/li>\n  <li><span class='match'>d\u003c/span>ocument\u003c/li>\n  <li><span class='match'>d\u003c/span>og\u003c/li>\n  <li><span class='match'>d\u003c/span>oor\u003c/li>\n  <li><span class='match'>d\u003c/span>ouble\u003c/li>\n  <li><span class='match'>d\u003c/span>oubt\u003c/li>\n  <li><span class='match'>d\u003c/span>own\u003c/li>\n  <li><span class='match'>d\u003c/span>raw\u003c/li>\n  <li><span class='match'>d\u003c/span>ress\u003c/li>\n  <li><span class='match'>d\u003c/span>rink\u003c/li>\n  <li><span class='match'>d\u003c/span>rive\u003c/li>\n  <li><span class='match'>d\u003c/span>rop\u003c/li>\n  <li><span class='match'>d\u003c/span>ry\u003c/li>\n  <li><span class='match'>d\u003c/span>ue\u003c/li>\n  <li><span class='match'>d\u003c/span>uring\u003c/li>\n  <li>ea<span class='match'>c\u003c/span>h\u003c/li>\n  <li>ea<span class='match'>r\u003c/span>ly\u003c/li>\n  <li>ea<span class='match'>s\u003c/span>t\u003c/li>\n  <li>ea<span class='match'>s\u003c/span>y\u003c/li>\n  <li>ea<span class='match'>t\u003c/span>\u003c/li>\n  <li>e<span class='match'>c\u003c/span>onomy\u003c/li>\n  <li>e<span class='match'>d\u003c/span>ucate\u003c/li>\n  <li>e<span class='match'>f\u003c/span>fect\u003c/li>\n  <li>e<span class='match'>g\u003c/span>g\u003c/li>\n  <li>ei<span class='match'>g\u003c/span>ht\u003c/li>\n  <li>ei<span class='match'>t\u003c/span>her\u003c/li>\n  <li>e<span class='match'>l\u003c/span>ect\u003c/li>\n  <li>e<span class='match'>l\u003c/span>ectric\u003c/li>\n  <li>e<span class='match'>l\u003c/span>even\u003c/li>\n  <li>e<span class='match'>l\u003c/span>se\u003c/li>\n  <li>e<span class='match'>m\u003c/span>ploy\u003c/li>\n  <li>e<span class='match'>n\u003c/span>courage\u003c/li>\n  <li>e<span class='match'>n\u003c/span>d\u003c/li>\n  <li>e<span class='match'>n\u003c/span>gine\u003c/li>\n  <li>e<span class='match'>n\u003c/span>glish\u003c/li>\n  <li>e<span class='match'>n\u003c/span>joy\u003c/li>\n  <li>e<span class='match'>n\u003c/span>ough\u003c/li>\n  <li>e<span class='match'>n\u003c/span>ter\u003c/li>\n  <li>e<span class='match'>n\u003c/span>vironment\u003c/li>\n  <li>e<span class='match'>q\u003c/span>ual\u003c/li>\n  <li>e<span class='match'>s\u003c/span>pecial\u003c/li>\n  <li>eu<span class='match'>r\u003c/span>ope\u003c/li>\n  <li>e<span class='match'>v\u003c/span>en\u003c/li>\n  <li>e<span class='match'>v\u003c/span>ening\u003c/li>\n  <li>e<span class='match'>v\u003c/span>er\u003c/li>\n  <li>e<span class='match'>v\u003c/span>ery\u003c/li>\n  <li>e<span class='match'>v\u003c/span>idence\u003c/li>\n  <li>e<span class='match'>x\u003c/span>act\u003c/li>\n  <li>e<span class='match'>x\u003c/span>ample\u003c/li>\n  <li>e<span class='match'>x\u003c/span>cept\u003c/li>\n  <li>e<span class='match'>x\u003c/span>cuse\u003c/li>\n  <li>e<span class='match'>x\u003c/span>ercise\u003c/li>\n  <li>e<span class='match'>x\u003c/span>ist\u003c/li>\n  <li>e<span class='match'>x\u003c/span>pect\u003c/li>\n  <li>e<span class='match'>x\u003c/span>pense\u003c/li>\n  <li>e<span class='match'>x\u003c/span>perience\u003c/li>\n  <li>e<span class='match'>x\u003c/span>plain\u003c/li>\n  <li>e<span class='match'>x\u003c/span>press\u003c/li>\n  <li>e<span class='match'>x\u003c/span>tra\u003c/li>\n  <li>e<span class='match'>y\u003c/span>e\u003c/li>\n  <li><span class='match'>f\u003c/span>ace\u003c/li>\n  <li><span class='match'>f\u003c/span>act\u003c/li>\n  <li><span class='match'>f\u003c/span>air\u003c/li>\n  <li><span class='match'>f\u003c/span>all\u003c/li>\n  <li><span class='match'>f\u003c/span>amily\u003c/li>\n  <li><span class='match'>f\u003c/span>ar\u003c/li>\n  <li><span class='match'>f\u003c/span>arm\u003c/li>\n  <li><span class='match'>f\u003c/span>ast\u003c/li>\n  <li><span class='match'>f\u003c/span>ather\u003c/li>\n  <li><span class='match'>f\u003c/span>avour\u003c/li>\n  <li><span class='match'>f\u003c/span>eed\u003c/li>\n  <li><span class='match'>f\u003c/span>eel\u003c/li>\n  <li><span class='match'>f\u003c/span>ew\u003c/li>\n  <li><span class='match'>f\u003c/span>ield\u003c/li>\n  <li><span class='match'>f\u003c/span>ight\u003c/li>\n  <li><span class='match'>f\u003c/span>igure\u003c/li>\n  <li><span class='match'>f\u003c/span>ile\u003c/li>\n  <li><span class='match'>f\u003c/span>ill\u003c/li>\n  <li><span class='match'>f\u003c/span>ilm\u003c/li>\n  <li><span class='match'>f\u003c/span>inal\u003c/li>\n  <li><span class='match'>f\u003c/span>inance\u003c/li>\n  <li><span class='match'>f\u003c/span>ind\u003c/li>\n  <li><span class='match'>f\u003c/span>ine\u003c/li>\n  <li><span class='match'>f\u003c/span>inish\u003c/li>\n  <li><span class='match'>f\u003c/span>ire\u003c/li>\n  <li><span class='match'>f\u003c/span>irst\u003c/li>\n  <li><span class='match'>f\u003c/span>ish\u003c/li>\n  <li><span class='match'>f\u003c/span>it\u003c/li>\n  <li><span class='match'>f\u003c/span>ive\u003c/li>\n  <li><span class='match'>f\u003c/span>lat\u003c/li>\n  <li><span class='match'>f\u003c/span>loor\u003c/li>\n  <li><span class='match'>f\u003c/span>ly\u003c/li>\n  <li><span class='match'>f\u003c/span>ollow\u003c/li>\n  <li><span class='match'>f\u003c/span>ood\u003c/li>\n  <li><span class='match'>f\u003c/span>oot\u003c/li>\n  <li><span class='match'>f\u003c/span>or\u003c/li>\n  <li><span class='match'>f\u003c/span>orce\u003c/li>\n  <li><span class='match'>f\u003c/span>orget\u003c/li>\n  <li><span class='match'>f\u003c/span>orm\u003c/li>\n  <li><span class='match'>f\u003c/span>ortune\u003c/li>\n  <li><span class='match'>f\u003c/span>orward\u003c/li>\n  <li><span class='match'>f\u003c/span>our\u003c/li>\n  <li><span class='match'>f\u003c/span>rance\u003c/li>\n  <li><span class='match'>f\u003c/span>ree\u003c/li>\n  <li><span class='match'>f\u003c/span>riday\u003c/li>\n  <li><span class='match'>f\u003c/span>riend\u003c/li>\n  <li><span class='match'>f\u003c/span>rom\u003c/li>\n  <li><span class='match'>f\u003c/span>ront\u003c/li>\n  <li><span class='match'>f\u003c/span>ull\u003c/li>\n  <li><span class='match'>f\u003c/span>un\u003c/li>\n  <li><span class='match'>f\u003c/span>unction\u003c/li>\n  <li><span class='match'>f\u003c/span>und\u003c/li>\n  <li><span class='match'>f\u003c/span>urther\u003c/li>\n  <li><span class='match'>f\u003c/span>uture\u003c/li>\n  <li><span class='match'>g\u003c/span>ame\u003c/li>\n  <li><span class='match'>g\u003c/span>arden\u003c/li>\n  <li><span class='match'>g\u003c/span>as\u003c/li>\n  <li><span class='match'>g\u003c/span>eneral\u003c/li>\n  <li><span class='match'>g\u003c/span>ermany\u003c/li>\n  <li><span class='match'>g\u003c/span>et\u003c/li>\n  <li><span class='match'>g\u003c/span>irl\u003c/li>\n  <li><span class='match'>g\u003c/span>ive\u003c/li>\n  <li><span class='match'>g\u003c/span>lass\u003c/li>\n  <li><span class='match'>g\u003c/span>o\u003c/li>\n  <li><span class='match'>g\u003c/span>od\u003c/li>\n  <li><span class='match'>g\u003c/span>ood\u003c/li>\n  <li><span class='match'>g\u003c/span>oodbye\u003c/li>\n  <li><span class='match'>g\u003c/span>overn\u003c/li>\n  <li><span class='match'>g\u003c/span>rand\u003c/li>\n  <li><span class='match'>g\u003c/span>rant\u003c/li>\n  <li><span class='match'>g\u003c/span>reat\u003c/li>\n  <li><span class='match'>g\u003c/span>reen\u003c/li>\n  <li><span class='match'>g\u003c/span>round\u003c/li>\n  <li><span class='match'>g\u003c/span>roup\u003c/li>\n  <li><span class='match'>g\u003c/span>row\u003c/li>\n  <li><span class='match'>g\u003c/span>uess\u003c/li>\n  <li><span class='match'>g\u003c/span>uy\u003c/li>\n  <li><span class='match'>h\u003c/span>air\u003c/li>\n  <li><span class='match'>h\u003c/span>alf\u003c/li>\n  <li><span class='match'>h\u003c/span>all\u003c/li>\n  <li><span class='match'>h\u003c/span>and\u003c/li>\n  <li><span class='match'>h\u003c/span>ang\u003c/li>\n  <li><span class='match'>h\u003c/span>appen\u003c/li>\n  <li><span class='match'>h\u003c/span>appy\u003c/li>\n  <li><span class='match'>h\u003c/span>ard\u003c/li>\n  <li><span class='match'>h\u003c/span>ate\u003c/li>\n  <li><span class='match'>h\u003c/span>ave\u003c/li>\n  <li><span class='match'>h\u003c/span>e\u003c/li>\n  <li><span class='match'>h\u003c/span>ead\u003c/li>\n  <li><span class='match'>h\u003c/span>ealth\u003c/li>\n  <li><span class='match'>h\u003c/span>ear\u003c/li>\n  <li><span class='match'>h\u003c/span>eart\u003c/li>\n  <li><span class='match'>h\u003c/span>eat\u003c/li>\n  <li><span class='match'>h\u003c/span>eavy\u003c/li>\n  <li><span class='match'>h\u003c/span>ell\u003c/li>\n  <li><span class='match'>h\u003c/span>elp\u003c/li>\n  <li><span class='match'>h\u003c/span>ere\u003c/li>\n  <li><span class='match'>h\u003c/span>igh\u003c/li>\n  <li><span class='match'>h\u003c/span>istory\u003c/li>\n  <li><span class='match'>h\u003c/span>it\u003c/li>\n  <li><span class='match'>h\u003c/span>old\u003c/li>\n  <li><span class='match'>h\u003c/span>oliday\u003c/li>\n  <li><span class='match'>h\u003c/span>ome\u003c/li>\n  <li><span class='match'>h\u003c/span>onest\u003c/li>\n  <li><span class='match'>h\u003c/span>ope\u003c/li>\n  <li><span class='match'>h\u003c/span>orse\u003c/li>\n  <li><span class='match'>h\u003c/span>ospital\u003c/li>\n  <li><span class='match'>h\u003c/span>ot\u003c/li>\n  <li><span class='match'>h\u003c/span>our\u003c/li>\n  <li><span class='match'>h\u003c/span>ouse\u003c/li>\n  <li><span class='match'>h\u003c/span>ow\u003c/li>\n  <li><span class='match'>h\u003c/span>owever\u003c/li>\n  <li><span class='match'>h\u003c/span>ullo\u003c/li>\n  <li><span class='match'>h\u003c/span>undred\u003c/li>\n  <li><span class='match'>h\u003c/span>usband\u003c/li>\n  <li>i<span class='match'>d\u003c/span>ea\u003c/li>\n  <li>i<span class='match'>d\u003c/span>entify\u003c/li>\n  <li>i<span class='match'>f\u003c/span>\u003c/li>\n  <li>i<span class='match'>m\u003c/span>agine\u003c/li>\n  <li>i<span class='match'>m\u003c/span>portant\u003c/li>\n  <li>i<span class='match'>m\u003c/span>prove\u003c/li>\n  <li>i<span class='match'>n\u003c/span>\u003c/li>\n  <li>i<span class='match'>n\u003c/span>clude\u003c/li>\n  <li>i<span class='match'>n\u003c/span>come\u003c/li>\n  <li>i<span class='match'>n\u003c/span>crease\u003c/li>\n  <li>i<span class='match'>n\u003c/span>deed\u003c/li>\n  <li>i<span class='match'>n\u003c/span>dividual\u003c/li>\n  <li>i<span class='match'>n\u003c/span>dustry\u003c/li>\n  <li>i<span class='match'>n\u003c/span>form\u003c/li>\n  <li>i<span class='match'>n\u003c/span>side\u003c/li>\n  <li>i<span class='match'>n\u003c/span>stead\u003c/li>\n  <li>i<span class='match'>n\u003c/span>sure\u003c/li>\n  <li>i<span class='match'>n\u003c/span>terest\u003c/li>\n  <li>i<span class='match'>n\u003c/span>to\u003c/li>\n  <li>i<span class='match'>n\u003c/span>troduce\u003c/li>\n  <li>i<span class='match'>n\u003c/span>vest\u003c/li>\n  <li>i<span class='match'>n\u003c/span>volve\u003c/li>\n  <li>i<span class='match'>s\u003c/span>sue\u003c/li>\n  <li>i<span class='match'>t\u003c/span>\u003c/li>\n  <li>i<span class='match'>t\u003c/span>em\u003c/li>\n  <li><span class='match'>j\u003c/span>esus\u003c/li>\n  <li><span class='match'>j\u003c/span>ob\u003c/li>\n  <li><span class='match'>j\u003c/span>oin\u003c/li>\n  <li><span class='match'>j\u003c/span>udge\u003c/li>\n  <li><span class='match'>j\u003c/span>ump\u003c/li>\n  <li><span class='match'>j\u003c/span>ust\u003c/li>\n  <li><span class='match'>k\u003c/span>eep\u003c/li>\n  <li><span class='match'>k\u003c/span>ey\u003c/li>\n  <li><span class='match'>k\u003c/span>id\u003c/li>\n  <li><span class='match'>k\u003c/span>ill\u003c/li>\n  <li><span class='match'>k\u003c/span>ind\u003c/li>\n  <li><span class='match'>k\u003c/span>ing\u003c/li>\n  <li><span class='match'>k\u003c/span>itchen\u003c/li>\n  <li><span class='match'>k\u003c/span>nock\u003c/li>\n  <li><span class='match'>k\u003c/span>now\u003c/li>\n  <li><span class='match'>l\u003c/span>abour\u003c/li>\n  <li><span class='match'>l\u003c/span>ad\u003c/li>\n  <li><span class='match'>l\u003c/span>ady\u003c/li>\n  <li><span class='match'>l\u003c/span>and\u003c/li>\n  <li><span class='match'>l\u003c/span>anguage\u003c/li>\n  <li><span class='match'>l\u003c/span>arge\u003c/li>\n  <li><span class='match'>l\u003c/span>ast\u003c/li>\n  <li><span class='match'>l\u003c/span>ate\u003c/li>\n  <li><span class='match'>l\u003c/span>augh\u003c/li>\n  <li><span class='match'>l\u003c/span>aw\u003c/li>\n  <li><span class='match'>l\u003c/span>ay\u003c/li>\n  <li><span class='match'>l\u003c/span>ead\u003c/li>\n  <li><span class='match'>l\u003c/span>earn\u003c/li>\n  <li><span class='match'>l\u003c/span>eave\u003c/li>\n  <li><span class='match'>l\u003c/span>eft\u003c/li>\n  <li><span class='match'>l\u003c/span>eg\u003c/li>\n  <li><span class='match'>l\u003c/span>ess\u003c/li>\n  <li><span class='match'>l\u003c/span>et\u003c/li>\n  <li><span class='match'>l\u003c/span>etter\u003c/li>\n  <li><span class='match'>l\u003c/span>evel\u003c/li>\n  <li><span class='match'>l\u003c/span>ie\u003c/li>\n  <li><span class='match'>l\u003c/span>ife\u003c/li>\n  <li><span class='match'>l\u003c/span>ight\u003c/li>\n  <li><span class='match'>l\u003c/span>ike\u003c/li>\n  <li><span class='match'>l\u003c/span>ikely\u003c/li>\n  <li><span class='match'>l\u003c/span>imit\u003c/li>\n  <li><span class='match'>l\u003c/span>ine\u003c/li>\n  <li><span class='match'>l\u003c/span>ink\u003c/li>\n  <li><span class='match'>l\u003c/span>ist\u003c/li>\n  <li><span class='match'>l\u003c/span>isten\u003c/li>\n  <li><span class='match'>l\u003c/span>ittle\u003c/li>\n  <li><span class='match'>l\u003c/span>ive\u003c/li>\n  <li><span class='match'>l\u003c/span>oad\u003c/li>\n  <li><span class='match'>l\u003c/span>ocal\u003c/li>\n  <li><span class='match'>l\u003c/span>ock\u003c/li>\n  <li><span class='match'>l\u003c/span>ondon\u003c/li>\n  <li><span class='match'>l\u003c/span>ong\u003c/li>\n  <li><span class='match'>l\u003c/span>ook\u003c/li>\n  <li><span class='match'>l\u003c/span>ord\u003c/li>\n  <li><span class='match'>l\u003c/span>ose\u003c/li>\n  <li><span class='match'>l\u003c/span>ot\u003c/li>\n  <li><span class='match'>l\u003c/span>ove\u003c/li>\n  <li><span class='match'>l\u003c/span>ow\u003c/li>\n  <li><span class='match'>l\u003c/span>uck\u003c/li>\n  <li><span class='match'>l\u003c/span>unch\u003c/li>\n  <li><span class='match'>m\u003c/span>achine\u003c/li>\n  <li><span class='match'>m\u003c/span>ain\u003c/li>\n  <li><span class='match'>m\u003c/span>ajor\u003c/li>\n  <li><span class='match'>m\u003c/span>ake\u003c/li>\n  <li><span class='match'>m\u003c/span>an\u003c/li>\n  <li><span class='match'>m\u003c/span>anage\u003c/li>\n  <li><span class='match'>m\u003c/span>any\u003c/li>\n  <li><span class='match'>m\u003c/span>ark\u003c/li>\n  <li><span class='match'>m\u003c/span>arket\u003c/li>\n  <li><span class='match'>m\u003c/span>arry\u003c/li>\n  <li><span class='match'>m\u003c/span>atch\u003c/li>\n  <li><span class='match'>m\u003c/span>atter\u003c/li>\n  <li><span class='match'>m\u003c/span>ay\u003c/li>\n  <li><span class='match'>m\u003c/span>aybe\u003c/li>\n  <li><span class='match'>m\u003c/span>ean\u003c/li>\n  <li><span class='match'>m\u003c/span>eaning\u003c/li>\n  <li><span class='match'>m\u003c/span>easure\u003c/li>\n  <li><span class='match'>m\u003c/span>eet\u003c/li>\n  <li><span class='match'>m\u003c/span>ember\u003c/li>\n  <li><span class='match'>m\u003c/span>ention\u003c/li>\n  <li><span class='match'>m\u003c/span>iddle\u003c/li>\n  <li><span class='match'>m\u003c/span>ight\u003c/li>\n  <li><span class='match'>m\u003c/span>ile\u003c/li>\n  <li><span class='match'>m\u003c/span>ilk\u003c/li>\n  <li><span class='match'>m\u003c/span>illion\u003c/li>\n  <li><span class='match'>m\u003c/span>ind\u003c/li>\n  <li><span class='match'>m\u003c/span>inister\u003c/li>\n  <li><span class='match'>m\u003c/span>inus\u003c/li>\n  <li><span class='match'>m\u003c/span>inute\u003c/li>\n  <li><span class='match'>m\u003c/span>iss\u003c/li>\n  <li><span class='match'>m\u003c/span>ister\u003c/li>\n  <li><span class='match'>m\u003c/span>oment\u003c/li>\n  <li><span class='match'>m\u003c/span>onday\u003c/li>\n  <li><span class='match'>m\u003c/span>oney\u003c/li>\n  <li><span class='match'>m\u003c/span>onth\u003c/li>\n  <li><span class='match'>m\u003c/span>ore\u003c/li>\n  <li><span class='match'>m\u003c/span>orning\u003c/li>\n  <li><span class='match'>m\u003c/span>ost\u003c/li>\n  <li><span class='match'>m\u003c/span>other\u003c/li>\n  <li><span class='match'>m\u003c/span>otion\u003c/li>\n  <li><span class='match'>m\u003c/span>ove\u003c/li>\n  <li><span class='match'>m\u003c/span>rs\u003c/li>\n  <li><span class='match'>m\u003c/span>uch\u003c/li>\n  <li><span class='match'>m\u003c/span>usic\u003c/li>\n  <li><span class='match'>m\u003c/span>ust\u003c/li>\n  <li><span class='match'>n\u003c/span>ame\u003c/li>\n  <li><span class='match'>n\u003c/span>ation\u003c/li>\n  <li><span class='match'>n\u003c/span>ature\u003c/li>\n  <li><span class='match'>n\u003c/span>ear\u003c/li>\n  <li><span class='match'>n\u003c/span>ecessary\u003c/li>\n  <li><span class='match'>n\u003c/span>eed\u003c/li>\n  <li><span class='match'>n\u003c/span>ever\u003c/li>\n  <li><span class='match'>n\u003c/span>ew\u003c/li>\n  <li><span class='match'>n\u003c/span>ews\u003c/li>\n  <li><span class='match'>n\u003c/span>ext\u003c/li>\n  <li><span class='match'>n\u003c/span>ice\u003c/li>\n  <li><span class='match'>n\u003c/span>ight\u003c/li>\n  <li><span class='match'>n\u003c/span>ine\u003c/li>\n  <li><span class='match'>n\u003c/span>o\u003c/li>\n  <li><span class='match'>n\u003c/span>on\u003c/li>\n  <li><span class='match'>n\u003c/span>one\u003c/li>\n  <li><span class='match'>n\u003c/span>ormal\u003c/li>\n  <li><span class='match'>n\u003c/span>orth\u003c/li>\n  <li><span class='match'>n\u003c/span>ot\u003c/li>\n  <li><span class='match'>n\u003c/span>ote\u003c/li>\n  <li><span class='match'>n\u003c/span>otice\u003c/li>\n  <li><span class='match'>n\u003c/span>ow\u003c/li>\n  <li><span class='match'>n\u003c/span>umber\u003c/li>\n  <li>o<span class='match'>b\u003c/span>vious\u003c/li>\n  <li>o<span class='match'>c\u003c/span>casion\u003c/li>\n  <li>o<span class='match'>d\u003c/span>d\u003c/li>\n  <li>o<span class='match'>f\u003c/span>\u003c/li>\n  <li>o<span class='match'>f\u003c/span>f\u003c/li>\n  <li>o<span class='match'>f\u003c/span>fer\u003c/li>\n  <li>o<span class='match'>f\u003c/span>fice\u003c/li>\n  <li>o<span class='match'>f\u003c/span>ten\u003c/li>\n  <li>o<span class='match'>k\u003c/span>ay\u003c/li>\n  <li>o<span class='match'>l\u003c/span>d\u003c/li>\n  <li>o<span class='match'>n\u003c/span>\u003c/li>\n  <li>o<span class='match'>n\u003c/span>ce\u003c/li>\n  <li>o<span class='match'>n\u003c/span>e\u003c/li>\n  <li>o<span class='match'>n\u003c/span>ly\u003c/li>\n  <li>o<span class='match'>p\u003c/span>en\u003c/li>\n  <li>o<span class='match'>p\u003c/span>erate\u003c/li>\n  <li>o<span class='match'>p\u003c/span>portunity\u003c/li>\n  <li>o<span class='match'>p\u003c/span>pose\u003c/li>\n  <li>o<span class='match'>r\u003c/span>\u003c/li>\n  <li>o<span class='match'>r\u003c/span>der\u003c/li>\n  <li>o<span class='match'>r\u003c/span>ganize\u003c/li>\n  <li>o<span class='match'>r\u003c/span>iginal\u003c/li>\n  <li>o<span class='match'>t\u003c/span>her\u003c/li>\n  <li>o<span class='match'>t\u003c/span>herwise\u003c/li>\n  <li>ou<span class='match'>g\u003c/span>ht\u003c/li>\n  <li>ou<span class='match'>t\u003c/span>\u003c/li>\n  <li>o<span class='match'>v\u003c/span>er\u003c/li>\n  <li>o<span class='match'>w\u003c/span>n\u003c/li>\n  <li><span class='match'>p\u003c/span>ack\u003c/li>\n  <li><span class='match'>p\u003c/span>age\u003c/li>\n  <li><span class='match'>p\u003c/span>aint\u003c/li>\n  <li><span class='match'>p\u003c/span>air\u003c/li>\n  <li><span class='match'>p\u003c/span>aper\u003c/li>\n  <li><span class='match'>p\u003c/span>aragraph\u003c/li>\n  <li><span class='match'>p\u003c/span>ardon\u003c/li>\n  <li><span class='match'>p\u003c/span>arent\u003c/li>\n  <li><span class='match'>p\u003c/span>ark\u003c/li>\n  <li><span class='match'>p\u003c/span>art\u003c/li>\n  <li><span class='match'>p\u003c/span>articular\u003c/li>\n  <li><span class='match'>p\u003c/span>arty\u003c/li>\n  <li><span class='match'>p\u003c/span>ass\u003c/li>\n  <li><span class='match'>p\u003c/span>ast\u003c/li>\n  <li><span class='match'>p\u003c/span>ay\u003c/li>\n  <li><span class='match'>p\u003c/span>ence\u003c/li>\n  <li><span class='match'>p\u003c/span>ension\u003c/li>\n  <li><span class='match'>p\u003c/span>eople\u003c/li>\n  <li><span class='match'>p\u003c/span>er\u003c/li>\n  <li><span class='match'>p\u003c/span>ercent\u003c/li>\n  <li><span class='match'>p\u003c/span>erfect\u003c/li>\n  <li><span class='match'>p\u003c/span>erhaps\u003c/li>\n  <li><span class='match'>p\u003c/span>eriod\u003c/li>\n  <li><span class='match'>p\u003c/span>erson\u003c/li>\n  <li><span class='match'>p\u003c/span>hotograph\u003c/li>\n  <li><span class='match'>p\u003c/span>ick\u003c/li>\n  <li><span class='match'>p\u003c/span>icture\u003c/li>\n  <li><span class='match'>p\u003c/span>iece\u003c/li>\n  <li><span class='match'>p\u003c/span>lace\u003c/li>\n  <li><span class='match'>p\u003c/span>lan\u003c/li>\n  <li><span class='match'>p\u003c/span>lay\u003c/li>\n  <li><span class='match'>p\u003c/span>lease\u003c/li>\n  <li><span class='match'>p\u003c/span>lus\u003c/li>\n  <li><span class='match'>p\u003c/span>oint\u003c/li>\n  <li><span class='match'>p\u003c/span>olice\u003c/li>\n  <li><span class='match'>p\u003c/span>olicy\u003c/li>\n  <li><span class='match'>p\u003c/span>olitic\u003c/li>\n  <li><span class='match'>p\u003c/span>oor\u003c/li>\n  <li><span class='match'>p\u003c/span>osition\u003c/li>\n  <li><span class='match'>p\u003c/span>ositive\u003c/li>\n  <li><span class='match'>p\u003c/span>ossible\u003c/li>\n  <li><span class='match'>p\u003c/span>ost\u003c/li>\n  <li><span class='match'>p\u003c/span>ound\u003c/li>\n  <li><span class='match'>p\u003c/span>ower\u003c/li>\n  <li><span class='match'>p\u003c/span>ractise\u003c/li>\n  <li><span class='match'>p\u003c/span>repare\u003c/li>\n  <li><span class='match'>p\u003c/span>resent\u003c/li>\n  <li><span class='match'>p\u003c/span>ress\u003c/li>\n  <li><span class='match'>p\u003c/span>ressure\u003c/li>\n  <li><span class='match'>p\u003c/span>resume\u003c/li>\n  <li><span class='match'>p\u003c/span>retty\u003c/li>\n  <li><span class='match'>p\u003c/span>revious\u003c/li>\n  <li><span class='match'>p\u003c/span>rice\u003c/li>\n  <li><span class='match'>p\u003c/span>rint\u003c/li>\n  <li><span class='match'>p\u003c/span>rivate\u003c/li>\n  <li><span class='match'>p\u003c/span>robable\u003c/li>\n  <li><span class='match'>p\u003c/span>roblem\u003c/li>\n  <li><span class='match'>p\u003c/span>roceed\u003c/li>\n  <li><span class='match'>p\u003c/span>rocess\u003c/li>\n  <li><span class='match'>p\u003c/span>roduce\u003c/li>\n  <li><span class='match'>p\u003c/span>roduct\u003c/li>\n  <li><span class='match'>p\u003c/span>rogramme\u003c/li>\n  <li><span class='match'>p\u003c/span>roject\u003c/li>\n  <li><span class='match'>p\u003c/span>roper\u003c/li>\n  <li><span class='match'>p\u003c/span>ropose\u003c/li>\n  <li><span class='match'>p\u003c/span>rotect\u003c/li>\n  <li><span class='match'>p\u003c/span>rovide\u003c/li>\n  <li><span class='match'>p\u003c/span>ublic\u003c/li>\n  <li><span class='match'>p\u003c/span>ull\u003c/li>\n  <li><span class='match'>p\u003c/span>urpose\u003c/li>\n  <li><span class='match'>p\u003c/span>ush\u003c/li>\n  <li><span class='match'>p\u003c/span>ut\u003c/li>\n  <li><span class='match'>q\u003c/span>uality\u003c/li>\n  <li><span class='match'>q\u003c/span>uarter\u003c/li>\n  <li><span class='match'>q\u003c/span>uestion\u003c/li>\n  <li><span class='match'>q\u003c/span>uick\u003c/li>\n  <li><span class='match'>q\u003c/span>uid\u003c/li>\n  <li><span class='match'>q\u003c/span>uiet\u003c/li>\n  <li><span class='match'>q\u003c/span>uite\u003c/li>\n  <li><span class='match'>r\u003c/span>adio\u003c/li>\n  <li><span class='match'>r\u003c/span>ail\u003c/li>\n  <li><span class='match'>r\u003c/span>aise\u003c/li>\n  <li><span class='match'>r\u003c/span>ange\u003c/li>\n  <li><span class='match'>r\u003c/span>ate\u003c/li>\n  <li><span class='match'>r\u003c/span>ather\u003c/li>\n  <li><span class='match'>r\u003c/span>ead\u003c/li>\n  <li><span class='match'>r\u003c/span>eady\u003c/li>\n  <li><span class='match'>r\u003c/span>eal\u003c/li>\n  <li><span class='match'>r\u003c/span>ealise\u003c/li>\n  <li><span class='match'>r\u003c/span>eally\u003c/li>\n  <li><span class='match'>r\u003c/span>eason\u003c/li>\n  <li><span class='match'>r\u003c/span>eceive\u003c/li>\n  <li><span class='match'>r\u003c/span>ecent\u003c/li>\n  <li><span class='match'>r\u003c/span>eckon\u003c/li>\n  <li><span class='match'>r\u003c/span>ecognize\u003c/li>\n  <li><span class='match'>r\u003c/span>ecommend\u003c/li>\n  <li><span class='match'>r\u003c/span>ecord\u003c/li>\n  <li><span class='match'>r\u003c/span>ed\u003c/li>\n  <li><span class='match'>r\u003c/span>educe\u003c/li>\n  <li><span class='match'>r\u003c/span>efer\u003c/li>\n  <li><span class='match'>r\u003c/span>egard\u003c/li>\n  <li><span class='match'>r\u003c/span>egion\u003c/li>\n  <li><span class='match'>r\u003c/span>elation\u003c/li>\n  <li><span class='match'>r\u003c/span>emember\u003c/li>\n  <li><span class='match'>r\u003c/span>eport\u003c/li>\n  <li><span class='match'>r\u003c/span>epresent\u003c/li>\n  <li><span class='match'>r\u003c/span>equire\u003c/li>\n  <li><span class='match'>r\u003c/span>esearch\u003c/li>\n  <li><span class='match'>r\u003c/span>esource\u003c/li>\n  <li><span class='match'>r\u003c/span>espect\u003c/li>\n  <li><span class='match'>r\u003c/span>esponsible\u003c/li>\n  <li><span class='match'>r\u003c/span>est\u003c/li>\n  <li><span class='match'>r\u003c/span>esult\u003c/li>\n  <li><span class='match'>r\u003c/span>eturn\u003c/li>\n  <li><span class='match'>r\u003c/span>id\u003c/li>\n  <li><span class='match'>r\u003c/span>ight\u003c/li>\n  <li><span class='match'>r\u003c/span>ing\u003c/li>\n  <li><span class='match'>r\u003c/span>ise\u003c/li>\n  <li><span class='match'>r\u003c/span>oad\u003c/li>\n  <li><span class='match'>r\u003c/span>ole\u003c/li>\n  <li><span class='match'>r\u003c/span>oll\u003c/li>\n  <li><span class='match'>r\u003c/span>oom\u003c/li>\n  <li><span class='match'>r\u003c/span>ound\u003c/li>\n  <li><span class='match'>r\u003c/span>ule\u003c/li>\n  <li><span class='match'>r\u003c/span>un\u003c/li>\n  <li><span class='match'>s\u003c/span>afe\u003c/li>\n  <li><span class='match'>s\u003c/span>ale\u003c/li>\n  <li><span class='match'>s\u003c/span>ame\u003c/li>\n  <li><span class='match'>s\u003c/span>aturday\u003c/li>\n  <li><span class='match'>s\u003c/span>ave\u003c/li>\n  <li><span class='match'>s\u003c/span>ay\u003c/li>\n  <li><span class='match'>s\u003c/span>cheme\u003c/li>\n  <li><span class='match'>s\u003c/span>chool\u003c/li>\n  <li><span class='match'>s\u003c/span>cience\u003c/li>\n  <li><span class='match'>s\u003c/span>core\u003c/li>\n  <li><span class='match'>s\u003c/span>cotland\u003c/li>\n  <li><span class='match'>s\u003c/span>eat\u003c/li>\n  <li><span class='match'>s\u003c/span>econd\u003c/li>\n  <li><span class='match'>s\u003c/span>ecretary\u003c/li>\n  <li><span class='match'>s\u003c/span>ection\u003c/li>\n  <li><span class='match'>s\u003c/span>ecure\u003c/li>\n  <li><span class='match'>s\u003c/span>ee\u003c/li>\n  <li><span class='match'>s\u003c/span>eem\u003c/li>\n  <li><span class='match'>s\u003c/span>elf\u003c/li>\n  <li><span class='match'>s\u003c/span>ell\u003c/li>\n  <li><span class='match'>s\u003c/span>end\u003c/li>\n  <li><span class='match'>s\u003c/span>ense\u003c/li>\n  <li><span class='match'>s\u003c/span>eparate\u003c/li>\n  <li><span class='match'>s\u003c/span>erious\u003c/li>\n  <li><span class='match'>s\u003c/span>erve\u003c/li>\n  <li><span class='match'>s\u003c/span>ervice\u003c/li>\n  <li><span class='match'>s\u003c/span>et\u003c/li>\n  <li><span class='match'>s\u003c/span>ettle\u003c/li>\n  <li><span class='match'>s\u003c/span>even\u003c/li>\n  <li><span class='match'>s\u003c/span>ex\u003c/li>\n  <li><span class='match'>s\u003c/span>hall\u003c/li>\n  <li><span class='match'>s\u003c/span>hare\u003c/li>\n  <li><span class='match'>s\u003c/span>he\u003c/li>\n  <li><span class='match'>s\u003c/span>heet\u003c/li>\n  <li><span class='match'>s\u003c/span>hoe\u003c/li>\n  <li><span class='match'>s\u003c/span>hoot\u003c/li>\n  <li><span class='match'>s\u003c/span>hop\u003c/li>\n  <li><span class='match'>s\u003c/span>hort\u003c/li>\n  <li><span class='match'>s\u003c/span>hould\u003c/li>\n  <li><span class='match'>s\u003c/span>how\u003c/li>\n  <li><span class='match'>s\u003c/span>hut\u003c/li>\n  <li><span class='match'>s\u003c/span>ick\u003c/li>\n  <li><span class='match'>s\u003c/span>ide\u003c/li>\n  <li><span class='match'>s\u003c/span>ign\u003c/li>\n  <li><span class='match'>s\u003c/span>imilar\u003c/li>\n  <li><span class='match'>s\u003c/span>imple\u003c/li>\n  <li><span class='match'>s\u003c/span>ince\u003c/li>\n  <li><span class='match'>s\u003c/span>ing\u003c/li>\n  <li><span class='match'>s\u003c/span>ingle\u003c/li>\n  <li><span class='match'>s\u003c/span>ir\u003c/li>\n  <li><span class='match'>s\u003c/span>ister\u003c/li>\n  <li><span class='match'>s\u003c/span>it\u003c/li>\n  <li><span class='match'>s\u003c/span>ite\u003c/li>\n  <li><span class='match'>s\u003c/span>ituate\u003c/li>\n  <li><span class='match'>s\u003c/span>ix\u003c/li>\n  <li><span class='match'>s\u003c/span>ize\u003c/li>\n  <li><span class='match'>s\u003c/span>leep\u003c/li>\n  <li><span class='match'>s\u003c/span>light\u003c/li>\n  <li><span class='match'>s\u003c/span>low\u003c/li>\n  <li><span class='match'>s\u003c/span>mall\u003c/li>\n  <li><span class='match'>s\u003c/span>moke\u003c/li>\n  <li><span class='match'>s\u003c/span>o\u003c/li>\n  <li><span class='match'>s\u003c/span>ocial\u003c/li>\n  <li><span class='match'>s\u003c/span>ociety\u003c/li>\n  <li><span class='match'>s\u003c/span>ome\u003c/li>\n  <li><span class='match'>s\u003c/span>on\u003c/li>\n  <li><span class='match'>s\u003c/span>oon\u003c/li>\n  <li><span class='match'>s\u003c/span>orry\u003c/li>\n  <li><span class='match'>s\u003c/span>ort\u003c/li>\n  <li><span class='match'>s\u003c/span>ound\u003c/li>\n  <li><span class='match'>s\u003c/span>outh\u003c/li>\n  <li><span class='match'>s\u003c/span>pace\u003c/li>\n  <li><span class='match'>s\u003c/span>peak\u003c/li>\n  <li><span class='match'>s\u003c/span>pecial\u003c/li>\n  <li><span class='match'>s\u003c/span>pecific\u003c/li>\n  <li><span class='match'>s\u003c/span>peed\u003c/li>\n  <li><span class='match'>s\u003c/span>pell\u003c/li>\n  <li><span class='match'>s\u003c/span>pend\u003c/li>\n  <li><span class='match'>s\u003c/span>quare\u003c/li>\n  <li><span class='match'>s\u003c/span>taff\u003c/li>\n  <li><span class='match'>s\u003c/span>tage\u003c/li>\n  <li><span class='match'>s\u003c/span>tairs\u003c/li>\n  <li><span class='match'>s\u003c/span>tand\u003c/li>\n  <li><span class='match'>s\u003c/span>tandard\u003c/li>\n  <li><span class='match'>s\u003c/span>tart\u003c/li>\n  <li><span class='match'>s\u003c/span>tate\u003c/li>\n  <li><span class='match'>s\u003c/span>tation\u003c/li>\n  <li><span class='match'>s\u003c/span>tay\u003c/li>\n  <li><span class='match'>s\u003c/span>tep\u003c/li>\n  <li><span class='match'>s\u003c/span>tick\u003c/li>\n  <li><span class='match'>s\u003c/span>till\u003c/li>\n  <li><span class='match'>s\u003c/span>top\u003c/li>\n  <li><span class='match'>s\u003c/span>tory\u003c/li>\n  <li><span class='match'>s\u003c/span>traight\u003c/li>\n  <li><span class='match'>s\u003c/span>trategy\u003c/li>\n  <li><span class='match'>s\u003c/span>treet\u003c/li>\n  <li><span class='match'>s\u003c/span>trike\u003c/li>\n  <li><span class='match'>s\u003c/span>trong\u003c/li>\n  <li><span class='match'>s\u003c/span>tructure\u003c/li>\n  <li><span class='match'>s\u003c/span>tudent\u003c/li>\n  <li><span class='match'>s\u003c/span>tudy\u003c/li>\n  <li><span class='match'>s\u003c/span>tuff\u003c/li>\n  <li><span class='match'>s\u003c/span>tupid\u003c/li>\n  <li><span class='match'>s\u003c/span>ubject\u003c/li>\n  <li><span class='match'>s\u003c/span>ucceed\u003c/li>\n  <li><span class='match'>s\u003c/span>uch\u003c/li>\n  <li><span class='match'>s\u003c/span>udden\u003c/li>\n  <li><span class='match'>s\u003c/span>uggest\u003c/li>\n  <li><span class='match'>s\u003c/span>uit\u003c/li>\n  <li><span class='match'>s\u003c/span>ummer\u003c/li>\n  <li><span class='match'>s\u003c/span>un\u003c/li>\n  <li><span class='match'>s\u003c/span>unday\u003c/li>\n  <li><span class='match'>s\u003c/span>upply\u003c/li>\n  <li><span class='match'>s\u003c/span>upport\u003c/li>\n  <li><span class='match'>s\u003c/span>uppose\u003c/li>\n  <li><span class='match'>s\u003c/span>ure\u003c/li>\n  <li><span class='match'>s\u003c/span>urprise\u003c/li>\n  <li><span class='match'>s\u003c/span>witch\u003c/li>\n  <li><span class='match'>s\u003c/span>ystem\u003c/li>\n  <li><span class='match'>t\u003c/span>able\u003c/li>\n  <li><span class='match'>t\u003c/span>ake\u003c/li>\n  <li><span class='match'>t\u003c/span>alk\u003c/li>\n  <li><span class='match'>t\u003c/span>ape\u003c/li>\n  <li><span class='match'>t\u003c/span>ax\u003c/li>\n  <li><span class='match'>t\u003c/span>ea\u003c/li>\n  <li><span class='match'>t\u003c/span>each\u003c/li>\n  <li><span class='match'>t\u003c/span>eam\u003c/li>\n  <li><span class='match'>t\u003c/span>elephone\u003c/li>\n  <li><span class='match'>t\u003c/span>elevision\u003c/li>\n  <li><span class='match'>t\u003c/span>ell\u003c/li>\n  <li><span class='match'>t\u003c/span>en\u003c/li>\n  <li><span class='match'>t\u003c/span>end\u003c/li>\n  <li><span class='match'>t\u003c/span>erm\u003c/li>\n  <li><span class='match'>t\u003c/span>errible\u003c/li>\n  <li><span class='match'>t\u003c/span>est\u003c/li>\n  <li><span class='match'>t\u003c/span>han\u003c/li>\n  <li><span class='match'>t\u003c/span>hank\u003c/li>\n  <li><span class='match'>t\u003c/span>he\u003c/li>\n  <li><span class='match'>t\u003c/span>hen\u003c/li>\n  <li><span class='match'>t\u003c/span>here\u003c/li>\n  <li><span class='match'>t\u003c/span>herefore\u003c/li>\n  <li><span class='match'>t\u003c/span>hey\u003c/li>\n  <li><span class='match'>t\u003c/span>hing\u003c/li>\n  <li><span class='match'>t\u003c/span>hink\u003c/li>\n  <li><span class='match'>t\u003c/span>hirteen\u003c/li>\n  <li><span class='match'>t\u003c/span>hirty\u003c/li>\n  <li><span class='match'>t\u003c/span>his\u003c/li>\n  <li><span class='match'>t\u003c/span>hou\u003c/li>\n  <li><span class='match'>t\u003c/span>hough\u003c/li>\n  <li><span class='match'>t\u003c/span>housand\u003c/li>\n  <li><span class='match'>t\u003c/span>hree\u003c/li>\n  <li><span class='match'>t\u003c/span>hrough\u003c/li>\n  <li><span class='match'>t\u003c/span>hrow\u003c/li>\n  <li><span class='match'>t\u003c/span>hursday\u003c/li>\n  <li><span class='match'>t\u003c/span>ie\u003c/li>\n  <li><span class='match'>t\u003c/span>ime\u003c/li>\n  <li><span class='match'>t\u003c/span>o\u003c/li>\n  <li><span class='match'>t\u003c/span>oday\u003c/li>\n  <li><span class='match'>t\u003c/span>ogether\u003c/li>\n  <li><span class='match'>t\u003c/span>omorrow\u003c/li>\n  <li><span class='match'>t\u003c/span>onight\u003c/li>\n  <li><span class='match'>t\u003c/span>oo\u003c/li>\n  <li><span class='match'>t\u003c/span>op\u003c/li>\n  <li><span class='match'>t\u003c/span>otal\u003c/li>\n  <li><span class='match'>t\u003c/span>ouch\u003c/li>\n  <li><span class='match'>t\u003c/span>oward\u003c/li>\n  <li><span class='match'>t\u003c/span>own\u003c/li>\n  <li><span class='match'>t\u003c/span>rade\u003c/li>\n  <li><span class='match'>t\u003c/span>raffic\u003c/li>\n  <li><span class='match'>t\u003c/span>rain\u003c/li>\n  <li><span class='match'>t\u003c/span>ransport\u003c/li>\n  <li><span class='match'>t\u003c/span>ravel\u003c/li>\n  <li><span class='match'>t\u003c/span>reat\u003c/li>\n  <li><span class='match'>t\u003c/span>ree\u003c/li>\n  <li><span class='match'>t\u003c/span>rouble\u003c/li>\n  <li><span class='match'>t\u003c/span>rue\u003c/li>\n  <li><span class='match'>t\u003c/span>rust\u003c/li>\n  <li><span class='match'>t\u003c/span>ry\u003c/li>\n  <li><span class='match'>t\u003c/span>uesday\u003c/li>\n  <li><span class='match'>t\u003c/span>urn\u003c/li>\n  <li><span class='match'>t\u003c/span>welve\u003c/li>\n  <li><span class='match'>t\u003c/span>wenty\u003c/li>\n  <li><span class='match'>t\u003c/span>wo\u003c/li>\n  <li><span class='match'>t\u003c/span>ype\u003c/li>\n  <li>u<span class='match'>n\u003c/span>der\u003c/li>\n  <li>u<span class='match'>n\u003c/span>derstand\u003c/li>\n  <li>u<span class='match'>n\u003c/span>ion\u003c/li>\n  <li>u<span class='match'>n\u003c/span>it\u003c/li>\n  <li>u<span class='match'>n\u003c/span>ite\u003c/li>\n  <li>u<span class='match'>n\u003c/span>iversity\u003c/li>\n  <li>u<span class='match'>n\u003c/span>less\u003c/li>\n  <li>u<span class='match'>n\u003c/span>til\u003c/li>\n  <li>u<span class='match'>p\u003c/span>\u003c/li>\n  <li>u<span class='match'>p\u003c/span>on\u003c/li>\n  <li>u<span class='match'>s\u003c/span>e\u003c/li>\n  <li>u<span class='match'>s\u003c/span>ual\u003c/li>\n  <li><span class='match'>v\u003c/span>alue\u003c/li>\n  <li><span class='match'>v\u003c/span>arious\u003c/li>\n  <li><span class='match'>v\u003c/span>ery\u003c/li>\n  <li><span class='match'>v\u003c/span>ideo\u003c/li>\n  <li><span class='match'>v\u003c/span>iew\u003c/li>\n  <li><span class='match'>v\u003c/span>illage\u003c/li>\n  <li><span class='match'>v\u003c/span>isit\u003c/li>\n  <li><span class='match'>v\u003c/span>ote\u003c/li>\n  <li><span class='match'>w\u003c/span>age\u003c/li>\n  <li><span class='match'>w\u003c/span>ait\u003c/li>\n  <li><span class='match'>w\u003c/span>alk\u003c/li>\n  <li><span class='match'>w\u003c/span>all\u003c/li>\n  <li><span class='match'>w\u003c/span>ant\u003c/li>\n  <li><span class='match'>w\u003c/span>ar\u003c/li>\n  <li><span class='match'>w\u003c/span>arm\u003c/li>\n  <li><span class='match'>w\u003c/span>ash\u003c/li>\n  <li><span class='match'>w\u003c/span>aste\u003c/li>\n  <li><span class='match'>w\u003c/span>atch\u003c/li>\n  <li><span class='match'>w\u003c/span>ater\u003c/li>\n  <li><span class='match'>w\u003c/span>ay\u003c/li>\n  <li><span class='match'>w\u003c/span>e\u003c/li>\n  <li><span class='match'>w\u003c/span>ear\u003c/li>\n  <li><span class='match'>w\u003c/span>ednesday\u003c/li>\n  <li><span class='match'>w\u003c/span>ee\u003c/li>\n  <li><span class='match'>w\u003c/span>eek\u003c/li>\n  <li><span class='match'>w\u003c/span>eigh\u003c/li>\n  <li><span class='match'>w\u003c/span>elcome\u003c/li>\n  <li><span class='match'>w\u003c/span>ell\u003c/li>\n  <li><span class='match'>w\u003c/span>est\u003c/li>\n  <li><span class='match'>w\u003c/span>hat\u003c/li>\n  <li><span class='match'>w\u003c/span>hen\u003c/li>\n  <li><span class='match'>w\u003c/span>here\u003c/li>\n  <li><span class='match'>w\u003c/span>hether\u003c/li>\n  <li><span class='match'>w\u003c/span>hich\u003c/li>\n  <li><span class='match'>w\u003c/span>hile\u003c/li>\n  <li><span class='match'>w\u003c/span>hite\u003c/li>\n  <li><span class='match'>w\u003c/span>ho\u003c/li>\n  <li><span class='match'>w\u003c/span>hole\u003c/li>\n  <li><span class='match'>w\u003c/span>hy\u003c/li>\n  <li><span class='match'>w\u003c/span>ide\u003c/li>\n  <li><span class='match'>w\u003c/span>ife\u003c/li>\n  <li><span class='match'>w\u003c/span>ill\u003c/li>\n  <li><span class='match'>w\u003c/span>in\u003c/li>\n  <li><span class='match'>w\u003c/span>ind\u003c/li>\n  <li><span class='match'>w\u003c/span>indow\u003c/li>\n  <li><span class='match'>w\u003c/span>ish\u003c/li>\n  <li><span class='match'>w\u003c/span>ith\u003c/li>\n  <li><span class='match'>w\u003c/span>ithin\u003c/li>\n  <li><span class='match'>w\u003c/span>ithout\u003c/li>\n  <li><span class='match'>w\u003c/span>oman\u003c/li>\n  <li><span class='match'>w\u003c/span>onder\u003c/li>\n  <li><span class='match'>w\u003c/span>ood\u003c/li>\n  <li><span class='match'>w\u003c/span>ord\u003c/li>\n  <li><span class='match'>w\u003c/span>ork\u003c/li>\n  <li><span class='match'>w\u003c/span>orld\u003c/li>\n  <li><span class='match'>w\u003c/span>orry\u003c/li>\n  <li><span class='match'>w\u003c/span>orse\u003c/li>\n  <li><span class='match'>w\u003c/span>orth\u003c/li>\n  <li><span class='match'>w\u003c/span>ould\u003c/li>\n  <li><span class='match'>w\u003c/span>rite\u003c/li>\n  <li><span class='match'>w\u003c/span>rong\u003c/li>\n  <li><span class='match'>y\u003c/span>ear\u003c/li>\n  <li><span class='match'>y\u003c/span>es\u003c/li>\n  <li><span class='match'>y\u003c/span>esterday\u003c/li>\n  <li><span class='match'>y\u003c/span>et\u003c/li>\n  <li><span class='match'>y\u003c/span>ou\u003c/li>\n  <li><span class='match'>y\u003c/span>oung\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

End with ed, but not with eed. 

```r
str_view(stringr::words, "[^e]ed$", match = T)
```

<!--html_preserve--><div id="htmlwidget-7f48dc931abf41d3faaa" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-7f48dc931abf41d3faaa">{"x":{"html":"<ul>\n  <li><span class='match'>bed\u003c/span>\u003c/li>\n  <li>hund<span class='match'>red\u003c/span>\u003c/li>\n  <li><span class='match'>red\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

End with ing or ise.

```r
str_view(stringr::words, "i(ng)|(se)$", match = T)
```

<!--html_preserve--><div id="htmlwidget-c8576a9f0a54e9f68d98" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-c8576a9f0a54e9f68d98">{"x":{"html":"<ul>\n  <li>adverti<span class='match'>se\u003c/span>\u003c/li>\n  <li>ba<span class='match'>se\u003c/span>\u003c/li>\n  <li>becau<span class='match'>se\u003c/span>\u003c/li>\n  <li>br<span class='match'>ing\u003c/span>\u003c/li>\n  <li>ca<span class='match'>se\u003c/span>\u003c/li>\n  <li>cau<span class='match'>se\u003c/span>\u003c/li>\n  <li>choo<span class='match'>se\u003c/span>\u003c/li>\n  <li>clo<span class='match'>se\u003c/span>\u003c/li>\n  <li>conver<span class='match'>se\u003c/span>\u003c/li>\n  <li>cour<span class='match'>se\u003c/span>\u003c/li>\n  <li>dur<span class='match'>ing\u003c/span>\u003c/li>\n  <li>el<span class='match'>se\u003c/span>\u003c/li>\n  <li>even<span class='match'>ing\u003c/span>\u003c/li>\n  <li>excu<span class='match'>se\u003c/span>\u003c/li>\n  <li>exerci<span class='match'>se\u003c/span>\u003c/li>\n  <li>expen<span class='match'>se\u003c/span>\u003c/li>\n  <li>hor<span class='match'>se\u003c/span>\u003c/li>\n  <li>hou<span class='match'>se\u003c/span>\u003c/li>\n  <li>increa<span class='match'>se\u003c/span>\u003c/li>\n  <li>k<span class='match'>ing\u003c/span>\u003c/li>\n  <li>lo<span class='match'>se\u003c/span>\u003c/li>\n  <li>mean<span class='match'>ing\u003c/span>\u003c/li>\n  <li>morn<span class='match'>ing\u003c/span>\u003c/li>\n  <li>oppo<span class='match'>se\u003c/span>\u003c/li>\n  <li>otherwi<span class='match'>se\u003c/span>\u003c/li>\n  <li>plea<span class='match'>se\u003c/span>\u003c/li>\n  <li>practi<span class='match'>se\u003c/span>\u003c/li>\n  <li>propo<span class='match'>se\u003c/span>\u003c/li>\n  <li>purpo<span class='match'>se\u003c/span>\u003c/li>\n  <li>rai<span class='match'>se\u003c/span>\u003c/li>\n  <li>reali<span class='match'>se\u003c/span>\u003c/li>\n  <li>r<span class='match'>ing\u003c/span>\u003c/li>\n  <li>ri<span class='match'>se\u003c/span>\u003c/li>\n  <li>sen<span class='match'>se\u003c/span>\u003c/li>\n  <li>s<span class='match'>ing\u003c/span>\u003c/li>\n  <li>s<span class='match'>ing\u003c/span>le\u003c/li>\n  <li>suppo<span class='match'>se\u003c/span>\u003c/li>\n  <li>surpri<span class='match'>se\u003c/span>\u003c/li>\n  <li>th<span class='match'>ing\u003c/span>\u003c/li>\n  <li>u<span class='match'>se\u003c/span>\u003c/li>\n  <li>wor<span class='match'>se\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

- Is “q” always followed by a “u”?

```r
str_view(stringr::words, "q[^u]", match = TRUE)
```

<!--html_preserve--><div id="htmlwidget-fc83e84b0116f80efd75" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-fc83e84b0116f80efd75">{"x":{"html":"<ul>\n  <li>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

- Write a regular expression that matches a word if it’s probably written in British English, not American English.

```r
str_view(stringr::words, "our$|re$|yse$", match = TRUE)
```

<!--html_preserve--><div id="htmlwidget-d51e89755e0b0b3baa0a" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-d51e89755e0b0b3baa0a">{"x":{"html":"<ul>\n  <li>awa<span class='match'>re\u003c/span>\u003c/li>\n  <li>befo<span class='match'>re\u003c/span>\u003c/li>\n  <li>ca<span class='match'>re\u003c/span>\u003c/li>\n  <li>cent<span class='match'>re\u003c/span>\u003c/li>\n  <li>col<span class='match'>our\u003c/span>\u003c/li>\n  <li>compa<span class='match'>re\u003c/span>\u003c/li>\n  <li>fav<span class='match'>our\u003c/span>\u003c/li>\n  <li>figu<span class='match'>re\u003c/span>\u003c/li>\n  <li>fi<span class='match'>re\u003c/span>\u003c/li>\n  <li>f<span class='match'>our\u003c/span>\u003c/li>\n  <li>futu<span class='match'>re\u003c/span>\u003c/li>\n  <li>he<span class='match'>re\u003c/span>\u003c/li>\n  <li>h<span class='match'>our\u003c/span>\u003c/li>\n  <li>insu<span class='match'>re\u003c/span>\u003c/li>\n  <li>lab<span class='match'>our\u003c/span>\u003c/li>\n  <li>measu<span class='match'>re\u003c/span>\u003c/li>\n  <li>mo<span class='match'>re\u003c/span>\u003c/li>\n  <li>natu<span class='match'>re\u003c/span>\u003c/li>\n  <li>pictu<span class='match'>re\u003c/span>\u003c/li>\n  <li>prepa<span class='match'>re\u003c/span>\u003c/li>\n  <li>pressu<span class='match'>re\u003c/span>\u003c/li>\n  <li>requi<span class='match'>re\u003c/span>\u003c/li>\n  <li>sco<span class='match'>re\u003c/span>\u003c/li>\n  <li>secu<span class='match'>re\u003c/span>\u003c/li>\n  <li>sha<span class='match'>re\u003c/span>\u003c/li>\n  <li>squa<span class='match'>re\u003c/span>\u003c/li>\n  <li>structu<span class='match'>re\u003c/span>\u003c/li>\n  <li>su<span class='match'>re\u003c/span>\u003c/li>\n  <li>the<span class='match'>re\u003c/span>\u003c/li>\n  <li>therefo<span class='match'>re\u003c/span>\u003c/li>\n  <li>whe<span class='match'>re\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

- Create a regular expression that will match telephone numbers as commonly written in your country.

```r
t<-c("111-222-3333", "111-1111-1111")
str_view(t, "\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d")
```

<!--html_preserve--><div id="htmlwidget-eb8bcdf89111e6ee8517" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-eb8bcdf89111e6ee8517">{"x":{"html":"<ul>\n  <li><span class='match'>111-222-3333\u003c/span>\u003c/li>\n  <li>111-1111-1111\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

####14.3.4.1 Exercises

- Describe the equivalents of ?, +, * in {m,n} form.
?  {0,1}
+  {1,}
*  {0,}

- Describe in words what these regular expressions match: (read carefully to see if I’m using a regular expression or a string that defines a regular expression.)

^.*$   It will match any string with length from 0 to infinity.  
"\\{.+\\}"   It will match strings that have curly braces around it and with length of at least 1. 
\d{4}-\d{2}-\d{2}   It will match strings that have pattern like this: any four digits-any two digits-any two digits
"\\\\{4}"   It will match strings that have four backslashes 

####14.3.5.1 Exercises
- Construct regular expressions to match words that:

Start and end with the same character.

```r
str_view(words, "^(.).*\\1$", match = T)
```

<!--html_preserve--><div id="htmlwidget-f793fc6a5f3515605075" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-f793fc6a5f3515605075">{"x":{"html":"<ul>\n  <li><span class='match'>america\u003c/span>\u003c/li>\n  <li><span class='match'>area\u003c/span>\u003c/li>\n  <li><span class='match'>dad\u003c/span>\u003c/li>\n  <li><span class='match'>dead\u003c/span>\u003c/li>\n  <li><span class='match'>depend\u003c/span>\u003c/li>\n  <li><span class='match'>educate\u003c/span>\u003c/li>\n  <li><span class='match'>else\u003c/span>\u003c/li>\n  <li><span class='match'>encourage\u003c/span>\u003c/li>\n  <li><span class='match'>engine\u003c/span>\u003c/li>\n  <li><span class='match'>europe\u003c/span>\u003c/li>\n  <li><span class='match'>evidence\u003c/span>\u003c/li>\n  <li><span class='match'>example\u003c/span>\u003c/li>\n  <li><span class='match'>excuse\u003c/span>\u003c/li>\n  <li><span class='match'>exercise\u003c/span>\u003c/li>\n  <li><span class='match'>expense\u003c/span>\u003c/li>\n  <li><span class='match'>experience\u003c/span>\u003c/li>\n  <li><span class='match'>eye\u003c/span>\u003c/li>\n  <li><span class='match'>health\u003c/span>\u003c/li>\n  <li><span class='match'>high\u003c/span>\u003c/li>\n  <li><span class='match'>knock\u003c/span>\u003c/li>\n  <li><span class='match'>level\u003c/span>\u003c/li>\n  <li><span class='match'>local\u003c/span>\u003c/li>\n  <li><span class='match'>nation\u003c/span>\u003c/li>\n  <li><span class='match'>non\u003c/span>\u003c/li>\n  <li><span class='match'>rather\u003c/span>\u003c/li>\n  <li><span class='match'>refer\u003c/span>\u003c/li>\n  <li><span class='match'>remember\u003c/span>\u003c/li>\n  <li><span class='match'>serious\u003c/span>\u003c/li>\n  <li><span class='match'>stairs\u003c/span>\u003c/li>\n  <li><span class='match'>test\u003c/span>\u003c/li>\n  <li><span class='match'>tonight\u003c/span>\u003c/li>\n  <li><span class='match'>transport\u003c/span>\u003c/li>\n  <li><span class='match'>treat\u003c/span>\u003c/li>\n  <li><span class='match'>trust\u003c/span>\u003c/li>\n  <li><span class='match'>window\u003c/span>\u003c/li>\n  <li><span class='match'>yesterday\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Contain a repeated pair of letters (e.g. “church” contains “ch” repeated twice.)

```r
str_view(words, "(..).*\\1", match = T)
```

<!--html_preserve--><div id="htmlwidget-17f283c48ec78aca0e50" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-17f283c48ec78aca0e50">{"x":{"html":"<ul>\n  <li>ap<span class='match'>propr\u003c/span>iate\u003c/li>\n  <li><span class='match'>church\u003c/span>\u003c/li>\n  <li>c<span class='match'>ondition\u003c/span>\u003c/li>\n  <li><span class='match'>decide\u003c/span>\u003c/li>\n  <li><span class='match'>environmen\u003c/span>t\u003c/li>\n  <li>l<span class='match'>ondon\u003c/span>\u003c/li>\n  <li>pa<span class='match'>ragra\u003c/span>ph\u003c/li>\n  <li>p<span class='match'>articular\u003c/span>\u003c/li>\n  <li><span class='match'>photograph\u003c/span>\u003c/li>\n  <li>p<span class='match'>repare\u003c/span>\u003c/li>\n  <li>p<span class='match'>ressure\u003c/span>\u003c/li>\n  <li>r<span class='match'>emem\u003c/span>ber\u003c/li>\n  <li><span class='match'>repre\u003c/span>sent\u003c/li>\n  <li><span class='match'>require\u003c/span>\u003c/li>\n  <li><span class='match'>sense\u003c/span>\u003c/li>\n  <li>the<span class='match'>refore\u003c/span>\u003c/li>\n  <li>u<span class='match'>nderstand\u003c/span>\u003c/li>\n  <li>w<span class='match'>hethe\u003c/span>r\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Contain one letter repeated in at least three places (e.g. “eleven” contains three “e”s.)

```r
str_view(words, "(.).*\\1.*\\1", match = T)
```

<!--html_preserve--><div id="htmlwidget-bea92024a7e5693cd363" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-bea92024a7e5693cd363">{"x":{"html":"<ul>\n  <li>a<span class='match'>pprop\u003c/span>riate\u003c/li>\n  <li><span class='match'>availa\u003c/span>ble\u003c/li>\n  <li>b<span class='match'>elieve\u003c/span>\u003c/li>\n  <li>b<span class='match'>etwee\u003c/span>n\u003c/li>\n  <li>bu<span class='match'>siness\u003c/span>\u003c/li>\n  <li>d<span class='match'>egree\u003c/span>\u003c/li>\n  <li>diff<span class='match'>erence\u003c/span>\u003c/li>\n  <li>di<span class='match'>scuss\u003c/span>\u003c/li>\n  <li><span class='match'>eleve\u003c/span>n\u003c/li>\n  <li>e<span class='match'>nvironmen\u003c/span>t\u003c/li>\n  <li><span class='match'>evidence\u003c/span>\u003c/li>\n  <li><span class='match'>exercise\u003c/span>\u003c/li>\n  <li><span class='match'>expense\u003c/span>\u003c/li>\n  <li><span class='match'>experience\u003c/span>\u003c/li>\n  <li><span class='match'>indivi\u003c/span>dual\u003c/li>\n  <li>p<span class='match'>aragra\u003c/span>ph\u003c/li>\n  <li>r<span class='match'>eceive\u003c/span>\u003c/li>\n  <li>r<span class='match'>emembe\u003c/span>r\u003c/li>\n  <li>r<span class='match'>eprese\u003c/span>nt\u003c/li>\n  <li>t<span class='match'>elephone\u003c/span>\u003c/li>\n  <li>th<span class='match'>erefore\u003c/span>\u003c/li>\n  <li>t<span class='match'>omorro\u003c/span>w\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

####14.4.2 Exercises

- For each of the following challenges, try solving it by using both a single regular expression, and a combination of multiple str_detect() calls.

Find all words that start or end with x.

```r
str_view(words, "^x|x$", match = T)
```

<!--html_preserve--><div id="htmlwidget-b24502369d466d335284" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-b24502369d466d335284">{"x":{"html":"<ul>\n  <li>bo<span class='match'>x\u003c/span>\u003c/li>\n  <li>se<span class='match'>x\u003c/span>\u003c/li>\n  <li>si<span class='match'>x\u003c/span>\u003c/li>\n  <li>ta<span class='match'>x\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
s.w.x<-str_detect(words, "^x")
e.w.x<-str_detect(words, "x$")
words[s.w.x|e.w.x]
```

```
## [1] "box" "sex" "six" "tax"
```

Find all words that start with a vowel and end with a consonant.

```r
str_view(words, "^[aeiou].*[^aeiou]$", match = T)
```

<!--html_preserve--><div id="htmlwidget-9f14d3d03ca7f122e1b8" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-9f14d3d03ca7f122e1b8">{"x":{"html":"<ul>\n  <li><span class='match'>about\u003c/span>\u003c/li>\n  <li><span class='match'>accept\u003c/span>\u003c/li>\n  <li><span class='match'>account\u003c/span>\u003c/li>\n  <li><span class='match'>across\u003c/span>\u003c/li>\n  <li><span class='match'>act\u003c/span>\u003c/li>\n  <li><span class='match'>actual\u003c/span>\u003c/li>\n  <li><span class='match'>add\u003c/span>\u003c/li>\n  <li><span class='match'>address\u003c/span>\u003c/li>\n  <li><span class='match'>admit\u003c/span>\u003c/li>\n  <li><span class='match'>affect\u003c/span>\u003c/li>\n  <li><span class='match'>afford\u003c/span>\u003c/li>\n  <li><span class='match'>after\u003c/span>\u003c/li>\n  <li><span class='match'>afternoon\u003c/span>\u003c/li>\n  <li><span class='match'>again\u003c/span>\u003c/li>\n  <li><span class='match'>against\u003c/span>\u003c/li>\n  <li><span class='match'>agent\u003c/span>\u003c/li>\n  <li><span class='match'>air\u003c/span>\u003c/li>\n  <li><span class='match'>all\u003c/span>\u003c/li>\n  <li><span class='match'>allow\u003c/span>\u003c/li>\n  <li><span class='match'>almost\u003c/span>\u003c/li>\n  <li><span class='match'>along\u003c/span>\u003c/li>\n  <li><span class='match'>already\u003c/span>\u003c/li>\n  <li><span class='match'>alright\u003c/span>\u003c/li>\n  <li><span class='match'>although\u003c/span>\u003c/li>\n  <li><span class='match'>always\u003c/span>\u003c/li>\n  <li><span class='match'>amount\u003c/span>\u003c/li>\n  <li><span class='match'>and\u003c/span>\u003c/li>\n  <li><span class='match'>another\u003c/span>\u003c/li>\n  <li><span class='match'>answer\u003c/span>\u003c/li>\n  <li><span class='match'>any\u003c/span>\u003c/li>\n  <li><span class='match'>apart\u003c/span>\u003c/li>\n  <li><span class='match'>apparent\u003c/span>\u003c/li>\n  <li><span class='match'>appear\u003c/span>\u003c/li>\n  <li><span class='match'>apply\u003c/span>\u003c/li>\n  <li><span class='match'>appoint\u003c/span>\u003c/li>\n  <li><span class='match'>approach\u003c/span>\u003c/li>\n  <li><span class='match'>arm\u003c/span>\u003c/li>\n  <li><span class='match'>around\u003c/span>\u003c/li>\n  <li><span class='match'>art\u003c/span>\u003c/li>\n  <li><span class='match'>as\u003c/span>\u003c/li>\n  <li><span class='match'>ask\u003c/span>\u003c/li>\n  <li><span class='match'>at\u003c/span>\u003c/li>\n  <li><span class='match'>attend\u003c/span>\u003c/li>\n  <li><span class='match'>authority\u003c/span>\u003c/li>\n  <li><span class='match'>away\u003c/span>\u003c/li>\n  <li><span class='match'>awful\u003c/span>\u003c/li>\n  <li><span class='match'>each\u003c/span>\u003c/li>\n  <li><span class='match'>early\u003c/span>\u003c/li>\n  <li><span class='match'>east\u003c/span>\u003c/li>\n  <li><span class='match'>easy\u003c/span>\u003c/li>\n  <li><span class='match'>eat\u003c/span>\u003c/li>\n  <li><span class='match'>economy\u003c/span>\u003c/li>\n  <li><span class='match'>effect\u003c/span>\u003c/li>\n  <li><span class='match'>egg\u003c/span>\u003c/li>\n  <li><span class='match'>eight\u003c/span>\u003c/li>\n  <li><span class='match'>either\u003c/span>\u003c/li>\n  <li><span class='match'>elect\u003c/span>\u003c/li>\n  <li><span class='match'>electric\u003c/span>\u003c/li>\n  <li><span class='match'>eleven\u003c/span>\u003c/li>\n  <li><span class='match'>employ\u003c/span>\u003c/li>\n  <li><span class='match'>end\u003c/span>\u003c/li>\n  <li><span class='match'>english\u003c/span>\u003c/li>\n  <li><span class='match'>enjoy\u003c/span>\u003c/li>\n  <li><span class='match'>enough\u003c/span>\u003c/li>\n  <li><span class='match'>enter\u003c/span>\u003c/li>\n  <li><span class='match'>environment\u003c/span>\u003c/li>\n  <li><span class='match'>equal\u003c/span>\u003c/li>\n  <li><span class='match'>especial\u003c/span>\u003c/li>\n  <li><span class='match'>even\u003c/span>\u003c/li>\n  <li><span class='match'>evening\u003c/span>\u003c/li>\n  <li><span class='match'>ever\u003c/span>\u003c/li>\n  <li><span class='match'>every\u003c/span>\u003c/li>\n  <li><span class='match'>exact\u003c/span>\u003c/li>\n  <li><span class='match'>except\u003c/span>\u003c/li>\n  <li><span class='match'>exist\u003c/span>\u003c/li>\n  <li><span class='match'>expect\u003c/span>\u003c/li>\n  <li><span class='match'>explain\u003c/span>\u003c/li>\n  <li><span class='match'>express\u003c/span>\u003c/li>\n  <li><span class='match'>identify\u003c/span>\u003c/li>\n  <li><span class='match'>if\u003c/span>\u003c/li>\n  <li><span class='match'>important\u003c/span>\u003c/li>\n  <li><span class='match'>in\u003c/span>\u003c/li>\n  <li><span class='match'>indeed\u003c/span>\u003c/li>\n  <li><span class='match'>individual\u003c/span>\u003c/li>\n  <li><span class='match'>industry\u003c/span>\u003c/li>\n  <li><span class='match'>inform\u003c/span>\u003c/li>\n  <li><span class='match'>instead\u003c/span>\u003c/li>\n  <li><span class='match'>interest\u003c/span>\u003c/li>\n  <li><span class='match'>invest\u003c/span>\u003c/li>\n  <li><span class='match'>it\u003c/span>\u003c/li>\n  <li><span class='match'>item\u003c/span>\u003c/li>\n  <li><span class='match'>obvious\u003c/span>\u003c/li>\n  <li><span class='match'>occasion\u003c/span>\u003c/li>\n  <li><span class='match'>odd\u003c/span>\u003c/li>\n  <li><span class='match'>of\u003c/span>\u003c/li>\n  <li><span class='match'>off\u003c/span>\u003c/li>\n  <li><span class='match'>offer\u003c/span>\u003c/li>\n  <li><span class='match'>often\u003c/span>\u003c/li>\n  <li><span class='match'>okay\u003c/span>\u003c/li>\n  <li><span class='match'>old\u003c/span>\u003c/li>\n  <li><span class='match'>on\u003c/span>\u003c/li>\n  <li><span class='match'>only\u003c/span>\u003c/li>\n  <li><span class='match'>open\u003c/span>\u003c/li>\n  <li><span class='match'>opportunity\u003c/span>\u003c/li>\n  <li><span class='match'>or\u003c/span>\u003c/li>\n  <li><span class='match'>order\u003c/span>\u003c/li>\n  <li><span class='match'>original\u003c/span>\u003c/li>\n  <li><span class='match'>other\u003c/span>\u003c/li>\n  <li><span class='match'>ought\u003c/span>\u003c/li>\n  <li><span class='match'>out\u003c/span>\u003c/li>\n  <li><span class='match'>over\u003c/span>\u003c/li>\n  <li><span class='match'>own\u003c/span>\u003c/li>\n  <li><span class='match'>under\u003c/span>\u003c/li>\n  <li><span class='match'>understand\u003c/span>\u003c/li>\n  <li><span class='match'>union\u003c/span>\u003c/li>\n  <li><span class='match'>unit\u003c/span>\u003c/li>\n  <li><span class='match'>university\u003c/span>\u003c/li>\n  <li><span class='match'>unless\u003c/span>\u003c/li>\n  <li><span class='match'>until\u003c/span>\u003c/li>\n  <li><span class='match'>up\u003c/span>\u003c/li>\n  <li><span class='match'>upon\u003c/span>\u003c/li>\n  <li><span class='match'>usual\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
s.w.v<-str_detect(words, "^[aeiou]")
e.w.c<-str_detect(words, "[^aeiou]$")
words[s.w.v&e.w.c]
```

```
##   [1] "about"       "accept"      "account"     "across"      "act"        
##   [6] "actual"      "add"         "address"     "admit"       "affect"     
##  [11] "afford"      "after"       "afternoon"   "again"       "against"    
##  [16] "agent"       "air"         "all"         "allow"       "almost"     
##  [21] "along"       "already"     "alright"     "although"    "always"     
##  [26] "amount"      "and"         "another"     "answer"      "any"        
##  [31] "apart"       "apparent"    "appear"      "apply"       "appoint"    
##  [36] "approach"    "arm"         "around"      "art"         "as"         
##  [41] "ask"         "at"          "attend"      "authority"   "away"       
##  [46] "awful"       "each"        "early"       "east"        "easy"       
##  [51] "eat"         "economy"     "effect"      "egg"         "eight"      
##  [56] "either"      "elect"       "electric"    "eleven"      "employ"     
##  [61] "end"         "english"     "enjoy"       "enough"      "enter"      
##  [66] "environment" "equal"       "especial"    "even"        "evening"    
##  [71] "ever"        "every"       "exact"       "except"      "exist"      
##  [76] "expect"      "explain"     "express"     "identify"    "if"         
##  [81] "important"   "in"          "indeed"      "individual"  "industry"   
##  [86] "inform"      "instead"     "interest"    "invest"      "it"         
##  [91] "item"        "obvious"     "occasion"    "odd"         "of"         
##  [96] "off"         "offer"       "often"       "okay"        "old"        
## [101] "on"          "only"        "open"        "opportunity" "or"         
## [106] "order"       "original"    "other"       "ought"       "out"        
## [111] "over"        "own"         "under"       "understand"  "union"      
## [116] "unit"        "university"  "unless"      "until"       "up"         
## [121] "upon"        "usual"
```

####14.4.3.1 Exercises
- From the Harvard sentences data, extract:

The first word from each sentence.

```r
str_extract(sentences, "[^ ]+")
```

```
##   [1] "The"        "Glue"       "It's"       "These"      "Rice"      
##   [6] "The"        "The"        "The"        "Four"       "Large"     
##  [11] "The"        "A"          "The"        "Kick"       "Help"      
##  [16] "A"          "Smoky"      "The"        "The"        "The"       
##  [21] "The"        "The"        "Press"      "The"        "The"       
##  [26] "Two"        "Her"        "The"        "It"         "Read"      
##  [31] "Hoist"      "Take"       "Note"       "Wipe"       "Mend"      
##  [36] "The"        "The"        "The"        "The"        "What"      
##  [41] "A"          "The"        "Sickness"   "The"        "The"       
##  [46] "Lift"       "The"        "Hop"        "The"        "Mesh"      
##  [51] "The"        "The"        "Adding"     "The"        "A"         
##  [56] "The"        "March"      "A"          "Place"      "Both"      
##  [61] "We"         "Use"        "He"         "The"        "A"         
##  [66] "Cars"       "The"        "This"       "The"        "Those"     
##  [71] "A"          "The"        "The"        "The"        "The"       
##  [76] "A"          "The"        "The"        "The"        "The"       
##  [81] "The"        "See"        "There"      "The"        "The"       
##  [86] "The"        "Cut"        "Men"        "Always"     "He"        
##  [91] "The"        "A"          "A"          "The"        "The"       
##  [96] "Bail"       "The"        "A"          "Ten"        "The"       
## [101] "Oak"        "Cats"       "The"        "Open"       "Add"       
## [106] "Thieves"    "The"        "Act"        "The"        "Move"      
## [111] "The"        "Leaves"     "The"        "Split"      "Burn"      
## [116] "He"         "Weave"      "Hemp"       "A"          "We"        
## [121] "Type"       "The"        "The"        "The"        "Paste"     
## [126] "The"        "It"         "The"        "Feel"       "The"       
## [131] "A"          "He"         "Pluck"      "Two"        "The"       
## [136] "Bring"      "Write"      "Clothes"    "We"         "Port"      
## [141] "The"        "Guess"      "A"          "The"        "These"     
## [146] "Pure"       "The"        "The"        "Mud"        "The"       
## [151] "The"        "A"          "He"         "The"        "The"       
## [156] "The"        "The"        "We"         "She"        "The"       
## [161] "The"        "At"         "Drop"       "A"          "An"        
## [166] "Wood"       "The"        "He"         "A"          "A"         
## [171] "Steam"      "The"        "There"      "The"        "Torn"      
## [176] "Sunday"     "The"        "The"        "They"       "Add"       
## [181] "Acid"       "Fairy"      "Eight"      "The"        "A"         
## [186] "Add"        "We"         "There"      "He"         "She"       
## [191] "The"        "Corn"       "Where"      "The"        "Sell"      
## [196] "The"        "The"        "Bring"      "They"       "Farmers"   
## [201] "The"        "The"        "Float"      "A"          "A"         
## [206] "The"        "After"      "The"        "He"         "Even"      
## [211] "The"        "The"        "The"        "Do"         "Lire"      
## [216] "The"        "It"         "Write"      "The"        "The"       
## [221] "A"          "Coax"       "Schools"    "The"        "They"      
## [226] "The"        "The"        "Jazz"       "Rake"       "Slash"     
## [231] "Try"        "They"       "He"         "They"       "The"       
## [236] "Whitings"   "Some"       "Jerk"       "A"          "Madam,"    
## [241] "On"         "The"        "This"       "Add"        "The"       
## [246] "The"        "The"        "To"         "The"        "Jump"      
## [251] "Yell"       "They"       "Both"       "In"         "The"       
## [256] "The"        "Ducks"      "Fruit"      "These"      "Canned"    
## [261] "The"        "Carry"      "The"        "We"         "Gray"      
## [266] "The"        "High"       "Tea"        "A"          "A"         
## [271] "The"        "Find"       "Cut"        "The"        "Look"      
## [276] "The"        "Nine"       "The"        "The"        "Soak"      
## [281] "The"        "A"          "All"        "ii"         "To"        
## [286] "Shape"      "The"        "Hedge"      "Quench"     "Tight"     
## [291] "The"        "The"        "The"        "Watch"      "The"       
## [296] "The"        "Write"      "His"        "The"        "Tin"       
## [301] "Slide"      "The"        "The"        "Pink"       "She"       
## [306] "The"        "It"         "Let's"      "The"        "The"       
## [311] "The"        "The"        "The"        "Paper"      "The"       
## [316] "The"        "Screw"      "Time"       "The"        "Men"       
## [321] "Fill"       "He"         "We"         "Pack"       "The"       
## [326] "The"        "Boards"     "The"        "Glass"      "Bathe"     
## [331] "Nine"       "The"        "The"        "The"        "Pages"     
## [336] "Try"        "Women"      "The"        "A"          "Code"      
## [341] "Most"       "He"         "The"        "Mince"      "The"       
## [346] "Let"        "A"          "A"          "Tack"       "Next"      
## [351] "Pour"       "Each"       "The"        "The"        "The"       
## [356] "Just"       "A"          "Our"        "Brass"      "It"        
## [361] "Feed"       "The"        "He"         "The"        "Plead"     
## [366] "Better"     "This"       "The"        "He"         "Tend"      
## [371] "It"         "Mark"       "Take"       "The"        "North"     
## [376] "He"         "Go"         "A"          "Soap"       "That"      
## [381] "He"         "A"          "Grape"      "Roads"      "Fake"      
## [386] "The"        "Smoke"      "Serve"      "Much"       "The"       
## [391] "Heave"      "A"          "It's"       "His"        "The"       
## [396] "The"        "It"         "Beef"       "Raise"      "The"       
## [401] "A"          "Jerk"       "No"         "We"         "The"       
## [406] "The"        "Three"      "The"        "No"         "Grace"     
## [411] "Nudge"      "The"        "Once"       "A"          "Fasten"    
## [416] "A"          "He"         "The"        "The"        "There"     
## [421] "Seed"       "Draw"       "The"        "The"        "Hats"      
## [426] "The"        "Beat"       "Say"        "The"        "Screen"    
## [431] "This"       "The"        "He"         "These"      "The"       
## [436] "Twist"      "The"        "The"        "Xew"        "The"       
## [441] "They"       "The"        "A"          "Breakfast"  "Bottles"   
## [446] "The"        "He"         "Drop"       "The"        "Throw"     
## [451] "A"          "The"        "The"        "The"        "The"       
## [456] "Turn"       "The"        "The"        "To"         "The"       
## [461] "The"        "Dispense"   "The"        "He"         "The"       
## [466] "The"        "Fly"        "Thick"      "Birth"      "The"       
## [471] "The"        "A"          "The"        "We"         "The"       
## [476] "The"        "We"         "The"        "Five"       "A"         
## [481] "The"        "Shut"       "The"        "Crack"      "He"        
## [486] "Send"       "A"          "They"       "The"        "In"        
## [491] "A"          "Oats"       "Their"      "The"        "There"     
## [496] "Tuck"       "A"          "We"         "The"        "Take"      
## [501] "Shake"      "She"        "The"        "The"        "We"        
## [506] "Smile"      "A"          "The"        "Take"       "That"      
## [511] "The"        "The"        "Ripe"       "A"          "The"       
## [516] "The"        "The"        "This"       "She"        "The"       
## [521] "Press"      "Neat"       "The"        "The"        "The"       
## [526] "Shake"      "The"        "A"          "His"        "Flax"      
## [531] "Hurdle"     "A"          "Even"       "Peep"       "The"       
## [536] "Cheap"      "A"          "Flood"      "A"          "The"       
## [541] "Those"      "He"         "Dill"       "Down"       "Either"    
## [546] "The"        "If"         "At"         "Read"       "Fill"      
## [551] "The"        "Clams"      "The"        "The"        "Breathe"   
## [556] "It"         "A"          "A"          "A"          "A"         
## [561] "Paint"      "The"        "Bribes"     "Trample"    "The"       
## [566] "A"          "Footprints" "She"        "A"          "Prod"      
## [571] "It"         "The"        "It"         "The"        "Wake"      
## [576] "The"        "The"        "The"        "Hold"       "Next"      
## [581] "Every"      "He"         "They"       "Drive"      "Keep"      
## [586] "Sever"      "Paper"      "Slide"      "Help"       "A"         
## [591] "Stop"       "Jerk"       "Slidc"      "The"        "Light"     
## [596] "Set"        "Dull"       "A"          "Get"        "Choose"    
## [601] "A"          "He"         "There"      "The"        "Greet"     
## [606] "When"       "Sweet"      "A"          "A"          "Lush"      
## [611] "The"        "The"        "The"        "Sit"        "A"         
## [616] "The"        "Green"      "Tea"        "Pitch"      "The"       
## [621] "The"        "The"        "A"          "The"        "She"       
## [626] "The"        "Loop"       "Plead"      "Calves"     "Post"      
## [631] "Tear"       "A"          "A"          "It"         "Crouch"    
## [636] "Pack"       "The"        "Fine"       "Poached"    "Bad"       
## [641] "Ship"       "Dimes"      "They"       "The"        "The"       
## [646] "The"        "The"        "Pile"       "The"        "The"       
## [651] "The"        "The"        "A"          "The"        "The"       
## [656] "To"         "There"      "Cod"        "The"        "Dunk"      
## [661] "Hang"       "Cap"        "The"        "Be"         "Pick"      
## [666] "A"          "The"        "The"        "The"        "You"       
## [671] "Dots"       "Put"        "The"        "The"        "See"       
## [676] "Slide"      "Many"       "We"         "No"         "Dig"       
## [681] "The"        "A"          "Green"      "A"          "The"       
## [686] "A"          "The"        "The"        "Seven"      "Our"       
## [691] "The"        "It"         "One"        "Take"       "The"       
## [696] "The"        "The"        "Stop"       "The"        "The"       
## [701] "Open"       "Fish"       "Dip"        "Will"       "The"       
## [706] "The"        "The"        "He"         "Leave"      "The"       
## [711] "A"          "The"        "She"        "A"          "Small"     
## [716] "The"        "The"        "A"          "She"        "When"
```

All words ending in ing.

```r
has_ing <- str_subset(sentences, "[^ ]+ing[ .]")
str_extract(has_ing, "[^ ]+ing[ .]")
```

```
##  [1] "spring."    "evening."   "morning."   "winding "   "living."   
##  [6] "king "      "Adding "    "making "    "raging "    "playing "  
## [11] "sleeping "  "ring."      "glaring "   "sinking."   "dying "    
## [16] "Bring "     "lodging "   "filing "    "making "    "morning "  
## [21] "wearing "   "Bring "     "wading "    "swing "     "nothing."  
## [26] "ring "      "morning "   "sing "      "sleeping "  "painting." 
## [31] "walking "   "bring "     "bring "     "shipping."  "spring "   
## [36] "ring "      "winding "   "puzzling "  "spring "    "landing."  
## [41] "thing "     "waiting "   "whistling " "nothing."   "timing "   
## [46] "thing "     "spring "    "changing."  "drenching " "moving "   
## [51] "working "   "ring "
```


####14.4.4.1 Exercises

- Find all words that come after a “number” like “one”, “two”, “three” etc. Pull out both the number and the word.

```r
pattern<-"(one|two|three|four|five|six|seven|eight|nine|ten) +(\\S+)"
s.w.p<-sentences[str_detect(sentences, pattern)]
str_extract(s.w.p, pattern)
```

```
##  [1] "ten served"    "one over"      "seven books"   "two met"      
##  [5] "two factors"   "one and"       "three lists"   "seven is"     
##  [9] "two when"      "one floor."    "ten inches."   "one with"     
## [13] "one war"       "one button"    "six minutes."  "ten years"    
## [17] "one in"        "ten chased"    "one like"      "two shares"   
## [21] "two distinct"  "one costs"     "ten two"       "five robins." 
## [25] "four kinds"    "one rang"      "ten him."      "three story"  
## [29] "ten by"        "one wall."     "three inches"  "ten your"     
## [33] "six comes"     "one before"    "three batches" "two leaves."
```

####14.4.5.1 Exercises

- Replace all forward slashes in a string with backslashes.

```r
s<-c("/a", "/b/", "c//")
s.replaced<-(str_replace_all(s, "/", "\\\\"))
writeLines(s.replaced)
```

```
## \a
## \b\
## c\\
```

- Implement a simple version of str_to_lower() using replace_all().

```r
s<-"aierjnRvEdAS"
str_replace_all(s,c("R"="r", "E"="e", "A"="a", "S"="s"))
```

```
## [1] "aierjnrvedas"
```

####14.4.6.1 Exercises

- Split up a string like "apples, pears, and bananas" into individual components.

```r
x<-"apples, pears, and bananas"
str_split(x, ", and|,")
```

```
## [[1]]
## [1] "apples"   " pears"   " bananas"
```

- What does splitting with an empty string ("") do? Experiment, and then read the documentation. 
It splits the string into individual character.

```r
x<-"ay3nk%"
str_split(x, "")
```

```
## [[1]]
## [1] "a" "y" "3" "n" "k" "%"
```

####14.5.1 Exercises

- How would you find all strings containing \ with regex() vs. with fixed()?

```r
s<-c("ad","a\\bc","dd\\cs")
str_view(s,regex("\\\\"))
```

<!--html_preserve--><div id="htmlwidget-5f0c5a103886f141c9f4" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-5f0c5a103886f141c9f4">{"x":{"html":"<ul>\n  <li>ad\u003c/li>\n  <li>a<span class='match'>\\\u003c/span>bc\u003c/li>\n  <li>dd<span class='match'>\\\u003c/span>cs\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_view(s,fixed("\\"))
```

<!--html_preserve--><div id="htmlwidget-ac684aa67b99bed16b81" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ac684aa67b99bed16b81">{"x":{"html":"<ul>\n  <li>ad\u003c/li>\n  <li>a<span class='match'>\\\u003c/span>bc\u003c/li>\n  <li>dd<span class='match'>\\\u003c/span>cs\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

####10.6.1 Exercises

- Find the stringi functions that:
1. Count the number of words.   `stri_count_words()`
2. Find duplicated strings.   `stri_duplicated()`
3. Generate random text. 
`stri_rand_lipsum()` generates (pseudo) lorem ipsum text. 
`stri_rand_shuffle()` generates a (pseudo) random permutation of code points in each string.
`stri_rand_strings()` generates (pseudo) random strings of desired lengths.

- How do you control the language that stri_sort() uses for sorting?
By specifying the locale argument to the opts_collator.

###Topic 2: Writing functions
This is a functions which has:
Input: a data.frame that contains (at least) a life expectancy variable lifeExp and a variable for year
Output: a vector of estimated parameters, from a quadratic regression of lifeExp on year

```r
quadratic_fit <- function(dat, offset = 1952) {
  the_fit <- lm(lifeExp ~ poly(I(year - offset), 2), dat)
  setNames(coef(the_fit), c("intercept", "beta_1", "beta_2"))
}

quadratic_fit(gapminder %>% filter(country == "Canada"))
```

```
## intercept    beta_1    beta_2 
## 74.902750 13.086477 -0.296033
```







### Navigation
- This is the folder for hw10 in STAT545-hw-Feng-Yidie repo. You can go to [here](https://github.com/yidie/STAT545-hw-Feng-Yidie/tree/master/hw10) to find my work on "Scraping data from the web".
- [This](http://www.imdb.com/title/tt2380307/?ref_=nv_sr_1) is the webpage I used to get data from.
- [This]() is the clean dataframe I got.

### Process Report
- I followed the basic workflow: download html with `read_html()`, extract specific nodes with `html_nodes()` and extract content from nodes with `html_text()`, `html_attrs()` etc.
- At first, I tried to get the cast by using 'html_nodes(".itemprop")', which gives me not just the cast, and also something like "Animation", "Comedy" etc. Then I tried to use SelectorGadget to identify the css selectors more accurately, which leads me to change the code to `html_nodes("#titleCast span.itemprop")` and it works. [This video](http://selectorgadget.com/stable/doc/) is very helpful on how to use SelectorGadget.
- I also encountered difficulties when I tried to extract the profile link from the web. The page source shows <a href="/name/nm5645519/?ref_=tt_cl_t1" itemprop="url"> and I know that I need its href. But the only thing I can put in `html_nodes()` is the tag "a". And after I extract href from all the elements with tag "a", I got a lot of links besides those I want. I noticed that the profile links have a same pattern. They all start with "/name" and end with "tt_cl_t" following by one or more digits. So I made use of what I learned from character data in [hw06](https://github.com/yidie/STAT545-hw-Feng-Yidie/tree/master/hw06). I used `str_subset()` to get those links that match with the regular expression "^/name.*tt_cl_t\\d+$". Finally, I got the profile links successfully.
- Scraping data from the web is a very useful tool. And there is still a lot to learn. And dealing with character data can be annoying sometimes. But once you get it, everything will come together.   

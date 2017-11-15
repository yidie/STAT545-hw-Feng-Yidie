## This is a function to download the data from the url.
downl_tsv <- function(){
	download.file(url = "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv", destfile="gapminder.tsv")
}

## This is a function that computes the weighted mean gdpPercap by population.
## And then write the processed data which has weighted mean gdpPercap to file 
## in csv format. The argument 'dat' is the data we read in after downloading.
process_data<-function(dat){
	new_dat<-mutate(dat, 
				 newpop=pop/10000000, 
				 weight=newpop/sum(newpop), 
				 weighted_mean_gdp=gdpPercap*weight)
	write.csv(new_dat, "summary_dat.csv")
	return (new_dat)
}

## This is a function that plots weighted_mean_gdp over time via lm() for each continent. 
## The argument 'processed_dat' is the output from process_data().
plot_gdp_year<-function(processed_dat){
	ggplot(processed_dat, aes(year, weighted_mean_gdp, colour=continent)) + 
		geom_smooth(method="lm", se=FALSE) +
		labs(y="Weighted mean gdp by pop",
				 title = "Change of Weighted Mean GDP over Time by Continent")
}

## This is a function that creates scatterplot: weighted_mean_gdp against lifeExp for each continent. 
## The argument 'processed_dat' is the output from process_data().
plot_gdp_lifeExp<-function(processed_dat){
	ggplot(processed_dat, aes(lifeExp, weighted_mean_gdp, colour=continent)) + 
		geom_point() +
		labs(y="Weighted mean gdp by pop",
				 title = "Weighted Mean GDP vs LifeExp by Country")
}


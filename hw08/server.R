library(shiny)
library(ggplot2)
library(dplyr)

server <- function(input, output) {
	output$countryOutput <- renderUI({
		selectInput("countryInput", "Country",
					sort(unique(bcl$Country)),
					selected = "CANADA")
	})  
	
	filtered <- reactive({
		if (is.null(input$countryInput)) {
			return(NULL)
		}    
		
		bcl %>%
			filter(Price >= input$priceInput[1],
				   Price <= input$priceInput[2],
				   # replace == to %in% because typeInput now can be a list (multiple alcohol types)
				   Type %in% input$typeInput,
				   Country == input$countryInput
			)
	})
	
	output$coolplot <- renderPlot({
		if (is.null(filtered())) {
			return()
		}
		ggplot(filtered(), aes(Alcohol_Content)) +
			# Let the user choose the color of the histogram.
			geom_histogram(fill=input$colInput)
	})
	
	# Use the DT package to turn the current results table into an interactive table.
	output$results <- DT::renderDataTable({
		# If sortInput is T, then arrange the results by price. Otherwise return filtered().
		if (input$sortInput==TRUE) {
			return(filtered() %>%
				   	arrange(Price))
		}
		filtered()
	})
	
	# Get the number of rows of filtered() and concatenate things together using paste0(). 
	output$summaryText <- renderText({
		number<-nrow(filtered())
		paste0("We found", " ", number, " ", "options for you.")
	})
	
	# Use downloadHandler() to enable user download the results as a csv file.
	output$download <- downloadHandler(
		filename=function(){
			"results.csv"},
		content=function(file){
			write.csv(filtered(), file)
		}
	)

}



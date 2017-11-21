library(shiny)
library(ggplot2)
library(dplyr)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
	titlePanel("BC Liquor Store prices"),
	sidebarLayout(
		sidebarPanel(
			sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
			
			# Allow the user to search for multiple alcohol types simultaneously.
			selectInput("typeInput", "Product type",
						 choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
						 selected = "WINE",
						 multiple = TRUE),
			
			uiOutput("countryOutput"),
			
			# Add checkboxInput() to get TRUE/FALSE values from the user.
			checkboxInput("sortInput", "Sort results by price", value = FALSE),
			
			# Add color parameter to the plot.
			shinyjs::colourInput("colInput", "Color", value="black")
		),
		mainPanel(
			# Place the plot and the table in separate tabs using tabsetPanel().
			tabsetPanel(
				tabPanel("Plot", plotOutput("coolplot")),
				br(), br(),
				# Use the DT package to turn the current results table into an interactive table.
				tabPanel("Table", DT::dataTableOutput("results"))
			),
			
			#  Add a textOutput() to the UI.
			h3(textOutput("summaryText")),
			
			# Add download button.
			downloadButton("download", "Download results")
		)
	),
	# Add an image of the BC Liquor Store to the UI.
	img(src = "bc_liquor_stores.png")
)


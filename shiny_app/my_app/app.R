# Library calls
library(shiny)
library(bslib)
library(shinythemes)
library(ggplot2)
# User Interface
ui <- page_navbar(
  # Some CSS stuff
  tags$head(tags$style(HTML("
    .centered-text {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
      }
    "))
  ),
  # Theme
  theme = shinytheme("cerulean"),
  # The title
  title = "Data Science versus Data Analysis",
  # Inversion of coloring (should be white by default)
  inverse = TRUE,
  # Navigation panels for new information nav_panel(title, page)
  nav_panel(title = "What is Data?",
            h1("Introduction"),

            p("Let us begin by describing what Data is for our reader. Data is anything that is either structured or unstructured that may be utilized for collection, processing, and visualization."),

            p("Typically, you begin with a question you might want to analyze. You then would shop for that data through various sources."),

            h2("Structured Data"),

            p("Structured data makes life easy. Anything that is easily processable (readable) without parsing beforehand is considered structured data. Much of what we use in R will be comma separated value (CSV) files, which are easily loaded into a data frame for manipulation."),

            h2("Unstructured Data"),

            p("Unstructured data makes life hard. It is not in any specific format and typically is not easily processed. You would then have to parse that data into a readable file before processing it for any sort of manipulation."),

            h2("Data Life Cycle"),

            p("It is important to note how to best handle your data."),

            p("1.  Raw data collection."),
            p("2.  Parsing acquired data (sometimes referred to as \"cleaning\")."),
            p("3.  Loading data into storage (typically a data-frame in R)."),
            p("4.  Process (manipulate) the data loaded into storage."),
            p("5.  Analyze the output from the processed data."),
            p("6.  Store the analysis for recovery."),

            h1("Conclusion"),

            p("Data is an important part of every day life. So much so, that many nation states rely on it for security and companies to maintain profitability in the turbulent world."),

            p("Data is important for the ability to help us make better decisions, solve problems, and evaluate performance. Good luck in your data collection and thank you for reading!")
            ),
  nav_panel(title = "Defining Data Science.",
            h1("Introduction"),

            p("Data science often utilizes techniques to make a prediction about the future. The field of data science makes use of the concept of predictive modeling. Often dealing with the unknown by using more advanced data techniques to make predictions about a data set."),

            p("Typically, data science is involved with the building of data sets or structuring an unstructured data set to make those predictive models."),

            h2("Reading and Parsing Data"),

            p("As you may have seen from the previous page on 'what is analysis' we had to partly clean up our data. The file containing our ", tags$a(href="https://www.eia.gov/dnav/ng/hist/n9140us2M.htm", "data-set"), " with consumption from January 2001 to August 2024 had a character vector instead of a date type. This column in the data frame had to be manipulated where it was readable by our graph we computed. Now, we will summarize the data with some basic statistical computation."),

            div(class = "centered-text", tableOutput("myData")),
            
            h2("Reading a Plot"),

            plotOutput("myGraph"),

            h1("Conclusion"),
            p("The advanced part of making predictions is to extrapolate data for a future reference. We are using the same visual reference in the previous page on 'what is analysis', but we are making the assumption next year will have similar results for these United States regarding higher consumption during the months starting with October through March. We will also make the conjecture that peak consumption will happen in January around 3700000 million cubic feet.")

            ),
  nav_panel(title = "Defining Data Analysis.",
            h1("Inroduction"),

            p("A data analysis will involve utilizing structured data to find tangible solutions with various programming languages for visualization and statistical work. Some of the programming languages used are R and SQL (server query language)."),

            p("Typically, data analysis is used to understand structured data to gain insights into trends or actionable material."),

            h2("Analyzing a .csv file"),

            p("We may begin here by loading a comma separated file (.csv) to gain insight about natural gas consumption in these United States. Typically, a cleaning of the data will involve removing any null values in the data-set before manipulation or any computation is undertaken."),

            p("The ", tags$a(href="https://www.eia.gov/dnav/ng/hist/n9140us2M.htm", "data-set"), " we will utilize is for monthly consumption from January 2001 to August 2024 of Natural Gas."),

            div(class = "centered-text", tableOutput("myHead")),

            h2("Loading a Plot"),

            p("We shall embed a plot of our previously read .csv file for a visualization of U.S. Natural Gas Consumption and make an inference by parsing a whole year."),

            plotOutput("sameGraph"),

            h1("Conclusion"),

            p("Notice the oscillation of the graph near 'winter' months. It is safe to make an inference that U.S. Natural Gas monthly consumption increased drastically near winter to keep homes, businesses, and what have you warm during what appears to be cold months. This would be our 'inference' or 'insight' into the data through visualization.")
  ),
  # Space in between paneling and navigation menu
  nav_spacer(),
  # Navigation menu for linked references.
  nav_panel(title = "References",
            tags$a("Reference Data: "),
            tags$a("Energy Information Agency Data", href = "https://www.eia.gov/totalenergy/data/annual/index.php"),
            tags$br(),
            tags$a("Porgram Reference: "),
            tags$a("The Github", href = "https://github.com/kandrsn99/Web-Hosting-Docker-Shiny-Proxy"),
            tags$br(),
            tags$a("R Shiny Reference: "),
            tags$a("Shiny", href="https://shiny.posit.co/")
  )
)
# Server functions and logic
server <- function(input, output) {
  # Get data
  my.data <- read.csv("./total_monthly_consumption.csv")
  # Create a summary frame
  numList <- as.numeric(unlist(my.data$Consumption))
  minumum <- min(numList, na.rm = TRUE)
  median_function <- median(numList, na.rm = TRUE)
  maximum <- max(numList, na.rm = TRUE)
  mean_function <- mean(numList, na.rm = TRUE)
  # Summary frame
  summary_frame <- data.frame(Value = "Consumption", Minimum = minumum, Median = median_function, Maximum = maximum, Mean = mean_function)
  # Create table
  output$myData <- renderTable({
    summary_frame
  })
  # Get Last Year
  Months <- head(my.data$Month, 12)
  Consumptions <- head(my.data$Consumption, 12)
  # Create Proper Frame
  annual.data <- head(my.data, 12)
  # Parse Months as a Level, then Plot
  myReactivePlot <- reactive({
    ggplot(data = annual.data, aes(x = factor(Months, c("Aug-24", "Jul-24", "Jun-24", "May-24", "Apr-24", "Mar-24", "Feb-24", "Jan-24", "Dec-23", "Nov-23", "Oct-23", "Sep-23")), y = Consumptions, group = 1)) +
      geom_line() +
      geom_point() +
      labs(title = "Monthly Consumption",
           x = "Month",
           y = "Consumption") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 5))
  })
  output$myGraph <- renderPlot({
    myReactivePlot()
  })
  output$sameGraph <- renderPlot({
    myReactivePlot()
  })
  # Get head of data
  output$myHead <- renderTable({
    head(my.data)
  })
}
# Application brought together by built-in functions
shinyApp(ui, server)


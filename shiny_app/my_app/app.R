# Library calls
library(shiny)
library(bslib)
library(rmarkdown)
library(shinythemes)
# User Interface
ui <- page_navbar(
  # Theme
  theme = shinytheme("cerulean"),
  # The title
  title = "Data Science versus Data Analysis",
  # ASCII Color for background on header bar.
  #bg = "#FF0000",
  # Inversion of coloring (should be white by default)
  inverse = TRUE,
  # Navigation panels for new information nav_panel(title, page)
  nav_panel(title = "What is Data?", uiOutput("data_markdown")),
  nav_panel(title = "Defining Data Science.", uiOutput("science_markdown")),
  nav_panel(title = "Define Data Analysis.", uiOutput("analysis_markdown")),
  # Space in between paneling and navigation menu
  nav_spacer(),
  # Navigation menu for linked references.
  nav_panel(title = "References",
            tags$a("Energy Information Agency Data Reference", href = "https://www.eia.gov/totalenergy/data/annual/index.php"),
            tags$br(),
            tags$a("Github Reference", href = "https://github.com/kandrsn99/Web-Hosting-Docker-Shiny-Proxy"),
            tags$br(),
            tags$a("R Shiny Reference", href="https://shiny.posit.co/")
            )
)
# Server functions and logic
server <- function(input, output) {
  # Output analysis page
  output$analysis_markdown <- renderUI({
    includeHTML(
      rmarkdown::render(
        input="./whatanalysis.Rmd"
    ))
  })
  # Output science page
  output$science_markdown <- renderUI({
    includeHTML(
      rmarkdown::render(
        input="./whatscience.Rmd"
      ))
  })
  # Output data page
  output$data_markdown <- renderUI({
    includeHTML(
      rmarkdown::render(
        input="./whatdata.Rmd"
      ))
  })
}
# Application brought together by built-in functions
shinyApp(ui, server)

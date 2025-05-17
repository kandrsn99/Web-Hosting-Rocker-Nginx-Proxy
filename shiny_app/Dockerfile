# Getting latest image of rocker shiny for containerization.
FROM rocker/shiny:latest
# Install proper R packages
RUN R -e "install.packages(c('shinythemes', 'bslib', 'ggplot2'), repos='http://cran.rstudio.com/')"
# Copy everything over where it is supposed to go for the website R Shiny.
COPY my_app/ /srv/shiny-server/
# Expose the proper port. Please note that we supersede the firewall when we open this port.
EXPOSE 3838
# Run script for shiny server
CMD ["/usr/bin/shiny-server"]

FROM openanalytics/r-ver:4.3.3 # Latest version of the docker image necessary for R Shiny Proxy.

RUN echo "\noptions(shiny.port=8080, shiny.host='0.0.0.0')" >> /usr/local/lib/R/etc/Rprofile.site # The local site path and host internet protocol (IP) address.

# General use system libraries
RUN apt-get update && apt-get install --no-install-recommends -y \
    pandoc \
    pandoc-citeproc \
    libcairo2-dev \
    libxt-dev \
    && rm -rf /var/lib/apt/lists/*

# Dependencies for system libraries
RUN apt-get update && apt-get install --no-install-recommends -y \
    libmpfr-dev \
    && rm -rf /var/lib/apt/lists/*

# R Shiny package installation
RUN R -q -e "options(warn=2); install.packages(c('shiny'))"

# install dependencies of all other necessary packages (Unfinished line)
# RUN R -q -e "options(warn=2); install.packages('file_path')"

# Get the R Scripts and place into a directory.
COPY name_application /app
WORKDIR /app

EXPOSE 8080 # Expose the port we utilize for public traffic.

CMD ["R", "-q", "-e", "shiny::runApp('/app')"] # Run the R Shiny Application
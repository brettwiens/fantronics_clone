# Use the official R Shiny image
FROM rocker/shiny:latest

RUN apt-get update && apt-get install -y xdg-utils

# Install required R packages (modify this for your app)
RUN R -e "install.packages(c( \
    'shiny', 'shinydashboard', 'httr', 'jsonlite', 'dplyr', 'data.table', 'lubridate'), \
    repos='http://cran.rstudio.com/')"


# Copy the entire Shiny app directory
COPY . /srv/shiny-server/
RUN chown -R shiny:shiny /srv/shiny-server
RUN chmod -R 755 /srv/shiny-server


# Ensure permissions for Shiny server
RUN chown -R shiny:shiny /srv/shiny-server

# Expose port 3838 for the Shiny app
EXPOSE 3838

# Run the Shiny app
CMD ["/usr/bin/shiny-server"]
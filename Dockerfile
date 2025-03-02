# Use the official R Shiny image
FROM rocker/shiny:latest

# Install system dependencies needed for compilation
RUN apt-get update -qq && apt-get install -y \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    build-essential \
    libharfbuzz-dev \
    libfribidi-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    build-essential \
    libyajl-dev

# Set compiler flags to bypass format-security errors
# ENV CFLAGS="-Wno-format-security"
ENV CFLAGS="-Wno-error=format-security"
ENV CXXFLAGS="-Wno-format-security"
ENV MAKEFLAGS="-j$(nproc)"

# Copy renv.lock file and install renv
COPY renv.lock ./renv.lock
RUN Rscript -e 'install.packages("renv", repos="http://cran.rstudio.com/")'

# Manually install rlang before restoring renv packages
RUN Rscript -e 'install.packages("rlang", repos="http://cran.rstudio.com/")'

# Preinstall jsonlite (before renv::restore to avoid compilation errors)
RUN Rscript -e 'install.packages("jsonlite", repos="http://cran.rstudio.com/")'

# Preinstall jsonlite (before renv::restore to avoid compilation errors)
# RUN Rscript -e 'install.packages("httr", repos="http://cran.rstudio.com/")'
RUN R -e "install.packages('httr', repos='http://cran.rstudio.com')"
RUN R -e "install.packages('dplyr', repos='http://cran.rstudio.com')"
RUN R -e "install.packages('data.table', repos='http://cran.rstudio.com')"
RUN R -e "install.packages('lubridate', repos='http://cran.rstudio.com')"
RUN R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com')"
# RUN R -e "install.packages('lubridate', repos='http://cran.rstudio.com')"

# Copy the app to the Shiny server directory
COPY . /srv/shiny-server/
RUN chown -R shiny:shiny /srv/shiny-server
RUN chmod -R 755 /srv/shiny-server

# Restore R packages with renv
# RUN Rscript -e 'renv::restore(rebuild=TRUE)'

# Expose port 3838 for Shiny Server
EXPOSE 3838

# Start the Shiny app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host = '0.0.0.0', port = 3838)"]

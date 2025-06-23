
# start from rocker/shiny (Ubuntu + R + Shiny Server)
# use offical rocker/shiny image as base
FROM rocker/shiny:4.3.3

# update the packages list and install system libraries that will be used for HTTP requests
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev libfftw3-dev

# copy renv.lock and activate.R into /svr/app
COPY renv.lock renv/activate.R /srv/app/

# sets working directory for subsequent commands
WORKDIR /srv/app

# copy the rest of the application files into the server app
COPY . /srv/app

# download renv so that it can be used for the R virtual environment
RUN Rscript -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
# runs R in quiet mode and restores R package environment as specified in renv.lock
# we want to restore the environment AFTER we have copied over the files
RUN R -q -e 'renv::restore()'

# container will listen on port 3838
EXPOSE 3838

# the default command to launch the app
CMD ["R", "-e", "shiny::runApp('/srv/app', host='0.0.0.0', port=3838)"]
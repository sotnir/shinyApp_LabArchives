FROM rocker/r-base:latest

LABEL maintainer="Yukai Zou <yukai.zou@uhs.nhs.uk>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    # libcurl4-gnutls-dev \
    libcurl4-openssl-dev \
    libcairo2-dev \
    libxt-dev \
    libxml2-dev \
    libssl-dev \
    libssh2-1-dev \
    && rm -rf /var/lib/apt/lists/*

RUN install.r shiny \
    shinythemes \
    markdown \
    plyr \
    tidyverse \
    reshape2 \
    RColorBrewer \
    lubridate

RUN echo "local(options(shiny.port = 6307, shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site

RUN addgroup --system app \
    && adduser --system --ingroup app app

WORKDIR /home

COPY . .

RUN chown app:app -R /home

USER app

EXPOSE 6307

CMD ["R", "-e", "shiny::runApp('/home/shinyApp_LabArchives.R')"]
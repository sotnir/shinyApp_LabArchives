# UoS/UHS Research MRI Booking System

This github repository stores and manages the codes and descriptions of the shinyApp that generates diagrams of research utility for the MRI scanner at University Hospital Southampton NHS Foundation Trust, for report and auditing purposes.

For queries, please contact Dr Yukai Zou (Y.Zou@soton.ac.uk).

## Motivation

There needs to establish an SOP workflow for scheduling, report, and auditing, to monitor the use of the University's research slots. The report will be useful for Research Imaging Management Group and UoS/UHS finances. Such workflow needs to be as open and transparent for both UoS and UHS personnels as possible.

### Reporting frequency

Every 3 months.

| Date              | Status                      |
| ----------------- | --------------------------- |
| 31 December 2021  | Completed     |
| 28 February 2022  | Completed     |
| 31 May 2022       | Completed                   |
| 31 August 2022    | Scheduled                   |
| 30 November 2022  | Scheduled                   |

### Critical Control Points
 1. Increase/decrease of the slots used between report period
 2. UoS slots are used for UHS clinical scans and UHS R&D purposes
 3. Availability of research radiographer

## Getting Started

**IMPORTANT:** When launching the app it is your responsibility to make sure that both the data and computing resources are [complying with security requirements](https://mastering-shiny.org/scaling-security.html). Please avoid exposing any sensitive data such as any personally identifiable information.

You will need to have R and RStudio installed in order to run the interactive app.
 - [Install R](https://www.r-project.org/)
 - [Install RStudio](https://www.rstudio.com/)

To launch the app locally, first clone this github repo:

```
git clone https://github.com/yukaizou2015/shinyApp_LabArchives.git
```

In RStudio, open `shinyApp_LabArchives.R`. Uncomment the line below to set the path of working directory:
```{r}
# setwd("/path/to/shinyApp_LabArchives/")
```

Install dependent packages by running the following command in console (assuming that none of the packages has been installed before):
```{r}
install.packages(c("shiny", 
                   "shinythemes", 
                   "markdown, 
                   "plyr", 
                   "tidyverse", 
                   "reshape2", 
                   "RColorBrewer", 
                   "lubridate", 
                   "RColorBrewer"
                  )
                )
```

After the installation is finished, run the script and the app should be launching.

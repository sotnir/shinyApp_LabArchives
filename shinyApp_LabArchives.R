# Set working directory
setwd("~/Desktop/Southampton/2_UHS/Booking System/shinyApp_LabArchives/")

# Load packages
library(shiny); library(shinythemes); library(markdown); library(plyr); library(tidyverse); library(reshape2); library(RColorBrewer); library(lubridate); library(RColorBrewer)

# Define UI ----
if (interactive()) {
        ui <- fluidPage(theme = shinytheme("united"),
                        titlePanel("UoS-UHS Research MRI Booking System"),
                        
navbarPage("Menu", id = "myNavbarPage",
           tabPanel("Overview", 
                    includeMarkdown("Intro.md")
                    ),
           
           tabPanel("Report", 
                    sidebarPanel(fileInput("file", label = h3("File input")),
                                 
                                 dateInput("date1",
                                           h3("Start Date:"),
                                           value = "2021-11-01"
                                           # value = ifelse(exists("input$file"), yes=min(read.csv(input$file$datapath)$Date), no="2022-01-01")
                                           ),
                                 
                                 dateInput("date2",
                                           h3("End Date:"),
                                           value = "2022-02-28"),
                                 
                                 selectInput("select1", 
                                        h3("Select Type:"),
                                        choices = list("Utility by Type (bar)"  = 1, 
                                                       "Utility by Type (pie)"  = 2, 
                                                       "Monthly Utility (hours)" = 3,
                                                       "Monthly Utility (percentage)" = 4),
                                        selected = 1),
                                 
                                 # Button: Plot
                                 actionButton("updateButton", "Plot"),
                                 p("Click the button to create the plot to be displayed in the main panel. If the plot is not updated automatically, please click on this button again.")
                                 ),
                                 
                                 
                                 mainPanel(textOutput("file_selected"),
                                          tags$head(tags$style("#file_selected{
                                                        font-size: 20px;
                                                        font-style: bold;
                                                                }")
                                           ),
                                           fluidRow(column(width=12, 
                                             dataTableOutput("file_value"), 
                                             style = "height:50vh; overflow-y: scroll;overflow-x: scroll;")),
                                           textOutput("plot_text1"),
                                           tags$head(tags$style("#plot_text1{
                                                        font-size: 20px;
                                                        font-style: bold;
                                                                }")
                                           ),
                                          textOutput("plot_text2"),
                                           uiOutput("report_ggplot", width="100%"))
                                 )
                    )
           )

############################# Define server logic #############################
server <- function(input, output, session) {
        
        # Load Data
        X2Summary_out <- reactive({
                X2_out <- read.csv(input$file$datapath)
                return(X2_out)
        })
        
        
        
        observeEvent(input$updateButton, {
                
                output$file_selected <- renderText({
                        "File selected:"
                })
                
                output$plot_text1 <- renderText({
                        "Plot:"
                })
                
                date_start <- as.Date(input$date1)
                date_end <- as.Date(input$date2)
                dat_TypeHours <- X2Summary_out() %>% filter(Type != "") %>% 
                        dplyr::select(Type, Date = Begin, Hours) %>%
                        transform(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
                        
                        # Filter dates based on input
                        filter(Date > date_start & Date < date_end)
                
                date_first <- min(dat_TypeHours$Date)
                date_last <- max(dat_TypeHours$Date)
                nWeeks <- difftime(date_last, date_first, units="weeks") %>% 
                        as.numeric() %>% floor()
                time_unused <- 15 * nWeeks
                
                output$plot_text2 <- renderText({
                        paste0("First date of record: ", date_first,
                              "; Last date of record: ", date_last,
                              "; Number of weeks: ", nWeeks,
                              "; Total Research-protected Time: ", 
                              time_unused, " hours (IMPORTANT: This is an estimate and needs to manually deduct holiday closures, e.g. Bank holidays.)")
                })
                
                output$file_value <- renderDataTable({
                        X2Summary_out()
                })
                
                output$report_ggplot <- renderUI({
                        renderPlot(height=600,width=800,expr = if (input$select1 == 1) {
                                dat_ggplot() %>% ggplot(aes(x = Type , y = Hours)) + 
                                        geom_col(aes(fill=Type), col="black") +
                                        scale_fill_brewer(palette="Set1") +
                                        geom_text(aes(label = Hours), vjust = -0.5) +
                                        theme(text = element_text(size = 20),
                                              axis.text.x = element_text(angle = 45, hjust=0.95, vjust=1)) +
                                        ylab("Hours") + 
                                        guides(fill=F)
                        }
                        else if (input$select1 == 2) {
                                dat_ggplot() %>% ggplot(aes(x = "", y = Hours_percent, fill=Type)) +
                                        geom_bar(stat="identity", width=1, col="white") +
                                        coord_polar("y", start=0) +
                                        scale_fill_brewer(palette="Set1") +
                                        theme_void()
                        }
                        else if (input$select1 == 3) {
                                dat_ggplot() %>% filter(grepl("University Research|UHS Research", Type)) %>%
                                        ggplot(aes(x = Month, y = Hours)) +
                                        geom_col(aes(fill=Type), col="black") +
                                        scale_fill_brewer(palette="Set1") +
                                        geom_text(aes(label = Hours), vjust = -0.5) +
                                        theme(text = element_text(size = 15),
                                              axis.text.x = element_text(angle = 90, vjust=0.5)) +
                                        scale_x_date(date_breaks = "2 months", date_labels="%b-%Y") +
                                        facet_wrap(Type ~ .) +
                                        ylab("Hours") +
                                        guides(fill=F)
                        }
                        else if (input$select1 == 4) {
                                dat_ggplot() %>% filter(grepl("University Research|UHS Research", Type)) %>%
                                        ggplot(aes(x = Month, y = Hours_pct_month)) +
                                        geom_col(aes(fill=Type), col="black") +
                                        scale_fill_brewer(palette="Set1") +
                                        geom_text(aes(label = Hours_pct_month), vjust = -0.5) +
                                        theme(text = element_text(size = 15),
                                              axis.text.x = element_text(angle = 90, vjust=0.5)) +
                                        scale_x_date(date_breaks = "2 months", date_labels="%b-%Y") +
                                        facet_wrap(Type ~ .) +
                                        ylab("Time (%)") +
                                        guides(fill=F)
                        })
                })
                
############ Prepare data for plotting ############
                dat_ggplot <- function() {
                        # https://stackoverflow.com/questions/6052631/aggregate-daily-data-to-month-year-intervals/6082768#6082768
                        df_TypeHours <- ddply(dat_TypeHours, "Type", summarise, Hours=sum(Hours))
                        # Calculate Unused Time: 
                        # e.g. 15 hours/week * 30 weeks  = 450 hours
                        df_TypeHours <- df_TypeHours %>%
                                add_row(Type = "Unused", Hours = time_unused - sum(df_TypeHours$Hours)) %>% 
                                transform(Hours_percent = round(Hours / time_unused * 100)) %>% 
                                arrange(desc(Hours))
                        df_TypeHours$Type <- factor(df_TypeHours$Type, 
                                            levels = c("University Research",
                                               "UHS Research & Development",
                                               "UHS Clinical", 
                                               "Scanner Downtime",
                                               "Radiographer Not Available",
                                               "Unused"))
                        
                        if (input$select1 < 3) {
                                df_2 <- df_TypeHours
                        } else {
                                dat_TypeHours$Month <- floor_date(dat_TypeHours$Date, "month")
                                
                        df_2 <- ddply(dat_TypeHours, c("Month", "Type"), 
                        summarise, Hours = tapply(Hours, Type, sum)) %>% 
                                
                        # Calculate Monthly Hours: 15 hours/week * 4 weeks/mo = 60 hours/mo
                        transform(Hours_pct_month = round(Hours / 60 * 100))
                        df_2$Type <- factor(df_2$Type) %>% 
                                relevel("University Research")
                        }
                        
                        return(df_2)
                }
#################################################
        })
}

# Run the app ----
shinyApp(ui = ui, server = server)
}

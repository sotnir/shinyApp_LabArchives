# UoS/UHS Research MRI Booking System

This github repository stores and manages the codes and descriptions of the shinyApp that generates diagrams of research utility for the MRI scanner at University Hospital Southampton NHS Foundation Trust, for report and auditing purposes.

For queries, please contact Dr Yukai Zou (Y.Zou@soton.ac.uk).

## Motivation

There needs to establish an SOP workflow for scheduling, report, and auditing, to monitor the use of the University's research slots. The report will be useful for Research Imaging Management Group and UoS/UHS finances. Such workflow needs to be as open and transparent for both UoS and UHS personnels as possible.

### Reporting frequency

Every 3 months.

| Date             | Status    |
| ---------------- | --------- |
| 30 November 2022 | Completed |
| 28 February 2023 | Scheduled |
| 31 May 2023      | Scheduled |
| 31 August 2023   | Scheduled |
| 30 November 2023 | Scheduled |

### Critical Control Points

1.  Increase/decrease of the slots used between report period
2.  UoS slots are used for UHS clinical scans and UHS R&D purposes
3.  Availability of research radiographer

## Getting Started

**IMPORTANT:** When launching the app it is your responsibility to make sure that both the data and computing resources are [complying with security requirements](https://mastering-shiny.org/scaling-security.html). Please avoid exposing any sensitive data such as any personally identifiable information.

You will need to have Docker Desktop installed and running in order to launch the app.

- [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)

### 1. Working with an existing Docker image

You can pull an existing Docker imaging from Docker Hub Container Image Library using the `docker pull` command:

```
docker pull kai2019/shinyapp_labarchives
```

After pulling the image, you can use `docker run` command to launch the app. Use the `-p 4000:6307` argument:

```
docker run -p 4000:6307 kai2019/shinyapp_labarchives
```

Visit https://localhost:4000 in a web browser to start using the app. To stop the container, hit Ctrl+C.

### 2. Building a new Docker image locally

To build the app locally, first, clone this github repo:

```
git clone https://github.com/sotnir/shinyApp_LabArchives.git
```

Go to the directory, and build the image from the `Dockerfile` by running:

```
cd shinyApp_LabArchives/
docker build -t shinyapp_labarchives .
```

**Note:** Don't forget the `.` at the end which refers to the current directory where the `Dockerfile` resides.

After the image is built, run this command:

```
docker run -p 4000:6307 kai2019/shinyapp_labarchives
```

and visit https://localhost:4000 to start using the app.

![](https://raw.githubusercontent.com/yukaizou2015/shinyApp_LabArchives/main/img/app-overview-gui.png)

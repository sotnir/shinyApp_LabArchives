<img src="img/booking-system-overview.png" alt="Overview" width="50%"/>

Table of Contents
=================
 * [Overview](#overview)
 * [Quickstart](#How-to)
     1. [Sign In](#How-to-1-sign-in)
     2. [Get Report](#How-to-2-get-report)
 * [Workflow and Expected Logistics](#logistics)
 * [Acknowledgments](#acknowledgments)
 
<a name="overview"></a>
## Overview

This interactive app serves as a tool to track and quantify the utility of university research slots on the 3T MRI, through creating diagrams based on the report from [LabArchives](https://sotnir-handbook.readthedocs.io/en/latest/projects-soton/mri-scanner.html).

This app was developed and maintained by Dr Yukai Zou (Y.Zou@soton.ac.uk).


<a name="How-to"></a>
## Quickstart

<a name="How-to-1-sign-in"></a>
### 1. Sign In

You should already obtain an account and have access to the research MRI booking system:

 - Link: https://scheduler.labarchives.com/

Instructions for how to create an account can be accessed [here](https://sotnir-handbook.readthedocs.io/en/latest/projects-soton/mri-scanner.html).

After signing in you may or may not view the calendar of research MRI slots immediately. If not, you will need to click on your name at the top right and select "Switch Organizations": 

<img src="img/switch-org.png" alt="Switch Organization" width="50%"/>

This will open up a window where you can choose which organization to view. Select “Southampton Research MRI”, and you should be able to view the calendar.

<a name="How-to-2-get-report"></a>
### 2. Get Report

To create new report, follow the steps below:

<img src="img/booking-system-quickstart.png" alt="Quickstart" width="100%"/>

<a name="logistics"></a>
## Workflow and Expected Logistics

<img src="img/scheduling-workflow.png" alt="Scheduling Workflow" width="100%"/>

Expected logistics are:

1. Constantly maintained calendar with most up-to-date availability
2. Minimal information
   - Title: De-identified participant ID (e.g. NENAH001, ROAR001)
   - Description: Hospital ID (e.g. Rhm1234567), participant initials (optional)
   - No PHI/PII. No participant full name, parent’s full name, DOB, etc.
   - Type of scan: University Research, etc. (for report and auditing purposes, see demo)
3. All new reservations pending approval
4. Unused slots are released immediately so other studies may use
   - Scanning team reserves the right to remove slots that participant details are not provided timely
   - **Communicate closely between research/scanning team**
5. (For rescheduling) In principle, research team proposes new reservation
   - Research team shall deletes the existing one and make a new reservation
   - Research team shall shall not update the approved reservation to a new date
   - **But scanning team could help. Communicate closely between scanning/research team**

<a name="acknowledgments"></a>
## Acknowledgments

<a href="https://www.southampton.ac.uk/"><img src="img/UoS-new-logo-590.png" alt="University of Southampton" width=250 hspace="20"/></a>
<a href="https://www.uhs.nhs.uk/health-professionals/medical-physics/mri-physics"><img src="img/uhsnhslogo.jpg" alt="UHS NHS Foundation Trust" width=350 hspace="20"/></a>

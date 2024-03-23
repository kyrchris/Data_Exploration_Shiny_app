# Data_Exploration_Shiny_app

## Introduction
This Shiny app is designed to facilitate data exploration by allowing users to upload their data files (in either XLSX or CSV format) and visualize the data distribution using interactive plots and summary statistics. The app provides options to select variables, apply filters, and generate visualizations based on user input.

## Getting Started
To use the Data Exploration shiny app, follow these steps:
1. Clone or download this repository to your local machine.
2. Ensure you have R and RStudio installed.
3. Install the required R packages mentioned in the `app.R` file.
4. Run the Shiny app by executing the `app.R` script.

## Usage
Upon running the app, you will be presented with a user interface consisting of the following components:

- **File Upload**: Upload your data file in XLSX or CSV format.
- **Variable Selection**: Choose a variable for visualization from the uploaded dataset. Only numeric variables will be available for selection.
- **Filter Controls**: If numeric variables are present, filter controls will be displayed to subset the data based on specific criteria.
- **Plot Output**: Visual representation (pie chart) of the selected variable's distribution.
- **Summary Table**: Summary statistics table displaying filtered data.

## Dependencies
Ensure you have the following R packages installed:
- shiny
- dplyr
- ggplot2
- shinyWidgets
- openxlsx
- shinyjs
- shinydashboard
- plotly

You can install these packages using the `install.packages()` function in R.

## Disclaimer
This project was created for the purpose of improving coding skills and expanding the portfolio of projects. It is intended for educational and demonstration purposes only.

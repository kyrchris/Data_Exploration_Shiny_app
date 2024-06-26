server <- function(input, output, session) {
  # Read uploaded CSV file
  data <- reactive({
    req(input$choice)
    req(input$sheet)
    req(input$file)
    
    
    if(input$choice == "xlsx"){
      
       read.xlsx(input$file$datapath, as.numeric(input$sheet)) } else{
      read.csv(input$file$datapath)
      }
    
    
  })
  
  output$select_sheet <-  renderUI({
    req(input$file)
    req(input$choice)
    if(input$choice == "xlsx"){
    wb <- loadWorkbook(input$file$datapath)
    number_of_sheets <-  1:length(sheets(wb))
      selectInput( inputId = "sheet", "Select sheet:", choices =number_of_sheets)
    } else {
      selectInput(inputId = "sheet", "CSVs have only one sheet",choices = 1)  
      
      }
  })
  
   
  # Dropdown list options for an x variable. This will select only the collumns with numeric values
  output$select_vars <- renderUI({
    req(input$sheet)
    selectInput("x_var", "Select a Variable to display on the graph:", choices = names(select_if(data(), is.numeric)))
  })
  
  # Display filter controls for numeric variables
  output$filter_vars <- renderUI({
    req(input$sheet)
    numeric_vars <- sapply(data(), is.numeric)
    if (sum(numeric_vars) > 0) {
      lapply(names(data())[numeric_vars], function(var) {
        sliderTextInput(inputId = paste0("slider",var), label = paste("Filter for ", var), 
                        choices = sort(unique(data()[[var]])))
        
      })
    }
  })
  

  # Generate plot based on user inputs
  
  
  output$plot <- renderPlot({
    req(input$x_var)
    req(input$sheet)
    # Count the frequency of each category
    data_counts <- table(data()[[input$x_var]])
    data_counts[is.na(data_counts)] <- 0 
    # Convert to data frame
    data_df <- as.data.frame(data_counts)
    colnames(data_df) <- c("Category", "Frequency")
    
    # Calculate percentages
    data_df$Percent <- round(100 * data_df$Frequency / sum(data_df$Frequency), 1)
    
    # Create pie chart using ggplot2
    ggplot(data_df, aes(x = "", y = Frequency, fill = Category)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0) +
      geom_text(aes(label = paste0(Category, " (", Percent, "%)")), position = position_stack(vjust = 0.5)) +
      theme_void() +
      labs(title = paste("Pie Chart of", input$x_var))
  })
  
  
  # Display summary statistics
  
  filtered_data <- reactive({    
    req(input$x_var)
    req(input$sheet)
    filtered_data <- data()
    filtered_data[is.na(filtered_data)] <- 0 
    # Apply filters based on slider values
    for (var in names(data()[sapply(data(), is.numeric)])) {
      if (is.numeric(filtered_data[[input$x_var]])) {
        slider_values <- input[[paste0("slider",var)]]
        filtered_data <- filtered_data[filtered_data[[var]] <= min(slider_values),] 
                                       
      }
   }
    
    filtered_data
  })
  
  observeEvent(input$x_var, {
    output$table <- renderDataTable({
      filtered_data()
    })
  })
    
}

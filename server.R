server <- function(input, output, session) {
  # conditionally rendering second nav_bar tabs (Production Activities, Region, and Size) depending on top tabs (Summary, By Product Type, Species)

  # conditional panel render if top nav_panels are "Summary" or "By Product Type"
  output$otherTabs <- renderUI({
    other_tabs_func()
  })

  # conditional panel render if top nav_panels is "Species"
  output$speciesTabs <- renderUI({
    species_tabs_func()
  })

  # on initial render, input$tab_bottom is NULL b/c hasnt been rendered yet, so asigning it a value
  observe({
    if (input$tab_top != "Species" && is.null(input$tab_bottom)) {
      updateTabsetPanel(
        session,
        "tab_bottom",
        selected = "Production Activities"
      )
    }
  })

  # observe({
  #   cat("tab_top:", input$tab_top, "\n")
  #   cat("tab_bottom:", input$tab_bottom, "\n")
  # })

  ##################### Reactive Summary DF's #########################

  # reactive data frame for Summary tab
  sum_plot_df <- reactive({
    req(input$tab_top == "Summary")
    req(input$tab_bottom)

    if (input$tab_top == "Summary") {
      if (input$tab_bottom == "Production Activities") {
        df <- sumdf_prac |>
          filter(
            metric %in% input$metricInput,
            statistic == input$statInput,
            variable %in% c(input$prodacInput, input$ospsInput)
          )
      } else if (input$tab_bottom == "Region") {
        df <- sumdf_reg |>
          filter(
            metric %in% input$metricInput,
            statistic == input$statInput,
            variable %in% input$regionInput,
            cs %in% input$pracs1Input
          )
      } else if (input$tab_bottom == "Processor Size/Type") {
        df <- sumdf_size |>
          filter(
            metric %in% input$metricInput,
            statistic == input$statInput,
            variable %in% input$sizeInput,
            cs %in% input$pracs2Input
          )
      }

      df # Return the filtered data frame
    }
  })

  ##################### Reactive Summary Plots #########################

  ##Plot for the summary tab
  output$sumplot <- renderPlot(
    {
      # # creating a validatement statement requiring valid inputs
      validate(
        need(sum_plot_df(), "No data available for these selected inputs"),
        need(
          nrow(sum_plot_df()) > 0,
          "No data available for these selected inputs"
        )
      )
      # run function to create plot with summary tab data
      plot_func(
        data = sum_plot_df(),
        lab = input$statInput,
        group = "variable",
        facet = "unit_lab"
      )
    }
  )
  ##################### Reactive By Product Type DF ########################### ----

  # reactive data frame for By Product Type tab
  prod_plot_df <- reactive({
    if (input$tab_top == "By Product Type") {
      if (input$tab_bottom == "Production Activities") {
        df <- proddf_prac |>
          filter(
            metric %in% input$metric2Input,
            type %in% input$protypeInput,
            statistic == input$stat2Input,
            variable %in% c(input$prodacInput, input$ospsInput)
          )
      } else if (input$tab_bottom == "Region") {
        df <- proddf_reg |>
          filter(
            metric %in% input$metric2Input,
            type %in% input$protypeInput,
            statistic == input$stat2Input,
            variable %in% input$regionInput,
            cs %in% input$pracs1Input
          )
      } else if (input$tab_bottom == "Processor Size/Type") {
        df <- proddf_size |>
          filter(
            metric %in% input$metric2Input,
            type %in% input$protypeInput,
            statistic == input$stat2Input,
            variable %in% input$sizeInput,
            cs %in% input$pracs2Input
          )
      }

      df # Return the filtered data frame
    }
  })

  ##################### Reactive By Product Type Plot ###########################

  ##Plot for the product tab
  output$productplot <- renderPlot(
    {
      validate(
        need(prod_plot_df(), "No data available for these selected inputs"),
        need(
          nrow(prod_plot_df()) > 0,
          "No data available for these selected inputs"
        )
      )

      # run function to create plot with summary tab data
      plot_func(
        data = prod_plot_df(),
        lab = input$stat2Input,
        group = "variable",
        facet = "unit_lab"
      )
    }
  )

  ##################### Reactive Species DF ########################### ----

  # reactive data frame for By Product Type tab
  specs_plot_df <- reactive({
    # req(input$tab_top == "Species") # Ensure input is present

    if (input$tab_top == "Species") {
      df <- proddf_prac |>
        filter(
          metric %in% input$metric3Input,
          variable %in% c(input$specsInput, input$osps2Input),
          statistic == input$stat3Input,
          type %in% input$protype2Input
        )
      return(df)
    }

    return(NULL) # If tab_bottom is not valid
  })

  ##################### Reactive Species tab Plot ###########################

  ##Plot for the species tab
  output$specsplot <- renderPlot(
    {
      validate(
        need(specs_plot_df(), "No data available for these selected inputs"),
        need(
          nrow(specs_plot_df()) > 0,
          "No data available for these selected inputs"
        )
      )

      # run function to create plot with summary tab data
      plot_func(
        data = specs_plot_df(),
        lab = input$stat3Input,
        group = "type",
        facet = "variable"
      )
    }
  )

  ##################### Reactive Data Table  #########################
  ##Creating the data table
  output$table <- DT::renderDataTable(
    {
      if (input$tab_top == "Summary") {
        df <- sum_plot_df()
      } else if (input$tab_top == "By Product Type") {
        df <- prod_plot_df()
      } else if (input$tab_top == "Species") {
        df <- specs_plot_df()
      }

      # Process the data using the helper function
      process_df(df)
    },
    options = list(
      scrollX = TRUE, # Enable horizontal scroll
      scrollY = "680px" # setting vertical scroll height
    )
  )

  ##################### Data Table Download #########################

  output$downloadData <- downloadHandler(
    filename = function() {
      paste("purchprod", input$tab_top, "data.csv", sep = "_")
    },
    content = function(file) {
      if (input$tab_top == "Summary") {
        write.csv(sum_plot_df(), file)
      } else if (input$tab_top == "By Product Type") {
        write.csv(prod_plot_df(), file)
      }
    }
  )
}

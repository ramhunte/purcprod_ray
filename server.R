server <- function(input, output, session) {
  # thematic::thematic_shiny()
  # bslib::bs_themer()

  output$dynamicTabs <- renderUI({
    dynatabs_func(tab_top_value = input$tab_top)
  })

  # tabs_ui <- reactiveVal(dynatabs_func("Summary")) # Set initial value
  #
  # observeEvent(input$tab_top, {
  #   if (input$tab_top == "Species") {
  #     tabs_ui(dynatabs_func("Species"))
  #   } else if (input$tab_top %in% c("Summary", "Product")) {
  #     # Only update if current UI isn't already the Summary/Product version
  #     if (!identical(tabs_ui(), dynatabs_func("Summary"))) {
  #       tabs_ui(dynatabs_func("Summary"))
  #     }
  #   }
  # })
  #
  # output$dynamicTabs <- renderUI({
  #   tabs_ui()
  # })

  ##################### Reactive Summary DF's #########################

  # reactive data frame for Summary tab
  sum_plot_df <- reactive({
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
        df <- sum_plot_df() |>
          select(-c(ylab, tab, unit_lab)) |>
          mutate(
            variance = round(variance, 2),
            q25 = round(q25, 2),
            q75 = round(q75, 2),
            value = round(value, 2),
            lower = round(lower, 2),
            upper = round(upper, 2)
          )
      } else if (input$tab_top %in% c("By Product Type")) {
        df <- prod_plot_df() |>
          select(-c(ylab, tab, unit_lab)) |>
          mutate(
            variance = round(variance, 2),
            q25 = round(q25, 2),
            q75 = round(q75, 2),
            value = round(value, 2),
            lower = round(lower, 2),
            upper = round(upper, 2)
          )
      } else if (input$tab_top %in% c("Species")) {
        df <- specs_plot_df() |>
          select(-c(ylab, tab, unit_lab)) |>
          mutate(
            variance = round(variance, 2),
            q25 = round(q25, 2),
            q75 = round(q75, 2),
            value = round(value, 2),
            lower = round(lower, 2),
            upper = round(upper, 2)
          )
      }
      df
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

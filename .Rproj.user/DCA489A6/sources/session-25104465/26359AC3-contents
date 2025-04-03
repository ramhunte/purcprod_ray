server <- function(input, output, session) {
  ##################### Reactive Summary DF's #########################

  # reactive data frame for Summary tab
  sum_plot_df <- reactive({
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
          cs %in% input$pracs1Input
        )
    }

    df # Return the filtered data frame
  })

  ##################### Reactive Summary Plots #########################

  ##Plot for the summary tab
  output$sumplot <- renderPlot(
    {
      # return nothing if plot is Null
      req(sum_plot_df())

      # run function to create plot with summary tab data
      plot_func(data = sum_plot_df(), lab = input$statInput)
    },
    height = 800,
    width = 1100
  )

  ##################### Reactive By Product Type DF ########################### ----

  # reactive data frame for By Product Type tab
  prod_plot_df <- reactive({
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
          cs %in% input$pracs1Input
        )
    }

    df # Return the filtered data frame
  })

  ##################### Reactive By Product Type Plot ###########################

  ##Plot for the product tab
  output$productplot <- renderPlot(
    {
      # return nothing if plot is Null
      req(prod_plot_df())

      # run function to create plot with summary tab data
      plot_func(data = prod_plot_df(), lab = input$stat2Input)
    },
    height = 800,
    width = 1100
  )
  ##################### Reactive Data Table  #########################
  ##Creating the data table
  output$table <- DT::renderDataTable(
    {
      if (input$tab_top == "Summary") {
        df <- sum_plot_df() |>
          select(-c(ylab, tab)) |>
          mutate(
            variance = round(variance, 2),
            q25 = round(q25, 2),
            q75 = round(q75, 2),
            value = round(value, 2),
            lower = round(lower, 2),
            upper = round(upper, 2)
          )
      } else if (input$tab_top == "By Product Type") {
        df <- prod_plot_df() |>
          select(-c(ylab, tab)) |>
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
    height = 800,
    width = 1100
  )
}

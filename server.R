server <- function(input, output, session) {
  # thematic::thematic_shiny()
  # bslib::bs_themer()

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
        facet = "unit_lab"
      )
    },
    height = plot_height,
    width = plot_width
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
        facet = "unit_lab"
      )
    },
    height = plot_height,
    width = plot_width
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
      } else if (input$tab_top == "By Product Type") {
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

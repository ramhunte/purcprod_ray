# UI creating a fluidPage
shinyUI(
  fluidPage(
    titlePanel("FISHEyE: Shoreside purchase and production mini-app"),

    # page layout
    sidebarLayout(
      ########################### Top tabSet ######################################
      #################### (Summary; By Product Type) #############################

      # START sidbarPanel
      sidebarPanel(
        # START tabsetPanel
        tabsetPanel(
          # START summary tabPanel
          tabPanel(
            "Summary",
            # Metric
            checkboxGroupInput(
              inputId = "metricInput",
              label = "Metric",
              choices = sort(unique(sumdf$metric)),
              selected = 'Purchase weight'
            ),
            # Statistic
            radioButtons(
              inputId = "statInput",
              label = "Statistic",
              choices = c("Mean", "Median", "Total"),
              selected = "Median"
            )
          ), # END Summary tabPanel

          # START Product Type tabPanel
          tabPanel(
            "By Product Type",
            # Metric
            selectInput(
              inputId = 'metric2Input',
              label = "Select a metric",
              choices = c(
                'Production value',
                'Production price (per lb)',
                'Production weight'
              ),
              selectize = F
            ),
            # Product Type
            checkboxGroupInput(
              inputId = "protypeInput",
              label = "Product types",
              choices = unique(proddf$type),
              selected = 'Canned'
            ),
            # Statistic
            radioButtons(
              inputId = "stat2Input",
              label = "Statistic",
              choices = c("Mean", "Median", "Total"),
              selected = "Median"
            )
          ), #END Product Type tabPanel
          id = "tab_top",
          type = c("tabs")
        ), #END tabsetPanel

        ############################### Bottom tabSet ###################################
        ############# (Production Activities; Region; Processor size/type) ##############

        # START tabsetPanel
        tabsetPanel(
          # START Production Activities tabPanel
          tabPanel(
            "Production Activities",
            checkboxGroupInput(
              inputId = "prodacInput",
              label = "",
              choices = prodac_choices,
              selected = "All production"
            ),
            dropdownButton(
              inputId = "dropdown",
              label = "Other Species",
              circle = FALSE,
              checkboxGroupInput(
                "ospsInput",
                "",
                choices = osps_choices
              )
            )
          ), # END Production Activities tabPanel

          # START Region tabPanel
          tabPanel(
            "Region",
            checkboxGroupInput(
              inputId = "regionInput",
              label = "",
              choices = reg_choices,
              selected = "California"
            ),
            # Production Activities (Region)
            radioButtons(
              inputId = "pracs1Input",
              label = "Production activities",
              choices = pracs_choices,
              selected = "All production"
            )
          ), # END Region tabPanel

          # START Processor size/type tabPanel
          tabPanel(
            "Processor Size/Type",
            checkboxGroupInput(
              inputId = "sizeInput",
              label = "",
              choices = size_choices,
              selected = "Small"
            ),
            radioButtons(
              # Production Actives (Processor type/size)
              inputId = "pracs2Input",
              label = "Production activities",
              choices = pracs_choices,
              selected = "All production"
            )
          ), # END Processor size/type tabPanel
          id = "tab_bottom",
          type = c("tabs")
        ) # END tabsetPanel
      ), # END sidebarPanel

      ########################### mainPanel #######################################

      # START mainPanel
      mainPanel(
        # START tabsetPanel
        tabsetPanel(
          type = "tabs",
          # START plot tabPanel
          tabPanel(
            "Plot",
            conditionalPanel(
              condition = "input.tab_top == 'Summary'",
              plotOutput("sumplot")
            ),
            conditionalPanel(
              condition = "input.tab_top == 'By Product Type'",
              plotOutput("productplot")
            )
          ), # END plot tabPanel

          # START table tabPanel
          tabPanel("Table", DT::dataTableOutput("table")) # END  table tabPanel
        ) # END tabsetPanel
      ) # END mainPanel
    ) # END sidebarLayout
  ) # END fluidPage
) # END UI

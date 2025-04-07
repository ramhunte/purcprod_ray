library(shiny)
library(bslib)

# UI creating a fluidPage
shinyUI(
  # START fluid_page
  page_fluid(
    # calling themes for the page elements
    theme = bs_theme(
      bootswatch = "materia",
      primary = "lightblue",
      bg = "#005377",
      fg = "white",
      secondary = "lightblue",
      # success = "#009E73",
    ),

    # START page_navbar
    page_navbar(
      id = "navbar",
      title = "Purchase Production App",
      # calling css file for more styles
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
      ),

      # START "Explore the Data" tab
      nav_panel(
        "Explore the Data",
        # START sidebarLayout
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
                  selected = unique(sumdf$metric)
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
                  selected = unique(proddf$type)
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
                  inputId = "osDropdown",
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
            ), # END tabsetPanel

            # Download data button
            downloadButton(
              "downloadData",
              "Download",
              class = "btn-secondary custom-download"
            )
          ), # END sidebarPanel

          ########################### mainPanel #######################################

          # START mainPanel
          mainPanel(
            style = page_height,
            # START tabsetPanel
            # tabsetPanel(
            navset_card_pill(
              height = 880, # height of the card that holds the plots
              full_screen = TRUE,
              # type = "tabs",
              # START plot tabPanel
              # tabPanel(
              nav_panel(
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
              # tabPanel(
              nav_panel(
                height = 880,
                "Table",
                DT::dataTableOutput("table")
              ) # END  table tabPanel
            ) # END tabsetPanel
          ) # END mainPanel
        ) # END sidebarLayout
      ), # END "Explore the Data" tab

      # tabPanel 2
      nav_panel(
        "Information Page",
        style = page_height,
        fluidRow(
          # use columns to create white space on sides
          column(1),
          column(10, includeMarkdown("text/info.md")),
          column(1)
        ),
      ), #END tabPanel 2

      #tabPanel 3
      nav_panel(
        "Bulletin Board",
        style = page_height,
      ), # END tabPanel 3

      #tabPanel 4
      nav_panel(
        "Contact Us",
        style = page_height,
        fluidRow(
          # use columns to create white space on sides
          column(1),
          column(10, includeMarkdown("text/contact.md")),
          column(1)
        ), # END intro text fluidRow
      ), # END tabPanel 4

      footer = footer() # END footer
    ) # END page_navbar
  ) # END fluid_page
) # END UI

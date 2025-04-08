# UI creating a fluidPage
shinyUI(
  # # START fluid_page
  # page_fluid(
  page_navbar(
    # calling themes for the page elements
    theme = bs_theme(
      bootswatch = "materia",
      primary = "#00797F",
      fg = "#001743",
      bg = "#E9F3F6",
      secondary = "#FFFFFF",
    ),

    # START page_navbar
    # page_navbar(
    id = "navbar",
    title = "Purchase Production App",

    # adding NOAA logo
    tags$head(
      tags$script(HTML(
        '$(document).ready(function() {
        $(".navbar .container-fluid")
          .css({"position": "relative"})
          .append("<img id=\'myImage\' src=\'noaa_header.png\'>");
      });'
      )),
      tags$style(HTML(
        '
      .navbar {
        min-height: 56px !important;
      }

      #myImage {
        position: absolute;
        right: 10px;
        top: -10px;
        height: 75px;
      }

      @media (max-width: 992px) {
        #myImage {
          position: fixed;
          right: 10%;
          top: 0.5%;
        }
      }
      '
      ))
    ),

    # calling css file for more styles
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),

    # START "Explore the Data" tab
    nav_panel(
      "Explore the Data",

      # START sidebarLayout
      page_sidebar(
        # style = "min-height: 80vh;",
        ########################### Top tabSet ######################################
        #################### (Summary; By Product Type) #############################

        # START sidbarPanel
        sidebar = sidebar(
          width = 500,
          # START tabsetPanel
          navset_card_pill(
            # START "Summary" tabPanel
            nav_panel(
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

            # START "Product Type" tabPanel
            nav_panel(
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
            id = "tab_top"
            # type = c("tabs")
          ), #END tabsetPanel

          ############################### Bottom tabSet ###################################
          ############# (Production Activities; Region; Processor size/type) ##############

          # START tabsetPanel
          navset_card_pill(
            # START "Production Activities" tabPanel
            nav_panel(
              "Production Activities",
              checkboxGroupInput(
                inputId = "prodacInput",
                label = "",
                choices = prodac_choices,
                selected = "All production"
              ),
              # Other Species
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
            ), # END "Production Activities" tabPanel

            # START Region tabPanel
            nav_panel(
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

            # START "Processor Size/Type" tabPanel
            nav_panel(
              "Processor Size/Type",
              checkboxGroupInput(
                inputId = "sizeInput",
                label = "",
                choices = size_choices,
                selected = "Small"
              ),
              # Production Actives (Processor type/size)
              radioButtons(
                inputId = "pracs2Input",
                label = "Production activities",
                choices = pracs_choices,
                selected = "All production"
              )
            ), # END Processor size/type tabPanel
            id = "tab_bottom"
            # type = c("tabs")
          ), # END tabsetPanel

          # downloadButton
          downloadButton(
            "downloadData",
            "Download",
            class = "btn-secondary custom-download"
          )
        ), # END sidebarPanel

        ########################### mainPanel #######################################

        # START mainPanel
        navset_card_pill(
          # START "Plot" nav_panel
          nav_panel(
            title = "Plot",
            conditionalPanel(
              condition = "input.tab_top == 'Summary'",
              shinycssloaders::withSpinner(
                # adding a cool loader
                plotOutput("sumplot", width = "100%", height = "620px")
              )
            ),
            conditionalPanel(
              condition = "input.tab_top == 'By Product Type'",
              shinycssloaders::withSpinner(
                # adding a cool loader
                plotOutput("productplot", width = "100%", height = "620px")
              )
            )
          ), # END Plot nav_panel

          # START "Table" nav_panel
          nav_panel(
            "Table",
            shinycssloaders::withSpinner(
              # adding a cool loader
              dataTableOutput("table")
            )
          ) # END  "Table" nav_panel
        ) # END navset_card_pill
      ) # END mainPanel
    ), # END "Explore the Data" tab

    # START "Information" nav_panel ----
    nav_panel(
      "Information Page",
      # style = page_height,
      fluidRow(
        # use columns to create white space on sides
        column(1),
        column(10, includeMarkdown("text/info.md")),
        column(1)
      ),
    ), # END "Information" nav_panel

    # START "Bulletin Board" nav_panel
    nav_panel(
      "Bulletin Board",
      # style = page_height,
    ), # END "Bulletin Board" nav_panel

    # START "Contact" Us nav_panel
    nav_panel(
      "Contact Us",
      # style = page_height,
      fluidRow(
        # use columns to create white space on sides
        column(1),
        column(10, includeMarkdown("text/contact.md")),
        column(1)
      )
    ), # "Contact" Us nav_panel

    footer = footer() # END footer
  ) # END page_navbar
) # END UI

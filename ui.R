# UI creating a fluidPage
shinyUI(
  # # START fluid_page
  # page_fluid(
  page_navbar(
    # calling themes for the page elements
    theme = bs_theme(
      bootswatch = "materia",
      secondary = "#5EB6D9",
      fg = "#001743",
      bg = "#C2D9E3",
      # "#00797F",
      primary = "#00559B",

      # "#00559B",
      'navbar-bg' = "#001743"
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
              class = "custom-card",
              # Metric
              metric_func1(inputID = "metricInput"),
              # Statistic
              stat_func(inputID = "statInput")
            ), # END Summary tabPanel

            # START "Product Type" tabPanel
            nav_panel(
              "By Product Type",
              class = "custom-card",
              # Metric
              metric_func2(inputID = "metric2Input"),

              # Product Type
              prodtype_func(inputID = "protypeInput"),

              # Statistic
              stat_func(inputID = "stat2Input")
            ), #END Product Type tabPanel

            # START Species nav_panel
            nav_panel(
              "Species",
              class = "custom-card",
              # Metric
              metric_func2(inputID = "metric3Input"),

              # Species
              specs_func(inputID = "specsInput"),

              # Other Species

              os_func(inputID1 = "os2Dropdown", inputID2 = "osps2Input"),

              stat_func(inputID = "stat3Input")
            ), # END Species nav_panel

            id = "tab_top"
          ), #END tabsetPanel

          ############################### Bottom tabSet ###################################
          ############# (Production Activities; Region; Processor size/type) ##############

          # START tabsetPanel

          # uiOutput("dynamicTabs"),

          conditionalPanel(
            condition = "input.tab_top != 'Species'",
            uiOutput("otherTabs")
          ),

          conditionalPanel(
            condition = "input.tab_top == 'Species'",
            uiOutput("speciesTabs")
          ),

          # downloadButton
          down_func(outputID = "downloadData")
        ), # END sidebarPanel

        ########################### mainPanel #######################################

        # START mainPanel
        navset_card_pill(
          # START "Plot" nav_panel
          nav_panel(
            title = "Plot",
            class = "custom-card",
            conditionalPanel(
              condition = "input.tab_top == 'Summary'",
              shinycssloaders::withSpinner(
                # adding a cool loader
                plotOutput("sumplot", width = "100%", height = "575px")
              )
            ),
            conditionalPanel(
              condition = "input.tab_top == 'By Product Type'",
              shinycssloaders::withSpinner(
                # adding a cool loader
                plotOutput("productplot", width = "100%", height = "575px")
              )
            ),

            conditionalPanel(
              condition = "input.tab_top == 'Species'",
              shinycssloaders::withSpinner(
                # adding a cool loader
                plotOutput("specsplot", width = "100%", height = "575px")
              )
            )
          ), # END Plot nav_panel

          # START "Table" nav_panel
          nav_panel(
            "Table",
            class = "custom-card",
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

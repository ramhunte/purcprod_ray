# metric function #1
metric_func1 <- function(inputID) {
  checkboxGroupInput(
    inputId = inputID,
    label = "Metric",
    choices = sort(unique(sumdf$metric)),
    selected = unique(sumdf$metric)
  )
}

# metric function #2

metric_func2 <- function(inputID) {
  selectInput(
    inputId = inputID,
    label = "Select a metric",
    choices = c(
      'Production value',
      'Production price (per lb)',
      'Production weight'
    ),
    selectize = F
  )
}

# statistic function
stat_func <- function(inputID) {
  radioButtons(
    inputId = inputID,
    label = "Statistic",
    choices = c("Mean", "Median", "Total"),
    selected = "Median"
  )
}

# Product Type function
prodtype_func <- function(inputID) {
  checkboxGroupInput(
    inputId = inputID,
    label = "Product types",
    choices = unique(proddf$type),
    selected = unique(proddf$type)
  )
}

# Species
specs_func <- function(inputID) {
  checkboxGroupInput(
    inputId = inputID,
    label = "Species",
    choices = c(
      "All production",
      "Groundfish production",
      "Pacific whiting",
      "Non-whiting groundfish",
      "Sablefish",
      "Rockfish",
      "Dover sole",
      "Petrale sole",
      "Thornyheads",
      "Other groundfish species"
    ),
    selected = "All production"
  )
}

# other species

os_func <- function(inputID1, inputID2) {
  dropdownButton(
    inputId = inputID1,
    label = "Other Species",
    circle = FALSE,
    checkboxGroupInput(
      inputId = inputID2,
      label = "",
      choices = c(
        "Other species production",
        "Crab",
        "Shrimp",
        "Salmon",
        "Tuna",
        "Coastal pelagics",
        "Other shellfish",
        "Other species"
      )
    )
  )
}

# region function

reg_func <- function(inputID) {
  checkboxGroupInput(
    inputId = inputID,
    label = "",
    choices = c(
      'California',
      'Washington and Oregon'
    ),
    selected = "California"
  )
}

# production activities function
pracs_func <- function(inputID) {
  radioButtons(
    inputId = inputID,
    label = "Production activities",
    choices = c(
      'All production',
      'Groundfish production',
      'Other species production'
    ),
    selected = "All production"
  )
}

# processor size function
size_func <- function(inputID) {
  checkboxGroupInput(
    inputId = inputID,
    label = "",
    choices = c(
      'Small',
      'Medium',
      'Large',
      'Non-processor'
    ),
    selected = "Small"
  )
}

# download button

down_func <- function(outputID) {
  downloadButton(
    outputId = outputID,
    label = "Download",
    class = "btn-secondary custom-download"
  )
}

# Dynamic bottom tabs func

species_tabs_func <- function() {
  navset_card_pill(
    nav_panel(
      "Product Type",
      class = "custom-card",
      prodtype_func("protype2Input")
    ),
    id = "tab_bottom"
  )
}

other_tabs_func <- function() {
  navset_card_pill(
    nav_panel(
      "Production Activities",
      class = "custom-card",
      specs_func(inputID = "prodacInput"),
      os_func(inputID1 = "osDropdown", inputID2 = "ospsInput")
    ),
    nav_panel(
      "Region",
      class = "custom-card",
      reg_func(inputID = "regionInput"),
      pracs_func(inputID = "pracs1Input")
    ),
    nav_panel(
      "Processor Size/Type",
      class = "custom-card",
      size_func(inputID = "sizeInput"),
      pracs_func(inputID = "pracs2Input")
    ),
    id = "tab_bottom"
  )
}

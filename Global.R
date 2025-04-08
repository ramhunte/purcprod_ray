library(shiny)
library(shinyjs)
library(shinyBS)
library(bslib)
library(thematic)
library(stringr)
library(ggplot2)
library(grid)
library(dplyr)
library(scales)
library(DT)
library(shinyWidgets)
library(shinycssloaders)

# read in raw data
raw_purcprod <- readRDS("data/mini_purcprod.RDS")

# reading in data cleaning script
source("scripts/data_cleaning.R")

# reading in plotting script
source("scripts/plotting.R")

# reading in footer and header script
source("scripts/head_foot.R")

# choices for UI widgets

# Choices for Product Activities (prodacInput)
prodac_choices <- c(
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
)

# choices for other species (ospsInput)
osps_choices <- c(
  "Other species production",
  "Crab",
  "Shrimp",
  "Salmon",
  "Tuna",
  "Coastal pelagics",
  "Other shellfish",
  "Other species"
)

# choices for Regions (regionInputs)
reg_choices <- c(
  'California',
  'Washington and Oregon'
)

# choices for Sizes (sizeInput)
size_choices <- c(
  'Small',
  'Medium',
  'Large',
  'Non-processor'
)

# choices fo production activities (pracs1Input & pracs2Input)
pracs_choices <- c(
  'All production',
  'Groundfish production',
  'Other species production'
)

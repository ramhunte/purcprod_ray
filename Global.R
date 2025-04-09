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

# raw data
raw_purcprod <- readRDS("data/mini_purcprod.RDS")

# data cleaning script
source("scripts/data_cleaning.R")

# UI functions
source("scripts/ui_funcs.R")

# plotting script
source("scripts/plotting.R")

# footer and header script
source("scripts/head_foot.R")

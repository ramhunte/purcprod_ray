# Data cleaning

########################### Cleaning Raw data #################################

clean_purcprod <- raw_purcprod |>
  # making all variable names lowercase
  janitor::clean_names() |>
  # reducing values by units
  mutate(
    variance = case_when(
      unit == '' ~ variance,
      unit == 'thousands' ~ variance / 1e3,
      unit == 'millions' ~ variance / 1e6,
      unit == 'billions' ~ variance / 1e9,
      T ~ -999
    ),
    q25 = case_when(
      unit == '' ~ q25,
      unit == 'thousands' ~ q25 / 1e3,
      unit == 'millions' ~ q25 / 1e6,
      unit == 'billions' ~ q25 / 1e9,
      T ~ -999
    ),
    q75 = case_when(
      unit == '' ~ q75,
      unit == 'thousands' ~ q75 / 1e3,
      unit == 'millions' ~ q75 / 1e6,
      unit == 'billions' ~ q75 / 1e9,
      T ~ -999
    ),
    value = case_when(
      unit == '' ~ value,
      unit == 'thousands' ~ value / 1e3,
      unit == 'millions' ~ value / 1e6,
      unit == 'billions' ~ value / 1e9,
      T ~ -999
    ),
    upper = case_when(
      statistic == 'Mean' ~ value + variance,
      statistic == 'Median' ~ q75,
      statistic == 'Total' ~ value
    ),
    lower = case_when(
      statistic == 'Mean' ~ value - variance,
      statistic == 'Median' ~ q25,
      statistic == 'Total' ~ value
    )
  ) %>%
  data.frame()

# Data formatting for table#####
data_table <- clean_purcprod %>%
  mutate(
    variance = round(variance, 2),
    q25 = round(q25, 2),
    q75 = round(q75, 2),
    value = round(value, 2)
  ) %>%
  data.frame()


####################### Cleaning "Summary" tab data ###########################

# subsetting data for the "Summary" tab
sumdf <- filter(clean_purcprod, tab == 'Summary')

# subsetting data for the "Production Activities" subtab under "Summary"
sumdf_prac <- sumdf |>
  filter(cs == "")

# subsetting data for the "Region" subtab under "Summary"
sumdf_reg <- sumdf |>
  filter(cs != "", variable %in% c("California", "Washington and Oregon"))

# subsetting data for the "Processor size/type" subtab under "Summary"
sumdf_size <- sumdf |>
  filter(cs != "", variable %in% c("Small", "Medium", "Large", "Non-processor"))


####################### Cleaning "By Product Type" tab data ###########################

# subsetting data for the "By Product Type" tab
proddf <- filter(clean_purcprod, tab == 'Product') |> # production tab data
  tidyr::separate(
    metric,
    into = c("type", "metric"),
    sep = " ",
    extra = "merge"
  ) |>
  mutate(metric = substr(metric, 2, nchar(metric) - 1))

# subsetting data for the "Production Activities" subtab under "By Product Type"
proddf_prac <- proddf |>
  filter(cs == "")

# subsetting data for the "Region" subtab under "By Product Type"
proddf_reg <- proddf |>
  filter(cs != "", variable %in% c("California", "Washington and Oregon"))

# subsetting data for the "Processor size/type" subtab under "By Product Type"
proddf_size <- proddf |>
  filter(cs != "", variable %in% c("Small", "Medium", "Large", "Non-processor"))

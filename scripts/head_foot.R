# setting the page height for the footer and header to be used in the UI
page_height <- "min-height: 125vh;"

# custom function to write a footer
footer <- function() {
  tags$footer(
    class = "footer text-center",
    style = "
      position: relative;
      bottom: 0;
      width: 100%;
      text-align: center;
      padding: 10px;",

    HTML(paste0(
      # NWFSC
      "<a href='https://www.fisheries.noaa.gov/region/west-coast/northwest-science' target='_blank'>NWFSC</a> - ",
      # NOAA Fisheries
      "<a href='https://www.fisheries.noaa.gov/' target='_blank'>NOAA Fisheries</a> - ",
      # NOAA
      "<a href='https://www.noaa.gov/' target='_blank'>NOAA</a> - ",
      # Copyright policy
      "<a href='https://www.fisheries.noaa.gov/region/west-coast/northwest-science' target='_blank'>Copyright policy</a> - ",
      # Disclaimer
      "<a href='https://www.fisheries.noaa.gov/region/west-coast/northwest-science' target='_blank'>Disclaimer</a> - ",
      # Feedback
      "<a href='https://www.fisheries.noaa.gov/staff-directory/northwest-fisheries-science-center-staff-directory' target='_blank'>Feedback</a> - ",
      # Customer satisfaction survey
      "<a href='https://www.fisheries.noaa.gov/staff-directory/northwest-fisheries-science-center-staff-directory' target='_blank'>Customer satisfaction survey</a> - ",
      # NOAA privacy policy
      "<a href='https://www.fisheries.noaa.gov/about-us/privacy-policy' target='_blank'>NOAA privacy policy </a> - ",
      # NOAA information quality
      "<a href='https://www.noaa.gov/information-technology' target='_blank'>NOAA information quality </a> - ",
      "<br>",
      format(Sys.Date(), "%Y")
    ))
  )
}

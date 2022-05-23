# load required packages -------------
source("R/required_packages.R")

# paths -----------------
integrity_data <- "input/artf_data_for_dashboard/ESMW462021-192022.xlsx" # please update the dataname as the one in your local directory
atr_data_path <- "output/client_datasets/"
output_path <- "output/comparative_analysis/"
date <- Sys.Date()

# Read data (ATR) -----------------
convert_to_na <- c("9999", "8888", "7777", "(choice label unavailable)")
## ATR
fi_atr <- readxl::read_excel(glue::glue("{atr_data_path}FI_DATA_Merged.xlsx"), sheet = "FI_PRICES_DATA", na = convert_to_na, guess_max = 100000)
labour_atr <- nfi_atr <- readxl::read_excel(glue::glue("{atr_data_path}NFI_AND_SERVICES_DATA_Merged.xlsx"), sheet = "NFI_PRICE_DATA", na = convert_to_na, guess_max = 100000)
fi_tax_atr <- readxl::read_excel(glue::glue("{atr_data_path}FI_DATA_Merged.xlsx"), sheet = "FI_TAX_BARTER", na = convert_to_na, guess_max = 100000)
nfi_tax_atr <- readxl::read_excel(glue::glue("{atr_data_path}NFI_AND_SERVICES_DATA_Merged.xlsx"), sheet = "NFI_TAX_BARTER", na = convert_to_na, guess_max = 100000)
telecom_atr <- readxl::read_excel(glue::glue("{atr_data_path}TELECOM_DATA_Merged.xlsx"), na = convert_to_na, guess_max = 100000)
ime_atr <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged.xlsx"), sheet = "CURRENCY_RATE", na = convert_to_na, guess_max = 100000)
hawala_atr <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged.xlsx"), sheet = "HAWALA_MAIN", na = convert_to_na, guess_max = 100000)
bank_atr <- readxl::read_excel(glue::glue("{atr_data_path}BANK_DATA_Merged.xlsx"), sheet = "BANK_BRANCH_LEVEL", na = convert_to_na, guess_max = 100000)
bank_respondents_atr <- readxl::read_excel(glue::glue("{atr_data_path}BANK_DATA_Merged.xlsx"), sheet = "BANK_RESPONDENT_LEVEL", na = convert_to_na, guess_max = 100000)
border_traffice_count_atr <- readxl::read_excel(glue::glue("{atr_data_path}BORDER_TRAFFIC_COUNT_DATA_Merged.xlsx"), sheet = "BORDER_TRAFFIC_COUNT", na = convert_to_na, guess_max = 100000)
border_driver_survey <- readxl::read_excel(glue::glue("{atr_data_path}BORDER_DRIVER_SURVEY_DATA_Merged.xlsx"), na = convert_to_na, guess_max = 100000)

## Integrity
fi_integrity <- readxl::read_excel(integrity_data, sheet = "MSFOOD", na = convert_to_na, guess_max = 100000)
nfi_integrity <- readxl::read_excel(integrity_data, sheet = "MSNONFOOD", na = convert_to_na, guess_max = 100000)

# Comparative analysis -----------------
source("R/comparative analysis/1_FI price and availability_comparative analysis.R") # FI price and availability
source("R/comparative analysis/2_NFI price and availability.R") # NFI price and availability

# export results into "output/comparative_analysis/" folder
writexl::write_xlsx(diff_in_FI_prices, glue::glue("{output_path}FI price comparison_{date}.xlsx"), format_headers = F) # FI price
writexl::write_xlsx(diff_in_FI_availability, glue::glue("{output_path}FI availability comparison_{date}.xlsx"), format_headers = F) # FI availability
writexl::write_xlsx(diff_in_NFI_prices, glue::glue("{output_path}NFI price comparison_{date}.xlsx"), format_headers = T) # NFI price
writexl::write_xlsx(diff_in_NFI_availability, glue::glue("{output_path}NFI availability comparison_{date}.xlsx"), format_headers = T) # NFI availability


# load required packages -------------
source("R/required_packages.R")

# paths -----------------
atr_data_path <- "output/client_datasets/"
output_path <- "output/analysis/"
date <- Sys.Date()

# Read data -----------------
convert_to_na <- c("9999", "8888", "7777", "(choice label unavailable)")
fi_atr <- readxl::read_excel(glue::glue("{atr_data_path}FI_DATA_Merged.xlsx"), sheet = "FI_PRICES_DATA", na = convert_to_na, guess_max = 100000)
labour_atr <- nfi_atr <- readxl::read_excel(glue::glue("{atr_data_path}NFI_AND_SERVICES_DATA_Merged.xlsx"), sheet = "NFI_PRICE_DATA", na = convert_to_na, guess_max = 100000)
fi_tax_atr <- readxl::read_excel(glue::glue("{atr_data_path}FI_DATA_Merged.xlsx"), sheet = "FI_TAX_BARTER", na = convert_to_na, guess_max = 100000)
nfi_tax_atr <- readxl::read_excel(glue::glue("{atr_data_path}NFI_AND_SERVICES_DATA_Merged.xlsx"), sheet = "NFI_TAX_BARTER", na = convert_to_na, guess_max = 100000)
telecom_atr <- readxl::read_excel(glue::glue("{atr_data_path}TELECOM_DATA_Merged.xlsx"), na = convert_to_na, guess_max = 100000)
ime_atr <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged.xlsx"), sheet = "CURRENCY_RATE", na = convert_to_na, guess_max = 100000)
hawala_atr <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged.xlsx"), sheet = "HAWALA_MAIN", na = convert_to_na, guess_max = 100000)
bank_atr <- readxl::read_excel(glue::glue("{atr_data_path}BANK_DATA_Merged.xlsx"), sheet = "BANK_BRANCH_LEVEL", na = convert_to_na, guess_max = 100000)
bank_respondents_atr <- readxl::read_excel(glue::glue("{atr_data_path}BANK_DATA_Merged.xlsx"), sheet = "BANK_RESPONDENT_LEVEL", na = convert_to_na, guess_max = 100000)

# Analysis (ATR data) -----------------
source("R/analysis/1_FI price and availability.R") # FI price and availability
source("R/analysis/2_NFI price and availability.R") # NFI price and availability 
source("R/analysis/3_Taxes and cashless transactions.R") # FI/NFI taxes and cashless transaction
source("R/analysis/4_Labour wage and no. of available days.R") # labour wage and no. of available days
# TODO: Bank operationality
source("R/analysis/5_Bank functionality.R") # bank functionality 
source("R/analysis/6_Bank withdrawal limit.R") # bank withdrawal limit
source("R/analysis/7_Bank withdraw ability and waiting time.R") # bank withdraw ability and waiting time
# TODO: MMO
source("R/analysis/8_IME exchange rate and availability.R") # IME exchange rate and availability of foreing currency
source("R/analysis/9_Hawala changes in transactions, common destination, ability to transfer money.R") # IME Hawala operators (domestic and international)
# TODO: IME exchange rate, availability, and hawal operators (version 2)
# TODO: Border Crossing

# export results into "output/analysis/" folder
writexl::write_xlsx(FI_prices_list, glue::glue("{output_path}FI prices - {date}.xlsx")) # FI price
writexl::write_xlsx(FI_availability_list, glue::glue("{output_path}FI availability - {date}.xlsx")) # FI availability 
writexl::write_xlsx(NFI_prices_list, glue::glue("{output_path}NFI price - {date}.xlsx")) # NFI price
writexl::write_xlsx(NFI_availability_list, glue::glue("{output_path}NFI availability - {date}.xlsx")) # NFI availability 
writexl::write_xlsx(tax_list, glue::glue("{output_path}Taxes - {date}.xlsx"))  # FI and NFI taxes
writexl::write_xlsx(cashless_transaction_list, glue::glue("{output_path}Cashless transactions - {date}.xlsx"))  # FI and NFI cashless transaction
writexl::write_xlsx(labour_wage_list, glue::glue("{output_path}Labour wage - {date}.xlsx"))  # labour wage
writexl::write_xlsx(labour_availability_list, glue::glue("{output_path}Labour availability - {date}.xlsx"))  # labour no. of available days
writexl::write_xlsx(bank_functionality_list, glue::glue("{output_path}Bank functionality - {date}.xlsx")) # bank functionality 
writexl::write_xlsx(withdrawal_limit_list, glue::glue("{output_path}Bank withdrawal limit - {date}.xlsx"))  # bank withdrawal limit
writexl::write_xlsx(withdraw_ability_and_waiting_time_list, glue::glue("{output_path}Bank withdraw ability and waiting time - {date}.xlsx"))  # bank withdraw ability and waiting time
writexl::write_xlsx(ime_availability_list, glue::glue("{output_path}IME availability - {date}.xlsx")) # IME availability of foreing currency
writexl::write_xlsx(ime_rate_list, glue::glue("{output_path}IME rate - {date}.xlsx")) # IME exchange rate
writexl::write_xlsx(transaction_changes_atr, glue::glue("{output_path}Hawala_changes in transactions - {date}.xlsx")) # IME changes in domestic and international transactions
writexl::write_xlsx(common_destination_atr, glue::glue("{output_path}Hawala_most common destination - {date}.xlsx")) # IME common domestic and interntional destinations
writexl::write_xlsx(transfer_money_atr, glue::glue("{output_path}Hawala_ability to transfer money - {date}.xlsx")) # IME ability to transfer money (domestic & international)




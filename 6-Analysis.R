# load required packages -------------
source("R/required_packages.R")

# paths -----------------
atr_data_path <- "output/client_datasets/"
output_path <- "output/analysis/"
date <- Sys.Date()
convert_to_na <- c("9999", "8888", "7777", "(choice label unavailable)", "NA")

# Read data -----------------
fi_atr <- readxl::read_excel(glue::glue("{atr_data_path}FI_DATA_Merged.xlsx"), sheet = "FI_PRICES_DATA", na = convert_to_na, guess_max = 100000)
labour_atr <- nfi_atr <- readxl::read_excel(glue::glue("{atr_data_path}NFI_AND_SERVICES_DATA_Merged.xlsx"), sheet = "NFI_PRICE_DATA", na = convert_to_na, guess_max = 100000)
fi_tax_atr <- readxl::read_excel(glue::glue("{atr_data_path}FI_DATA_Merged.xlsx"), sheet = "FI_TAX_BARTER", na = convert_to_na, guess_max = 100000)
nfi_tax_atr <- readxl::read_excel(glue::glue("{atr_data_path}NFI_AND_SERVICES_DATA_Merged.xlsx"), sheet = "NFI_TAX_BARTER", na = convert_to_na, guess_max = 100000)
telecom_atr <- readxl::read_excel(glue::glue("{atr_data_path}TELECOM_DATA_Merged.xlsx"), na = convert_to_na, guess_max = 100000)
ime_atr <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged.xlsx"), sheet = "CURRENCY_RATE", na = convert_to_na, guess_max = 100000)
hawala_atr <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged.xlsx"), sheet = "HAWALA_MAIN", na = convert_to_na, guess_max = 100000)
ime_atr_v2 <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged_v2.xlsx"), sheet = "CURRENCY_RATE", na = convert_to_na, guess_max = 100000)
hawala_atr_v2 <- readxl::read_excel(glue::glue("{atr_data_path}HAWALA_EXCHANGE_DATA_Merged_v2.xlsx"), sheet = "HAWALA_FEE", na = convert_to_na, guess_max = 100000)
bank_atr <- readxl::read_excel(glue::glue("{atr_data_path}BANK_DATA_Merged.xlsx"), sheet = "BANK_BRANCH_LEVEL", na = convert_to_na, guess_max = 100000)
bank_respondents_atr <- readxl::read_excel(glue::glue("{atr_data_path}BANK_DATA_Merged.xlsx"), sheet = "BANK_RESPONDENT_LEVEL", na = convert_to_na, guess_max = 100000)
bank_operationality_atr <- readxl::read_excel(glue::glue("{atr_data_path}BANK_OPERATIONALITY_Merged.xlsx"), sheet = "bank_operationality_data", na = convert_to_na, guess_max = 100000)
border_traffice_count_atr <- readxl::read_excel(glue::glue("{atr_data_path}BORDER_TRAFFIC_COUNT_DATA_Merged.xlsx"), sheet = "BORDER_TRAFFIC_COUNT", na = convert_to_na, guess_max = 100000)
border_driver_survey <- readxl::read_excel(glue::glue("{atr_data_path}BORDER_DRIVER_SURVEY_DATA_Merged.xlsx"), na = convert_to_na, guess_max = 100000)
gov_emp_salary_atr <- readxl::read_excel(glue::glue("{atr_data_path}EMPLOYEE_SALARY_DATA_Merged.xlsx"), na = convert_to_na, guess_max = 100000)

# Analysis (ATR data) -----------------
source("R/analysis/1_FI price and availability.R") # FI price and availability
source("R/analysis/2_NFI price and availability.R") # NFI price and availability 
source("R/analysis/3_Taxes and cashless transactions.R") # FI/NFI taxes and cashless transaction
source("R/analysis/4_Labour wage and no. of available days.R") # labour wage and no. of available days
source("R/analysis/5_Bank functionality.R") # bank functionality 
source("R/analysis/5_Bank functionality_2.R") # bank functionality 2
source("R/analysis/6_Bank withdrawal limit.R") # bank withdrawal limit
source("R/analysis/7_Bank withdraw ability and waiting time.R") # bank withdraw ability and waiting time
# TODO: MMO
source("R/analysis/8_IME exchange rate and availability.R") # IME exchange rate and availability of foreing currency
source("R/analysis/9_Hawala changes in transactions, common destination, ability to transfer money.R") # IME Hawala operators (domestic and international)
source("R/analysis/10_border crossings.R")
source("R/analysis/11_gov_employee_salary.R")
source("R/analysis/11_gov_employee_salary_2.R")
source("R/analysis/11_gov_employee_salary_change.R")
source("R/analysis/11_gov_employee_discharged.R")

# export results into "output/analysis/" folder
writexl::write_xlsx(FI_prices_list, glue::glue("{output_path}FI prices_{date}.xlsx"), format_headers = F) # FI price
writexl::write_xlsx(FI_availability_list, glue::glue("{output_path}FI availability_{date}.xlsx"), format_headers = F) # FI availability 
writexl::write_xlsx(NFI_prices_list, glue::glue("{output_path}NFI price-{date}.xlsx"), format_headers = F) # NFI price
writexl::write_xlsx(NFI_availability_list, glue::glue("{output_path}NFI availability_{date}.xlsx"), format_headers = F) # NFI availability 
writexl::write_xlsx(tax_list, glue::glue("{output_path}Taxes_{date}.xlsx"), format_headers = F)  # FI and NFI taxes
writexl::write_xlsx(cashless_transaction_list, glue::glue("{output_path}Cashless transactions_{date}.xlsx"), format_headers = F)  # FI and NFI cashless transaction
writexl::write_xlsx(labour_wage_list, glue::glue("{output_path}Labour wage_{date}.xlsx"), format_headers = F)  # labour wage
writexl::write_xlsx(labour_availability_list, glue::glue("{output_path}Labour availability-{date}.xlsx"), format_headers = F)  # labour no. of available days
writexl::write_xlsx(bank_functionality_list, glue::glue("{output_path}Bank functionality-{date}.xlsx"), format_headers = F) # bank functionality 
writexl::write_xlsx(bank_functionality_list_2, glue::glue("{output_path}Bank functionality 2-{date}.xlsx"), format_headers = F) # bank functionality 2
writexl::write_xlsx(withdrawal_limit_list, glue::glue("{output_path}Bank withdrawal limit_{date}.xlsx"), format_headers = F)  # bank withdrawal limit
writexl::write_xlsx(withdraw_ability_and_waiting_time_list, glue::glue("{output_path}Bank withdraw ability and waiting time_{date}.xlsx"), format_headers = F)  # bank withdraw ability and waiting time
writexl::write_xlsx(ime_availability_list, glue::glue("{output_path}IME availability_{date}.xlsx"), format_headers = F) # IME availability of foreing currency
writexl::write_xlsx(ime_rate_list, glue::glue("{output_path}IME rate_{date}.xlsx"), format_headers = F) # IME exchange rate
writexl::write_xlsx(transaction_changes_list, glue::glue("{output_path}Hawala_changes in transactions_{date}.xlsx"), format_headers = F) # IME changes in domestic and international transactions
writexl::write_xlsx(common_destination_list, glue::glue("{output_path}Hawala_most common destination_{date}.xlsx"), format_headers = F) # IME common domestic and interntional destinations
writexl::write_xlsx(transfer_money_list, glue::glue("{output_path}Hawala_ability to transfer money_{date}.xlsx"), format_headers = F) # IME ability to transfer money (domestic & international)
writexl::write_xlsx(transfer_fee_domestic_intl_list, glue::glue("{output_path}Hawala_transfer fee_{date}.xlsx"), format_headers = F) # IME money transfer fee (domestic & international)
writexl::write_xlsx(border_crossing_trucks_list, glue::glue("{output_path}Border crossing-trucks_{date}.xlsx"), format_headers = F) # Border crossing-trucks
writexl::write_xlsx(border_crossing_tonnage_list, glue::glue("{output_path}Border crossing-tonnage_{date}.xlsx"), format_headers = F) # Border crossing-tonnage
writexl::write_xlsx(border_crossing_aid_commodities_list, glue::glue("{output_path}Border crossing-aid commodities_{date}.xlsx"), format_headers = F) # Border crossing-aid commodities
writexl::write_xlsx(border_crossing_taxes_list, glue::glue("{output_path}Border crossing-taxes_{date}.xlsx"), format_headers = F) # Border crossing-taxes
writexl::write_xlsx(salary_payment_list_1, glue::glue("{output_path}Gov employee_salary_{date}.xlsx"), format_headers = F) # Government Emp Salary
writexl::write_xlsx(salary_payment_list_2, glue::glue("{output_path}Gov employee_salary 2-{date}.xlsx"), format_headers = F) # Government Emp Salary 2
writexl::write_xlsx(salary_change_list, glue::glue("{output_path}Gov employee_salary_change_{date}.xlsx"), format_headers = F) # Government Emp salary change
writexl::write_xlsx(terminated_emp_list, glue::glue("{output_path}Gov employee_discharged_{date}.xlsx"), format_headers = F) # Government Emp Discharged


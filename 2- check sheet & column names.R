##### check sheet/column names in each forms for all weeks -------------------------------------------------
source("1- read data.R")

# form 1: FI
check_sheets(weekly, "fi", "CPI_Market_FI_Dataset")

# form 2: NFI
check_sheets(weekly, "nfi", "CPI_Market_NFI_Dataset")

## form 3: services
check_sheets(weekly, "market_services", "CPI_Market_Services_Dataset")

## form 4: IME and Hawala
check_sheets(weekly, "ime_hawala", "CPI_Market_IME_Hawala_Dataset")

## form 5: Bank
check_sheets(weekly, "bank", "CPI_Bank_Dataset")
#temp 
weekly[["M7 datasets"]][["CPI_Bank_Dataset"]][["bank_manager"]] <- weekly[["M7 datasets"]][["CPI_Bank_Dataset"]][["bank_manager"]] %>% 
  select(-starts_with("exceptions_withdraw_indiv"), -starts_with("exceptions_withdraw_business"))
weekly[["M8 datasets"]][["CPI_Bank_Dataset"]][["bank_manager"]] <- weekly[["M8 datasets"]][["CPI_Bank_Dataset"]][["bank_manager"]] %>% 
  select(-starts_with("exceptions_withdraw_indiv"), -starts_with("exceptions_withdraw_business"))
#

## Form 5.1: Bank Operationality Status, from week 8 onwards
check_sheets(weekly, "bank_operationality", "CPI_Bank_Operationality_Status_Dataset")

## form 6: Border Traffic Count. It isn't available for week 1
check_sheets(weekly, "border_traffic_count", "CPI_Border_Count_of_Transport_Traffic_Dataset")

## form 7: Border Transport Driver Surveys. It is available only for week 1 and 2
check_sheets(weekly, "border_transport_driver", "CPI_Border_Transport_Driver_Survey_Dataset")

## form 8: Telecom
check_sheets(weekly, "telecome_service", "CPI_Telecom_Service_Providers_Dataset")

## form 10: Government Employee_Salary_Payment_Verification. Available only for week 8 and 16. week 8 is pilot data.
check_sheets(weekly, "gov_emp_salary", "CPI_Government_Employee_Salary_Dataset")

## form 9: MMOs (available only for week 1 and 8. Both are pilot data)

## form 11: Railway Count. Available only in week 10


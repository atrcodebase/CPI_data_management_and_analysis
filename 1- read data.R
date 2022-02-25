# load required packages --------------------------------------------------
source("R/required_packages.R")
source("R/custom_functions.R")

# read all data files --------------------------------------------------
path <- "input/raw_data_fixed column names/"
weeks <- list.files(path)
weekly <- list()

for (week in weeks) {
  print(week)
  for (file in list.files(glue::glue("{path}{week}"), pattern = "*.xlsx")) {
    file_name <- glue::glue("{path}{week}/{file}")
    print(file_name)
    weekly[[str_remove(week, "_Economic Monitoring")]][[str_remove(file, ".xlsx")]] <- read_excel_func(file_name)
  }
}

# check whether the year, month & week columns are added in main sheet of each form in every week --------------------------------------------------
for (weeks in names(weekly)) {
  print(glue::glue("# week: {weeks}"))
  for (forms in names(weekly[[weeks]])) {
    check <- all(c("year", "month", "week") %in% colnames(weekly[[weeks]][[forms]][[1]]))
    if (check) {
      print(glue::glue("## the 'year, month & week' columns exist in {forms}"))
    } else {
      print(glue::glue("## the 'year, month & week' columns do NOT exist in {forms}"))
    }
  }
}


# convert date columns to character format in main sheet of each form in every week --------------------------------------------------
date_columns <- c("SubmissionDate", "Starttime", "Endtime", "Date_And_Time")
for (weeks in names(weekly)) {
  print(glue::glue("# week: {weeks}"))
  for (forms in names(weekly[[weeks]])) {
    print(glue::glue("## converting date columns to character in {forms}"))
    weekly[[weeks]][[forms]][[1]] <- dates_to_character(weekly[[weeks]][[forms]][[1]], all_of(date_columns))
  }
}

rm("file", "file_name", "path", "week", "weeks", "read_excel_func", "forms", "check", "date_columns")

# weekly data for each form (must be updated on weekly basis)
## form 1: FI
fi_w1 <- weekly[["W1 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w2 <- weekly[["W2 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w3 <- weekly[["W3 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w4 <- weekly[["W4 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w5 <- weekly[["W5 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w6 <- weekly[["W6 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w7 <- weekly[["W7 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w8 <- weekly[["W8 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w9 <- weekly[["W9 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w10 <- weekly[["W10 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w11 <- weekly[["W11 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w12 <- weekly[["W12 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w13 <- weekly[["W13 datasets"]][["CPI_Market_FI_Dataset"]]
fi_w14 <- weekly[["W14 datasets"]][["CPI_Market_FI_Dataset"]]

## form 2: NFI
nfi_w1 <- weekly[["W1 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w2 <- weekly[["W2 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w3 <- weekly[["W3 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w4 <- weekly[["W4 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w5 <- weekly[["W5 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w6 <- weekly[["W6 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w7 <- weekly[["W7 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w8 <- weekly[["W8 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w9 <- weekly[["W9 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w10 <- weekly[["W10 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w11 <- weekly[["W11 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w12 <- weekly[["W12 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w13 <- weekly[["W13 datasets"]][["CPI_Market_NFI_Dataset"]]
nfi_w14 <- weekly[["W14 datasets"]][["CPI_Market_NFI_Dataset"]]

## form 3: services
market_services_w1 <- weekly[["W1 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w2 <- weekly[["W2 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w3 <- weekly[["W3 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w4 <- weekly[["W4 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w5 <- weekly[["W5 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w6 <- weekly[["W6 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w7 <- weekly[["W7 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w8 <- weekly[["W8 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w9 <- weekly[["W9 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w10 <- weekly[["W10 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w11 <- weekly[["W11 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w12 <- weekly[["W12 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w13 <- weekly[["W13 datasets"]][["CPI_Market_Services_Dataset"]]
market_services_w14 <- weekly[["W14 datasets"]][["CPI_Market_Services_Dataset"]]

## form 4: IME and Hawala
ime_hawala_w1 <- weekly[["W1 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w2 <- weekly[["W2 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w3 <- weekly[["W3 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w4 <- weekly[["W4 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w5 <- weekly[["W5 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w6 <- weekly[["W6 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w7 <- weekly[["W7 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w8 <- weekly[["W8 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w9 <- weekly[["W9 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w10 <- weekly[["W10 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
# the shape of IME data is changed from week 11 onwards
ime_hawala_w11 <- weekly[["W11 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w12 <- weekly[["W12 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w13 <- weekly[["W13 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]
ime_hawala_w14 <- weekly[["W14 datasets"]][["CPI_Market_IME_Hawala_Dataset"]]

## form 5: Bank
bank_w1 <- weekly[["W1 datasets"]][["CPI_Bank_Dataset"]]
bank_w2 <- weekly[["W2 datasets"]][["CPI_Bank_Dataset"]]
bank_w3 <- weekly[["W3 datasets"]][["CPI_Bank_Dataset"]]
bank_w4 <- weekly[["W4 datasets"]][["CPI_Bank_Dataset"]]
bank_w5 <- weekly[["W5 datasets"]][["CPI_Bank_Dataset"]]
bank_w6 <- weekly[["W6 datasets"]][["CPI_Bank_Dataset"]]
bank_w7 <- weekly[["W7 datasets"]][["CPI_Bank_Dataset"]]
bank_w8 <- weekly[["W8 datasets"]][["CPI_Bank_Dataset"]]
bank_w9 <- weekly[["W9 datasets"]][["CPI_Bank_Dataset"]]
bank_w10 <- weekly[["W10 datasets"]][["CPI_Bank_Dataset"]]
bank_w11 <- weekly[["W11 datasets"]][["CPI_Bank_Dataset"]]
bank_w12 <- weekly[["W12 datasets"]][["CPI_Bank_Dataset"]]
bank_w13 <- weekly[["W13 datasets"]][["CPI_Bank_Dataset"]]
bank_w14 <- weekly[["W14 datasets"]][["CPI_Bank_Dataset"]]

## Form 5.1: Bank Operationality Status, available from week 8 onwards
bank_operationality_w8 <- weekly[["W8 datasets"]][["CPI_Bank_Operationality_Status_Dataset"]]
bank_operationality_w9 <- weekly[["W9 datasets"]][["CPI_Bank_Operationality_Status_Dataset"]]
bank_operationality_w10 <- weekly[["W10 datasets"]][["CPI_Bank_Operationality_Status_Dataset"]]
bank_operationality_w11 <- weekly[["W11 datasets"]][["CPI_Bank_Operationality_Status_Dataset"]]
bank_operationality_w12 <- weekly[["W12 datasets"]][["CPI_Bank_Operationality_Status_Dataset"]]
bank_operationality_w13 <- weekly[["W13 datasets"]][["CPI_Bank_Operationality_Status_Dataset"]]
bank_operationality_w14 <- weekly[["W14 datasets"]][["CPI_Bank_Operationality_Status_Dataset"]]

## form 6: Border Traffic Count. Not available for week 1
border_traffic_count_w2 <- weekly[["W2 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w3 <- weekly[["W3 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w4 <- weekly[["W4 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w5 <- weekly[["W5 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w6 <- weekly[["W6 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w7 <- weekly[["W7 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w8 <- weekly[["W8 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w9 <- weekly[["W9 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w10 <- weekly[["W10 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w11 <- weekly[["W11 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w12 <- weekly[["W12 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w13 <- weekly[["W13 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]
border_traffic_count_w14 <- weekly[["W14 datasets"]][["CPI_Border_Count_of_Transport_Traffic_Dataset"]]

## form 7: Border Transport Driver Surveys, available only for week 1 & 2s
border_transport_driver_w1 <- weekly[["W1 datasets"]][["CPI_Border_Transport_Driver_Survey_Dataset"]]
border_transport_driver_w2 <- weekly[["W2 datasets"]][["CPI_Border_Transport_Driver_Survey_Dataset"]]

## form 8: Telecom 
telecome_service_w1 <- weekly[["W1 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w2 <- weekly[["W2 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w3 <- weekly[["W3 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w4 <- weekly[["W4 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w5 <- weekly[["W5 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w6 <- weekly[["W6 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w7 <- weekly[["W7 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w8 <- weekly[["W8 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w9 <- weekly[["W9 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w10 <- weekly[["W10 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w11 <- weekly[["W11 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w12 <- weekly[["W12 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w13 <- weekly[["W13 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]
telecome_service_w14 <- weekly[["W14 datasets"]][["CPI_Telecom_Service_Providers_Dataset"]]

## form 9: MMOs (week 1 and 8 are pilot data)
# mmo_w1 <- weekly[["W1 datasets"]][["CPI_MMOs_Dataset"]] (pilot data)
# mmo_w8 <- weekly[["W8 datasets"]][["CPI_MMOs_Dataset"]] (pilot data)

## form 10: Government Employee_Salary_Payment_Verification (week 8 is pilot data) 
# gov_emp_salary_w8 <- weekly[["W8 datasets"]][["Government Employee_Salary_Payment_Verification_Dataset"]] (pilot data)

## form 11: Railway Count, available for week 10
railway_w10 <- weekly[["W10 datasets"]][["CPI_Railway_Count_Dataset"]]


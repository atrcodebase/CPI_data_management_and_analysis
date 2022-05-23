# load required packages --------------------------------------------------
source("R/required_packages.R")
# file.edit("R/custom_functions.R")
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

# remove leading and trailing spaces from column names --------------------------------------------------
for (weeks in names(weekly)) {
  print(glue::glue("# week: {weeks} ----------------------------------"))
  for (forms in names(weekly[[weeks]])) {
    print(glue::glue("## form: {forms} -----------------"))
    for (sheets in names(weekly[[weeks]][[forms]])) {
      print(glue::glue("### whitespaces removed from '{sheets}' sheet column names."))
      col_names <- colnames(weekly[[weeks]][[forms]][[sheets]])
      colnames(weekly[[weeks]][[forms]][[sheets]]) <- str_squish(col_names)
    }
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

rm("file", "file_name", "path", "week", "weeks", "read_excel_func", "forms", "date_columns", "dates_to_character")

# weekly data for each form (must be updated on weekly basis)
## form 1: FI
extract_assign(weekly, "fi", "CPI_Market_FI_Dataset")
## form 2: NFI
extract_assign(weekly, "nfi", "CPI_Market_NFI_Dataset")
## form 3: services
extract_assign(weekly, "market_services", "CPI_Market_Services_Dataset")
## form 4: IME and Hawala
extract_assign(weekly, "ime_hawala", "CPI_Market_IME_Hawala_Dataset")
## form 5: Bank
extract_assign(weekly, "bank", "CPI_Bank_Dataset")
## Form 5.1: Bank Operationality Status, available from week 8 onwards
extract_assign(weekly, "bank_operationality", "CPI_Bank_Operationality_Status_Dataset")
## form 6: Border Traffic Count. Not available for week 1
extract_assign(weekly, "border_traffic_count", "CPI_Border_Count_of_Transport_Traffic_Dataset")
## form 7: Border Transport Driver Surveys, available only for week 1 & 2s
extract_assign(weekly, "border_transport_driver", "CPI_Border_Transport_Driver_Survey_Dataset")
## form 8: Telecom 
extract_assign(weekly, "telecome_service", "CPI_Telecom_Service_Providers_Dataset")


## form 9: MMOs (week 1 and 8 are pilot data)
# mmo_w1 <- weekly[["W1 datasets"]][["CPI_MMOs_Dataset"]] (pilot data)
# mmo_w8 <- weekly[["W8 datasets"]][["CPI_MMOs_Dataset"]] (pilot data)

## form 10: Government Employee_Salary_Payment_Verification. Only available for week 8 and week 16. Week 8 is pilot data
extract_assign(weekly, "gov_emp_salary", "Government_Employee_Salary_Payment_Dataset")

## form 11: Railway Count, available for week 10 which is pilot data


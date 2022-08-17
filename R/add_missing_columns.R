# Add missing columns --------------------------------------------------------------------
for(week in names(weekly)){
  for(file_name in names(weekly[[week]])){

    # Main sheet
    data <- weekly[[week]][[file_name]][[1]]
    #add Year/Month/Week variables
    if("year" %notin% names(data) | "month" %notin% names(data) | "week" %notin% names(data)){
      
      #extract values
      y = year(data$SubmissionDate[1])
      
      if(grepl("M", week)){
        m = str_remove_all(week, "M| datasets")
        w = NA_character_
        
        weekly[[week]][[file_name]][[1]] <- weekly[[week]][[file_name]][[1]] %>%
          mutate(year = y, month = m, week = w, .after = Date_And_Time) %>% 
          rename(Planned_data_collection_period_TPMA=Planned_data_collection_period) %>% 
          mutate(Planned_data_collection_period_Calendar=NA,
                 Reporting_Period_Calendar_Week=NA)
        #add cols in no_bank sheet
        if(file_name %in% "CPI_Bank_Operationality_Status_Dataset"){
          weekly[[week]][[file_name]][[2]] <- weekly[[week]][[file_name]][[2]] %>%
            rename(Planned_data_collection_period_TPMA=Planned_data_collection_period) %>% 
            mutate(Planned_data_collection_period_Calendar=NA,
                   Reporting_Period_Calendar_Week=NA)
        }
      } else {
        m = month(data$SubmissionDate[1])
        w = str_extract(data$Planned_data_collection_period_TPMA[1], "(?<=W)(.*?)(?=\\-)")
        
        weekly[[week]][[file_name]][[1]] <- weekly[[week]][[file_name]][[1]] %>%
          mutate(year = y, month = m, week = w, .after = Date_And_Time)
      }
      #notify
      print("----------------------------------------------------------------------")
      print(paste0(y,"/",m,"/",w," (year/month/week) added in ",file_name,": ", week))
    }
    
    # All sheets
    data <- weekly[[week]][[file_name]]
    #add unit2 column
    sheet_n <- "subrespondents_available_data"
    if(file_name %in% "CPI_Market_Services_Dataset" & "unit2" %notin% names(data[[sheet_n]])){
      weekly[[week]][[file_name]][[sheet_n]] <- weekly[[week]][[file_name]][[sheet_n]] %>% 
        mutate(unit2 = NA_character_)
      #notify
      print(paste0("unit2 added in CPI_Market_Services_Dataset: ", week))
    }
    
    #remove KEY_Main, it is the same as Parent_Key
    sheet_n <- "ime_hawala_subresps"
    if(file_name %in% "CPI_Market_IME_Hawala_Dataset" & "KEY_Main" %in% names(data[[sheet_n]])){
      weekly[[week]][[file_name]][[sheet_n]] <- weekly[[week]][[file_name]][[sheet_n]] %>% 
        select(-KEY_Main)
      #notify
      print(paste0("KEY_Main removed from CPI_Market_IME_Hawala_Dataset: ", week))
    }
    
    #add vehicle_loaded
    sheet_n <- "Traffic_count"
    if(file_name %in% "CPI_Border_Count_of_Transport_Traffic_Dataset" & "vehicle_loaded" %notin% names(data[[sheet_n]])){
      weekly[[week]][[file_name]][[sheet_n]] <- weekly[[week]][[file_name]][[sheet_n]] %>% 
        mutate(vehicle_loaded = NA_character_)
      #notify
      print(paste0("vehicle_loaded added in CPI_Border_Count_of_Transport_Traffic_Dataset: ", week))
    }
  }
}

weekly[["M7 datasets"]][["CPI_Government_Employee_Salary_Dataset"]][["data"]] <- weekly[["M7 datasets"]][["CPI_Government_Employee_Salary_Dataset"]][["data"]] %>% 
  mutate(Position_Grade_Step = paste0("Grade ",Grade,", Step ", Step), .after = Grade) %>% 
  mutate(Salary_Status = case_when(
    Salary_Status_1 %in% Salary_Status_2 & Salary_Status_2 %in% Salary_Status_3 ~ Salary_Status_1,
    TRUE ~ paste0(Salary_Status_1, Salary_Status_2, Salary_Status_3, collapse = "; ")
  ),
  dummy_var=Has_Alternative_sources_Other.1,
  If_not_a_first_Site_Visit_state_Original_Site_Visit_ID=NA,
  Type_of_center=NA,
  Position_Terminated_Since_Political_Transition=NA,
  Partially_Paid_Salary=NA,
  Partially_Paid_Salary_Other=NA,
  Cash_Salary_Type_5=NA
  ) %>% 
  select(-c(Consent,
            Department_Verification,
            Current_Department,
            Current_Department_Other,
            Job_Tenure_Months,
            Job_Position_Verification,
            Current_Designation,
            Tashkeel_Or_NTA_1,
            Tashkeel_Or_NTA_2,
            Grade,
            Step,
            Cash_Salary_Type_99,
            starts_with("Has_Alternative_sources_"),
            starts_with("Paid_Salary_periods_Months_"),
            starts_with("Salary_Status_"), 
            starts_with("selected_month_"),
            starts_with("Informed_About_Salary_By_"),
            starts_with("Salary_Receiving_Challenges_Details_"))) %>% 
  rename(Job_Tenure_Year=Job_Tenure_Years,
         Has_Alternative_sources_Other=dummy_var)

rm(m, w, y, sheet_n, data)

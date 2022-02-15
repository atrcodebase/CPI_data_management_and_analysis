### Read Data 
file_list <- list.files(data_path)

for (data_set_name in file_list) {
  # form 1: FI
  if(stringr::str_detect(data_set_name, "CPI_Market_FI_Dataset")){
    fi_data_name <- data_set_name
  }
  # form 2: NFI
  if(stringr::str_detect(data_set_name, "CPI_Market_NFI_Dataset")){
    nfi_data_name <- data_set_name
  }
  ## form 3: services
  if(stringr::str_detect(data_set_name, "CPI_Market_Services_Dataset")){
    ms_data_name <- data_set_name
  }
  ## Form 4: IME and Hawala. (from week 1-10)
  if(stringr::str_detect(data_set_name, "CPI_Market_IME_Hawala") & stringr::str_detect(data_set_name, "CPI_Market_IME_Hawala_Dataset_v2", negate = T)){
    mex_data_name <- data_set_name
  }
  ## Form 4: IME version 2 (from week 11 onwards)
  if(stringr::str_detect(data_set_name, "CPI_Market_IME_Hawala_Dataset_v2")){
    mex_data_name_v2 <- data_set_name
  }
  ## Form 5: Bank
  if(stringr::str_detect(data_set_name, "CPI_Bank_Dataset")){
    banks_data_name <- data_set_name
  }
  ## Form 5.1 Bank Operationality data 
  if(stringr::str_detect(data_set_name, "CPI_Bank_Operationality_Status")){
    banks_operationality_data_name <- data_set_name
  }
  ## Form 6: Border Traffic Count
  if(stringr::str_detect(data_set_name, "CPI_Border_Count_of_Transport")){
    br_traf_data_name <- data_set_name
  }
  ## Form 7: Border Transport Driver Surveys
  if(stringr::str_detect(data_set_name, "CPI_Border_Transport_Driver")){
    br_driver_data_name <- data_set_name
  }
  ## Form 8 - Telecom
  if(stringr::str_detect(data_set_name, "CPI_Telecom_Service")){
    tele_data_name <- data_set_name
  }
  ## Form 9 - MMOs
  if(stringr::str_detect(data_set_name, "CPI_MMOs_Dataset")){
    mmo_data_name <- data_set_name
  }
  ## form 10: Government Employee_Salary_Payment_Verification
  if(stringr::str_detect(data_set_name, "Employee_Salary_Payment_Verification")){
    employee_salary_payment_data_name <- data_set_name
  }
  
  ## form 11: Railway Count.
  if(stringr::str_detect(data_set_name, "CPI_Railway_Count")){
    railway_count_data_name <- data_set_name
  }
}

rm("data_set_name", "file_list")

tryCatch(
  {
    # read Path
    fi_path <- paste0(data_path, fi_data_name); rm("fi_data_name")
    nfi_path <- paste0(data_path, nfi_data_name); rm("nfi_data_name")
    ms_path <- paste0(data_path, ms_data_name); rm("ms_data_name")
    mex_path <- paste0(data_path, mex_data_name); rm("mex_data_name")
    mex_path_v2 <- paste0(data_path, mex_data_name_v2); rm("mex_data_name_v2")
    banks_path <- paste0(data_path, banks_data_name); rm("banks_data_name")
    banks_operationality_path <- paste0(data_path, banks_operationality_data_name); rm("banks_operationality_data_name")
    br_traf_count_path <- paste0(data_path, br_traf_data_name); rm("br_traf_data_name")
    
    if(exists("br_driver_data_name")){
      br_driver_path <- paste0(data_path, br_driver_data_name); rm("br_driver_data_name")
    }
    
    tele_path <- paste0(data_path, tele_data_name); rm("tele_data_name")
    
    if(exists("mmo_data_name")){
    mmo_path <- paste0(data_path, mmo_data_name); rm("mmo_data_name")
    }
    
    if(exists("employee_salary_payment_data_name")){
      employee_salary_payment_path <- paste0(data_path, employee_salary_payment_data_name); rm("employee_salary_payment_data_name")
    }
    
    if(exists("railway_count_data_name")){
      railway_count_path <- paste0(data_path, railway_count_data_name); rm("railway_count_data_name")
    }
    
    
    # 1 - Food Items
    fi_main <- read_xlsx(fi_path, sheet = "main", guess_max = 50000)
    fi_sub_resp <- read_xlsx(fi_path, sheet = "fi_subresps", guess_max = 50000)
    fi_sub_rep <- read_xlsx(fi_path, sheet = "subreps_ava_nava_tax_bartering", guess_max = 50000)
    fi_sub_items <- read_xlsx(fi_path, sheet = "fi_items_prices_avail_notavail", guess_max = 50000)
    #temp 
    fi_sub_items$Price_FI = as.numeric(fi_sub_items$Price_FI)
    fi_sub_items$Unit_Amount_FI = as.numeric(fi_sub_items$Unit_Amount_FI)
    fi_sub_items$weight_nan = as.numeric(fi_sub_items$weight_nan)
    
    # 2 - Non-Food Items
    nfi_main <- read_xlsx(nfi_path, sheet = "main", guess_max = 50000)
    nfi_sub_resp <- read_xlsx(nfi_path, sheet = "nfi_subresps", guess_max = 50000)
    nfi_sub_rep <- read_xlsx(nfi_path, sheet = "nsubreps_ava_nava_tax_bartering", guess_max = 50000)
    nfi_sub_items <- read_xlsx(nfi_path, sheet = "nfi_items_prices_avail_notavail", guess_max = 50000)
    #temp
    nfi_sub_items$Price_Cost_NFI = as.numeric(nfi_sub_items$Price_Cost_NFI)
    nfi_sub_items$Unit_NFI_Amount = as.numeric(nfi_sub_items$Unit_NFI_Amount)
    nfi_sub_items$Required_Fabric = as.numeric(nfi_sub_items$Required_Fabric)
    
    # 3 - Market Services
    ms_main <- read_xlsx(ms_path, sheet = "main", guess_max = 50000)
    ms_sub_resp <- read_xlsx(ms_path, sheet = "subrespondents", guess_max = 50000)
    ms_sub_rep <- read_xlsx(ms_path, sheet = "subrespondents_avail_notavail", guess_max = 50000)
    ms_sub_items <- read_xlsx(ms_path, sheet = "subrespondents_available_data", guess_max = 50000)
    ms_sub_labour_type <- read_xlsx(ms_path, sheet = "Labour", guess_max = 50000)
    
    # 4 - Money Exchange (from week 1-10)
    mex_main <- read_xlsx(mex_path, sheet = "main", guess_max = 50000)
    mex_sub_resp <- read_xlsx(mex_path, sheet = "ime_hawala_subresps", guess_max = 50000)
    mex_sub_rep <- read_xlsx(mex_path, sheet = "ime_hawala_avail_navail", guess_max = 50000)
    mex_cur_ex <- read_xlsx(mex_path, sheet = "exchange_rate_and_hawaladest", guess_max = 50000)
    mex_trans_fee_same <- read_xlsx(mex_path, sheet = "same_fee_for_selected_dest_same", guess_max = 50000)
    mex_trans_fee_amount_1 <- read_xlsx(mex_path, sheet = "transfer_fees_1st_dest", guess_max = 50000)
    mex_trans_fee_amount_2 <- read_xlsx(mex_path, sheet = "transfer_fees_2nd_dest", guess_max = 50000)
    mex_trans_fee_amount_3 <- read_xlsx(mex_path, sheet = "transfer_fees_3rd_dest", guess_max = 50000)
    
    # 4 - Money Exchange (v2: from week 11 onwards)
    mex_main_v2 <- read_xlsx(mex_path_v2, sheet = "main", guess_max = 50000)
    mex_sub_resp_v2 <- read_xlsx(mex_path_v2, sheet = "ime_hawala_subresps", guess_max = 50000)
    mex_cur_ex_v2 <- read_xlsx(mex_path_v2, sheet = "ime_hawala_Currency_Exchange", guess_max = 50000)
    mex_hawala_transfer_v2 <- read_xlsx(mex_path_v2, sheet = "ime_hawala_Hawala_Transfer", guess_max = 50000)
    
    # 5 - Banks
    banks_main <- read_xlsx(banks_path, sheet = "bank_manager", guess_max = 50000)
    banks_resp_que <- read_xlsx(banks_path, sheet = "queues_interview", guess_max = 50000)
    
    # 5.1 - Banks operationality
    banks_operationality_main <- read_xlsx(banks_operationality_path, sheet = "bank_operationality_data", guess_max = 50000)
    banks_operationality_no_bank <- read_xlsx(banks_operationality_path, sheet = "no_bank", guess_max = 50000)
    
    # 6 - Border Traffic Count
    if(exists("br_traf_count_path")){
    br_traf_count_main <- read_xlsx(br_traf_count_path, sheet = "data", guess_max = 50000)
    br_traf_count_count <- read_xlsx(br_traf_count_path, sheet = "Traffic_count", guess_max = 50000)
    }
    
    # 7 - Border Driver Survey
    if(exists("br_driver_path")){
    br_driver_main <- read_xlsx(br_driver_path, sheet = "data", guess_max = 50000)
    }
    
    # 8 - Telecom Servivice
    telecom_data <- read_excel(tele_path, sheet = "telecom_data", guess_max = 50000)
    
    # 9 - MMO
    # if(exists("mmo_path")){
    # mmo_main <- read_excel(mmo_path, sheet = "main", guess_max = 50000)
    # mmo_amnt_domestic <- read_excel(mmo_path, sheet = "mmo_amount_fee_per_transfer", guess_max = 50000)
    # mmo_amount_witdraw <- read_excel(mmo_path, sheet = "mmo_amount_fee_per_withdraw", guess_max = 50000)
    # }
    
    # 10: Government Employee_Salary_Payment_Verification
    if(exists("employee_salary_payment_path")){
      employee_salary_payment_data  <- read_excel(employee_salary_payment_path, sheet = "data", guess_max = 50000)
    }
    
    # 11: Railway Count
    if(exists("railway_count_path")){
      railway_count_main <- read_excel(railway_count_path, sheet = "Main", guess_max = 50000)
      railway_count_interviewee_respondent <- read_excel(railway_count_path, sheet = "Interviewee_Respondent", guess_max = 50000)
      railway_count_train_info <- read_excel(railway_count_path, sheet = "Train_Info", guess_max = 50000)
      railway_count_wagon_count_and_info <- read_excel(railway_count_path, sheet = "Wagon_Count_and_Info", guess_max = 50000)
    }

    
    # Print success message
    cat("1 - Successsfully Read the Data!")
    
    # remove extra objects
    remove(fi_path)
    remove(nfi_path)
    remove(ms_path)
    remove(mex_path)
    remove(mex_path_v2)
    remove(banks_path)
    remove (banks_operationality_path)
    remove(br_traf_count_path)
    if(exists("br_driver_path")){
      remove(br_driver_path)
    }
    remove(tele_path)
    if(exists("mmo_path")){
      remove(mmo_path)
    }
    if(exists("employee_salary_payment_path")){
      remove(employee_salary_payment_path)
    }
    if(exists("railway_count_path")){
      remove(railway_count_path)
    }
    
  },
  
  error=function(cond){
    message("Error: ")
    message(cond)
    
  },
  
  warning=function(cond){
    message("Warning: ")
    message(cond)
  }
)

# remove duplicated Cols --------------------------------------------------

tryCatch(
  {
    fi_main <- fi_main[, !duplicated(colnames(fi_main))]
    fi_sub_resp <- fi_sub_resp[, !duplicated(colnames(fi_sub_resp))]
    
    nfi_main <- nfi_main[, !duplicated(colnames(nfi_main))]
    nfi_sub_resp <- nfi_sub_resp[, !duplicated(colnames(nfi_sub_resp))]
    
    ms_main <- ms_main[, !duplicated(colnames(ms_main))]
    ms_sub_resp <- ms_sub_resp[, !duplicated(colnames(ms_sub_resp))]
    
    mex_main <- mex_main[, !duplicated(colnames(mex_main))]
    mex_sub_resp <- mex_sub_resp[, !duplicated(colnames(mex_sub_resp))]
    
    # Print success message
    cat("\n")
    cat("2 - Successsfully removed duplicated variables")
  },
  
  error=function(cond){
    message("Error: ")
    message(cond)
    
  }
  
)












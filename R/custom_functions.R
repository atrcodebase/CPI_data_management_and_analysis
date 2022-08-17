# use setequal instead of identical
read_excel_func <- function(file) {
  file %>% 
    excel_sheets() %>%
    set_names() %>%
    map(read_excel, path = file, guess_max = 100000)
}

check_column_names <- function(target, check_with, variable_name){
  for (n in 1:length(target)) {
    sheet_name <- names(target[n])
    check <- setequal(colnames(target[[n]]), colnames(check_with[[n]]))
    
    if(check == FALSE){
      
      #Find the columns that are missing
      result <- names(target[[sheet_name]])[!names(target[[sheet_name]]) %in% names(check_with[[sheet_name]])]
      msg <- glue::glue("Missing Columns in sheet '{sheet_name}', {variable_name}:")
      if(length(result) == 0){
        result <- names(check_with[[sheet_name]])[!names(check_with[[sheet_name]]) %in% names(target[[sheet_name]])]
        msg <- glue::glue("Extra Columns in sheet '{sheet_name}', {variable_name}:")
      }
      
      print(msg)
      print(result)
    }
  }
}

dates_to_character <- function(df, ...) {
  mutate(df,
         across(.cols = c(...),
                function(x)
                  x = as.character(x)
         ))
}

# #Extracts each dataset from the list and assigns it to a variable
# extract_assign <- function(weekly, var_name, file_name){
#   
#   for(week in names(weekly)){
#     #extract weeks and create variable names for each dataset
#     week_str <- tolower(str_remove(week, " datasets"))
#     variable <- paste0(var_name, "_", week_str)
#     data <- weekly[[week]][[file_name]]
#     
#     #Assign variable if data exists in the week -----------------
#     if(length(data) != 0){
#       assign(variable, data, envir = .GlobalEnv)
#     }
#   }
# }

#Crosschecks sheet and column names
check_sheets <- function(weekly, var_name, file_name){
  # #test values
  # week=names(weekly)[1]
  # var_name="gov_emp_salary"
  # file_name="CPI_Government_Employee_Salary_Dataset"
  # #
  for(week in names(weekly)){
    #extract weeks and create variable names for each dataset
    week_str <- tolower(str_remove(week, " datasets"))
    variable <- paste0(var_name, "_", week_str)
    #condition for Monthly Data
    if(grepl("m", week_str)){
      week_num = "m"
    } else {
      week_num <- as.numeric(str_remove(week_str, "w"))
    }
    
    #data to compare against
    t_w <- case_when(
      var_name %in% "ime_hawala" & (week_num > 10 | week_num == "m") ~ "W11 datasets",
      var_name %in% "border_traffic_count" ~ "W2 datasets",
      var_name %in% "bank_operationality" ~ "W8 datasets",
      var_name %in% "gov_emp_salary" ~ "W16 datasets",
      TRUE ~ "W1 datasets"
    )
    
    target <- weekly[[t_w]][[file_name]]
    data <- weekly[[week]][[file_name]]
    #Checks if the file_name is in the current week 
    if(length(data) != 0){
      #checks sheet names
      sheets_equal <- setequal(names(data), names(target))
      if(sheets_equal == FALSE){
        print(glue::glue("The sheet names in {variable} are NOT IDENTICAL"))
      }
      
      #checks if column names are consistent 
      check_column_names(target = target, check_with = data, variable_name = variable)
    }
  }
}

merge_data <- function(weekly, var_name, file_name, reference_week= "W1 datasets", gov_emp_weeks=""){

  #creating dataframes
  for(sheet in names(weekly[[reference_week]][[file_name]])){
    variable <- paste0(var_name, "_", sheet)
    assign(variable, data.frame(), envir = .GlobalEnv)
  }
  
  for(week in names(weekly)){
    #extract weeks and create variable names for each dataset
    week_str <- tolower(str_remove(week, " datasets"))
    #condition for Monthly Data
    is_month <- grepl("m", week_str)
    if(is_month){
      week_num = week_str
    } else {
      week_num <- as.numeric(str_remove(week_str, "w"))
    }
    
    #Skip the iteration if data is not in the week
    skip_loop <- case_when(
      file_name %in% "CPI_Market_IME_Hawala_Dataset" & reference_week == "W1 datasets" & (week_num > 10 | is_month)  ~ TRUE,
      file_name %in% "CPI_Market_IME_Hawala_Dataset" & reference_week == "W11 datasets" & week_num < 11  ~ TRUE, #For IME V2
      file_name %in% "CPI_Bank_Operationality_Status_Dataset" & week_num < 8  ~ TRUE,
      file_name %in% "CPI_Border_Count_of_Transport_Traffic_Dataset" & week_num == 1  ~ TRUE,
      file_name %in% "CPI_Border_Transport_Driver_Survey_Dataset" & week_num > 2  ~ TRUE,
      file_name %in% "CPI_Government_Employee_Salary_Dataset" & week_num %notin% gov_emp_weeks ~ TRUE,
      TRUE ~ FALSE
    )
    if(skip_loop){ next }
    
    data <- weekly[[week]][[file_name]]
    for(sheet in names(data)){
      variable <- paste0(var_name, "_", sheet)
      #rbind the sheet with the sheets from other weeks
      assign(variable, rbind(get(variable), data[[sheet]]), envir = .GlobalEnv)
    }
  } 
}


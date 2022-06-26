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

#Extracts each dataset from the list and assigns it to a variable
extract_assign <- function(weekly, var_name, file_name){
  
  for(week in names(weekly)){
    #extract weeks and create variable names for each dataset
    week_str <- tolower(str_remove(week, " datasets"))
    variable <- paste0(var_name, "_", week_str)
    data <- weekly[[week]][[file_name]]
    
    #Making the columns consistent across weeks -----------------
    if(length(data) != 0){
      
      #add Year/Month/Week variables
      if("year" %notin% names(data[[1]]) | "month" %notin% names(data[[1]]) | "week" %notin% names(data[[1]])){
        #extract values
        y = year(data[[1]]$SubmissionDate[1])
        m = month(data[[1]]$SubmissionDate[1])
        w = str_extract(data[[1]]$Planned_data_collection_period_TPMA[1], "(?<=W)(.*?)(?=\\-)")
        
        weekly[[week]][[file_name]][[1]] <<- weekly[[week]][[file_name]][[1]] %>%
          mutate(year = y, month = m, week = w, .after = Date_And_Time)
        #notify
        print("----------------------------------------------------------------------")
        print(paste0(y,"/",m,"/",w," (year/month/week) added in ",file_name," week: ", week))
      }
      
      #add unit2 column
      sheet_n <- "subrespondents_available_data"
      if(file_name %in% "CPI_Market_Services_Dataset" & "unit2" %notin% names(data[[sheet_n]])){
        weekly[[week]][[file_name]][[sheet_n]] <<- weekly[[week]][[file_name]][[sheet_n]] %>% 
          mutate(unit2 = NA_character_)
        #notify
        print(paste0("unit2 added in CPI_Market_Services_Dataset, week: ", week))
      }
      
      #remove KEY_Main, it is the same as Parent_Key
      sheet_n <- "ime_hawala_subresps"
      if(file_name %in% "CPI_Market_IME_Hawala_Dataset" & "KEY_Main" %in% names(data[[sheet_n]])){
        weekly[[week]][[file_name]][[sheet_n]] <<- weekly[[week]][[file_name]][[sheet_n]] %>% 
          select(-KEY_Main)
        #notify
        print(paste0("KEY_Main removed from CPI_Market_IME_Hawala_Dataset, week: ", week))
      }
      
      #add vehicle_loaded
      sheet_n <- "Traffic_count"
      if(file_name %in% "CPI_Border_Count_of_Transport_Traffic_Dataset" & "vehicle_loaded" %notin% names(data[[sheet_n]])){
        weekly[[week]][[file_name]][[sheet_n]] <<- weekly[[week]][[file_name]][[sheet_n]] %>% 
          mutate(vehicle_loaded = NA_character_)
        #notify
        print(paste0("vehicle_loaded added in CPI_Border_Count_of_Transport_Traffic_Dataset, week: ", week))
        
      }
      #re-assign data
      data <- weekly[[week]][[file_name]]
    }
    
    #Assign variable if data exists in the week -----------------
    if(length(data) != 0){
      assign(variable, data, envir = .GlobalEnv)
    }
  }
}

#Crosschecks sheet and column names
check_sheets <- function(weekly, var_name, file_name){
  
  for(week in names(weekly)){
    #extract weeks and create variable names for each dataset
    week_str <- tolower(str_remove(week, " datasets"))
    week_num <- as.numeric(str_remove(week_str, "w"))
    variable <- paste0(var_name, "_", week_str)
    
    #data to compare against
    t_w <- case_when(
      var_name %in% "ime_hawala" & week_num > 10 ~ "w11",
      var_name %in% "border_traffic_count" ~ "w2",
      var_name %in% "bank_operationality" ~ "w8",
      var_name %in% "gov_emp_salary" ~ "w16",
      TRUE ~ "w1"
    )
    target <- paste0(var_name,"_", t_w)
    
    data <- weekly[[week]][[file_name]]
    #Checks if the file_name is in the current week 
    if(length(data) != 0){
      #checks sheet names
      sheets_equal <- setequal(names(data), names(get(target)))
      if(sheets_equal == FALSE){
        print(glue::glue("The sheet names in {variable} are NOT IDENTICAL"))
      }
      
      #checks if column names are consistent 
      check_column_names(target = get(target), check_with = data, variable_name = variable)
    }
  }
  
}

merge_data <- function(weekly, var_name, file_name, reference_week= "W1 datasets"){
  
  #creating dataframes
  for(sheet in names(weekly[[reference_week]][[file_name]])){
    variable <- paste0(var_name, "_", sheet)
    assign(variable, data.frame(), envir = .GlobalEnv)
  }
  
  for(week in names(weekly)){
    #extract weeks and create variable names for each dataset
    week_str <- tolower(str_remove(week, " datasets"))
    week_num <- as.numeric(str_remove(week_str, "w"))
    
    #Skip the iteration if data is not in the week
    skip_loop <- case_when(
      file_name %in% "CPI_Market_IME_Hawala_Dataset" & reference_week == "W1 datasets" & week_num > 10  ~ TRUE,
      #For IME V2
      file_name %in% "CPI_Market_IME_Hawala_Dataset" & reference_week == "W11 datasets" & week_num < 11  ~ TRUE,
      file_name %in% "CPI_Bank_Operationality_Status_Dataset" & week_num < 8  ~ TRUE,
      file_name %in% "CPI_Border_Count_of_Transport_Traffic_Dataset" & week_num == 1  ~ TRUE,
      file_name %in% "CPI_Border_Transport_Driver_Survey_Dataset" & week_num > 2  ~ TRUE,
      file_name %in% "CPI_Government_Employee_Salary_Dataset" & week_num %notin% c(16,22, 29)  ~ TRUE,
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


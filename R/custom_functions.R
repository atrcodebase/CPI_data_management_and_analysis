# use setequal instead of identical
read_excel_func <- function(file) {
  file %>% 
    excel_sheets() %>%
    set_names() %>%
    map(read_excel, path = file, guess_max = 100000)
}

check_column_names <- function(target, check_with){
  for (n in 1:length(target)) {
    sheet_name <- names(target[n])
    check <- setequal(colnames(target[[n]]), colnames(check_with[[n]]))
    status <- if (check == FALSE){"are NOT"} else if (check) {"are"}
    print(glue::glue("Column names in '{sheet_name}' sheet {status} identical"))
    
    if(check == FALSE){
      res <- names(check_with[[sheet_name]])[!names(check_with[[sheet_name]]) %in% names(target[[sheet_name]])]
      res_week <- deparse(substitute(target))
      if(length(res) == 0){
        res <- names(target[[sheet_name]])[!names(target[[sheet_name]]) %in% names(check_with[[sheet_name]])]
        res_week <- deparse(substitute(check_with))
      }
      
      print(paste0("The following Columns are missing in ", res_week,":"))
      print(res)
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



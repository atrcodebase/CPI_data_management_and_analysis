# use setequal instead of identical
read_excel_func <- function(file) {
  file %>% 
    excel_sheets() %>%
    set_names() %>%
    map(read_excel, path = file)
}

check_column_names <- function(target, check_with){
  for (n in 1:length(target)) {
    sheet_name <- names(target[n])
    check <- setequal(colnames(target[[n]]), colnames(check_with[[n]]))
    status <- if (check == FALSE){"are NOT"} else if (check) {"are"}
    print(glue::glue("Column names in '{sheet_name}' sheet {status} identical"))
  }
}

dates_to_character <- function(df, ...) {
  mutate(df,
         across(.cols = c(...),
                function(x)
                  x = as.character(x)
         ))
}



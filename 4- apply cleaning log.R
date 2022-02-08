# load required packages --------------------------------------------------
source("R/required_packages.R")
source("R/custom_functions.R")

# read merged data sets --------------------------------------------------
path <- "output/merged data forms/"
forms <- list.files(path, pattern = "*.xlsx")
data <- list()
output_path <- "output/merge data forms_applied cleaning log/"

for (form in forms) {
  file_name <- glue::glue("{path}{form}")
  data[[str_remove(form, "_merge.xlsx|.xlsx")]] <- read_excel_func(file_name)
}

names(data)
rm("file_name", "form", "forms", "path", "check_column_names", "dates_to_character", "read_excel_func")

# read the cleaning log --------------------------------------------------
url <- "https://docs.google.com/spreadsheets/d/1GxSV76XoQSBF45zmd8r1LX7r3cUQWB1I7aJ7b9KA51U/edit#gid=0"
browseURL(url)
cleaning_log <- googlesheets4::read_sheet(url, sheet = "cleaning_log", col_types = "c")
count(cleaning_log, changed)
cleaning_log <- cleaning_log %>% filter(changed == "Yes") %>% 
  mutate(uuid = str_trim(uuid))

# check the dataset names & sheet names in cleaning log and merged datasets --------------------------------------------------
sheet_names <- c()
for (i in names(data)) {
  sheet_names <- c(sheet_names, names(data[[i]]))
}

unique(cleaning_log$sheet_name)[!unique(cleaning_log$sheet_name) %in% sheet_names]
unique(cleaning_log$dataset_name)[!unique(cleaning_log$dataset_name) %in% names(data)]

data[["CPI_Border_Count_of_Transport_Traffic_Dataset"]][["data"]] <- data[["CPI_Border_Count_of_Transport_Traffic_Dataset"]][["data"]] %>% 
  mutate(Number_of_TPMA_visits_by_Sector = as.numeric(Number_of_TPMA_visits_by_Sector))

# apply cleaning log -------------------------------------------------
count <- 1
for (rowi in 1:nrow(cleaning_log)){
  uuid_i <- cleaning_log$uuid[rowi]
  var_i  <- cleaning_log$question[rowi]
  old_i  <- cleaning_log$old_value[rowi]
  question_type <- cleaning_log$question_type[rowi]
  
  if (question_type == "numeric") {
    new_i  <- as.numeric(cleaning_log$new_value[rowi])
  } else {
    new_i  <- cleaning_log$new_value[rowi]
  }
  
  form_i  <- cleaning_log$dataset_name[rowi]
  sheet_i <- cleaning_log$sheet_name[rowi]
  
  print(count);count <- count + 1
  print(glue::glue("data:{form_i}, sheet:{sheet_i} - {old_i} changed to {new_i} for {var_i} in {uuid_i}"))
  
  data[[form_i]][[sheet_i]][data[[form_i]][[sheet_i]]$KEY == uuid_i, var_i] <- new_i
}

# export files  -------------------------------------------------

## data sets
for (i in names(data)) {
  print(i)
  writexl::write_xlsx(data[[i]], glue::glue("{output_path}{i}_merge_applied cleaning log.xlsx"))
}

## cleaning log
writexl::write_xlsx(select(cleaning_log, 1:13), glue::glue("{output_path}cleaning_log.xlsx"))



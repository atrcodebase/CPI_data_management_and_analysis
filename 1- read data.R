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
  # print(glue::glue("# week: {weeks} ----------------------------------"))
  for (forms in names(weekly[[weeks]])) {
    # print(glue::glue("## form: {forms} -----------------"))
    for (sheets in names(weekly[[weeks]][[forms]])) {
      # print(glue::glue("### whitespaces removed from '{sheets}' sheet column names."))
      col_names <- colnames(weekly[[weeks]][[forms]][[sheets]])
      colnames(weekly[[weeks]][[forms]][[sheets]]) <- str_squish(col_names)
    }
  }
}

# Add missing columns --------------------------------------------------------------------
source("R/add_missing_columns.R")


# check whether the year, month & week columns are added in main sheet of each form in every week --------------------------------------------------
for (weeks in names(weekly)) {
  # print(glue::glue("# week: {weeks}"))
  for (forms in names(weekly[[weeks]])) {
    check <- all(c("year", "month", "week") %in% colnames(weekly[[weeks]][[forms]][[1]]))
    if (!check) {
      print(glue::glue("## (year/month/week) columns do NOT exist in {forms}: {weeks}"))
    } else {
      # print(glue::glue("## the 'year, month & week' columns exist in {forms}"))
    }
  }
}


# convert date columns to character format in main sheet of each form in every week --------------------------------------------------
date_columns <- c("SubmissionDate", "Starttime", "Endtime", "Date_And_Time")
for (weeks in names(weekly)) {
  print(glue::glue("# converting date columns to character in {weeks}"))
  for (forms in names(weekly[[weeks]])) {
    # print(glue::glue("## converting date columns to character in {forms}"))
    weekly[[weeks]][[forms]][[1]] <- dates_to_character(weekly[[weeks]][[forms]][[1]], all_of(date_columns))
  }
}

rm("file", "file_name", "path", "week", "weeks", "read_excel_func", 
   "forms", "date_columns", "dates_to_character", "col_names")

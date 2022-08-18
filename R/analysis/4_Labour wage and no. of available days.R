# daily rate ---------------
labour_atr <- labour_atr %>% 
  filter(Items %in% c("Mason", "Unskilled labourer", "Painter", "Tile worker", "Electrician", "Carpenter", "Plumber")) %>% 
  mutate(
    Items = case_when(
      Items != "Unskilled labourer" ~ "Skilled labourer",
      TRUE ~ Items
    ),
    month_name = month.name[as.numeric(month)]
  )

## by month
labour_wage_by_month_atr <- labour_atr %>% 
  group_by(
    year,     
    month = month_name,
    labour_type = Items
    ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, labour_type), names_to = "stats", values_to = "atr_values")

## by month and province
labour_wage_by_month_province_atr <- labour_atr %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    labour_type = Items
    ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, province, labour_type), names_to = "stats", values_to = "atr_values")

labour_wage_list <- list(
  by_month = labour_wage_by_month_atr,
  by_month_and_province = labour_wage_by_month_province_atr
)

# available days of employment --------------
### by month
labour_available_days_by_month_atr <- labour_atr %>% 
  group_by(
    year,     
    month = month_name,
    labour_type = Items
  ) %>%
  summarise(
    mean = round(mean(Labour_Weekly_Working_Days, na.rm = T), 2),
    median = round(median(Labour_Weekly_Working_Days, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, labour_type), names_to = "stats", values_to = "atr_values")

## by month and province
labour_available_days_by_month_province_atr <- labour_atr %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    labour_type = Items
  ) %>%
  summarise(
    mean = round(mean(Labour_Weekly_Working_Days, na.rm = T), 2),
    median = round(median(Labour_Weekly_Working_Days, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, province, labour_type), names_to = "stats", values_to = "atr_values")

labour_availability_list <- list(
  by_month = labour_available_days_by_month_atr,
  by_month_and_province = labour_available_days_by_month_province_atr
)




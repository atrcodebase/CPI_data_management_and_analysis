# daily rate ---------------
labour_atr <- labour_atr %>% 
  filter(Items %in% c("Mason", "Unskilled labourer", "Painter", "Tile worker", "Electrician", "Carpenter", "Plumber")) %>% 
  mutate(
    Items = case_when(
      Items != "Unskilled labourer" ~ "Skilled labourer",
      TRUE ~ Items
    )
  )

## by week
labour_wage_by_week_atr <- labour_atr %>% 
  group_by(
    week = week,
    labour_type = Items
    ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, labour_type), names_to = "stats", values_to = "atr_values")

## by week and province
labour_wage_by_week_province_atr <- labour_atr %>% 
  group_by(
    week = week,
    province = Province,
    labour_type = Items
    ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, province, labour_type), names_to = "stats", values_to = "atr_values")

labour_wage_list <- list(
  by_week = labour_wage_by_week_atr,
  by_week_and_province = labour_wage_by_week_province_atr
)

# available days of employment --------------
### by week
labour_available_days_by_week_atr <- labour_atr %>% 
  group_by(
    week = week,
    labour_type = Items
  ) %>%
  summarise(
    mean = round(mean(Labour_Weekly_Working_Days, na.rm = T), 2),
    median = round(median(Labour_Weekly_Working_Days, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, labour_type), names_to = "stats", values_to = "atr_values")

## by week and province
labour_available_days_by_week_province_atr <- labour_atr %>% 
  group_by(
    week = week,
    province = Province,
    labour_type = Items
  ) %>%
  summarise(
    mean = round(mean(Labour_Weekly_Working_Days, na.rm = T), 2),
    median = round(median(Labour_Weekly_Working_Days, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, province, labour_type), names_to = "stats", values_to = "atr_values")

labour_availability_list <- list(
  by_week = labour_available_days_by_week_atr,
  by_week_and_province = labour_available_days_by_week_province_atr
)




# exchange rate --------------
ime_atr <- ime_atr %>% 
  mutate(Currency_Availability = str_trim(gsub("\\(.*", "", Currency_Availability)))

## by week
ime_rate_by_week_atr <- ime_atr %>% 
  group_by(
    week = week,
    currency = Currency
  ) %>% 
  summarise(
    mean_buying = round(mean(Exchange_Rate_buying, na.rm = T), 3),
    mean_selling = round(mean(Exchange_Rate_selling, na.rm = T), 3),
    median_buying = round(median(Exchange_Rate_buying, na.rm = T), 3),
    median_selling = round(median(Exchange_Rate_selling, na.rm = T), 3)
  ) %>% 
  pivot_longer(-c(week, currency), names_to = "stats", values_to = "atr_values")

## by week and province
ime_rate_by_week_province_atr <- ime_atr %>% 
  group_by(
    week = week,
    province = Province,
    currency = Currency
  ) %>% 
  summarise(
    mean_buying = round(mean(Exchange_Rate_buying, na.rm = T), 3),
    mean_selling = round(mean(Exchange_Rate_selling, na.rm = T), 3),
    median_buying = round(median(Exchange_Rate_buying, na.rm = T), 3),
    median_selling = round(median(Exchange_Rate_selling, na.rm = T), 3)
  ) %>% 
  pivot_longer(-c(week, province, currency), names_to = "stats", values_to = "atr_values") %>% 
  filter(!is.na(atr_values))

ime_rate_list <- list(
  by_week = ime_rate_by_week_atr,
  by_week_and_province = ime_rate_by_week_province_atr
)

# availability ---------------------------
### by week
ime_availability_by_week_atr <- ime_atr %>% 
  group_by(
    week = week,
    currency = Currency
  ) %>% 
  count(availability = Currency_Availability) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100), n = NULL) %>% 
  ungroup()

### by week and province
ime_availability_by_week_province_atr <- ime_atr %>% 
  group_by(
    week = week,
    province = Province,
    currency = Currency
  ) %>% 
  count(availability = Currency_Availability) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100), n = NULL) %>% 
  ungroup()

ime_availability_list <- list(
  by_week = ime_availability_by_week_atr,
  by_week_and_province = ime_availability_by_week_province_atr
)






# exchange rate --------------
ime_atr <- rbind(ime_atr, ime_atr_v2)

ime_atr <- ime_atr %>% 
  mutate(Currency_Availability = str_trim(gsub("\\(.*", "", Currency_Availability)),
         month_name = month.name[as.numeric(month)])

ime_atr <- ime_atr %>% 
  mutate(across(c(Exchange_Rate_buying, Exchange_Rate_selling), function(x)
    x = as.numeric(x)
    ))
  
## by month
ime_rate_by_month_atr <- ime_atr %>%
  mutate(Exchange_Rate_buying = case_when(
    Currency == "Pakistani Rupees (PKR)" ~ Exchange_Rate_buying/1000,
    TRUE ~ Exchange_Rate_buying
  ),
  Exchange_Rate_selling = case_when(
    Currency == "Pakistani Rupees (PKR)" ~ Exchange_Rate_selling/1000,
    TRUE ~ Exchange_Rate_selling
  )) %>% 
  group_by(
    year,
    month = month_name,
    currency = Currency
  ) %>% 
  summarise(
    mean_buying = round(mean(Exchange_Rate_buying, na.rm = T), 2),
    mean_selling = round(mean(Exchange_Rate_selling, na.rm = T), 2),
    median_buying = round(median(Exchange_Rate_buying, na.rm = T), 2),
    median_selling = round(median(Exchange_Rate_selling, na.rm = T), 2)
  ) %>% 
  pivot_longer(-c(year, month, currency), names_to = "stats", values_to = "atr_values")

## by month and province
ime_rate_by_month_province_atr <- ime_atr %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    currency = Currency
  ) %>% 
  summarise(
    mean_buying = round(mean(Exchange_Rate_buying, na.rm = T), 2),
    mean_selling = round(mean(Exchange_Rate_selling, na.rm = T), 2),
    median_buying = round(median(Exchange_Rate_buying, na.rm = T), 2),
    median_selling = round(median(Exchange_Rate_selling, na.rm = T), 2)
  ) %>% 
  pivot_longer(-c(year, month, province, currency), names_to = "stats", values_to = "atr_values") %>% 
  filter(!is.na(atr_values))

ime_rate_list <- list(
  by_month = ime_rate_by_month_atr,
  by_month_and_province = ime_rate_by_month_province_atr
)

# availability ---------------------------
### by month
ime_availability_by_month_atr <- ime_atr %>% 
  group_by(
    year,     
    month = month_name,
    currency = Currency
  ) %>% 
  count(availability = Currency_Availability) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup()

### by month and province
ime_availability_by_month_province_atr <- ime_atr %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    currency = Currency
  ) %>% 
  count(availability = Currency_Availability) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup()

ime_availability_list <- list(
  by_month = ime_availability_by_month_atr,
  by_month_and_province = ime_availability_by_month_province_atr
)






# FI prices -------------------------------------
fi_atr <- fi_atr %>% 
  mutate(
    Availability_FI = str_trim(gsub("\\(.*", "", Availability_FI)),
    Items = case_when(
      Items %in% c("Nan (small loaf)", "bread") ~ "Nan (bread)",
      TRUE ~ Items
    ),
    month = as.numeric(month),
    month_name = month.name[month]
  )

## by month
fi_prices_by_month_atr <- fi_atr %>% 
  group_by(year,
           month = month_name,
           items = Items) %>% 
  summarise(
    mean = round(mean(PRICE_FI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_FI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, items), names_to = "stats", values_to = "atr_values")

## by month and province
fi_prices_by_month_province_atr <- fi_atr %>% 
  group_by(year, 
           month = month_name,
           province = Province,
           items = Items) %>% 
  summarise(
    mean = round(mean(PRICE_FI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_FI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, province, items), names_to = "stats", values_to = "atr_values")

FI_prices_list <- list(
  by_month = fi_prices_by_month_atr,
  by_month_and_province = fi_prices_by_month_province_atr
)

# compare FI availablity -------------------------------------
## by month
fi_availability_by_month_atr <- fi_atr %>% 
  group_by(
    year,
    month = month_name,
    items = Items) %>% 
  count(availability = Availability_FI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2)) %>% 
  ungroup()

## by month and province
fi_availability_by_month_province_atr <- fi_atr %>% 
  group_by(
    year,
    month = month_name,
    province = Province,
    items = Items) %>% 
  count(availability = Availability_FI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2)) %>% 
  ungroup()

FI_availability_list <- list(
  by_month = fi_availability_by_month_atr,
  by_month_and_provincde = fi_availability_by_month_province_atr
)


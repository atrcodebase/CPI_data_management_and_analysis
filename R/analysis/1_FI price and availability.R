# FI prices -------------------------------------
fi_atr <- fi_atr %>% 
  mutate(
    Availability_FI = str_trim(gsub("\\(.*", "", Availability_FI)),
    Items = case_when(
      Items %in% c("Nan (small loaf)", "bread") ~ "Nan (bread)",
      TRUE ~ Items
    )
  )

## by week
fi_prices_by_week_atr <- fi_atr %>% 
  group_by(week = week,
           items = Items
           ) %>% 
  summarise(
    mean = round(mean(PRICE_FI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_FI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, items), names_to = "stats", values_to = "atr_values")

## by week and province
fi_prices_by_week_province_atr <- fi_atr %>% 
  group_by(week = week,
           province = Province,
           items = Items) %>% 
  summarise(
    mean = round(mean(PRICE_FI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_FI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, province, items), names_to = "stats", values_to = "atr_values")

FI_prices_list <- list(
  by_week = fi_prices_by_week_atr,
  by_week_and_province = fi_prices_by_week_province_atr
)

# compare FI availablity -------------------------------------
## by week
fi_availability_by_week_atr <- fi_atr %>% 
  group_by(
    week = week,
    items = Items
    ) %>% 
  count(availability = Availability_FI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup()

## by week and province
fi_availability_by_week_province_atr <- fi_atr %>% 
  group_by(
    week = week,
    province = Province,
    items = Items
    ) %>% 
  count(availability = Availability_FI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup()

FI_availability_list <- list(
  by_week = fi_availability_by_week_atr,
  by_week_and_provincde = fi_availability_by_week_province_atr
)


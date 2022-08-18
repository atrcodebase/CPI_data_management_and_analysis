## FI prices and availability comparative analysis
fi_atr <- fi_atr %>% 
  mutate(
    Availability_FI = str_trim(gsub("\\(.*", "", Availability_FI)),
    Items = case_when(
      Items %in% c("Nan (small loaf)", "bread") ~ "Nan (bread)",
      TRUE ~ Items
    ), 
    month_name = month.name[as.numeric(month)])

fi_integrity <- fi_integrity %>%
  mutate(STANDARDIZED_PRICE_UNIT = as.numeric(STANDARDIZED_PRICE_UNIT)) %>% 
  mutate(Item_availability = str_trim(gsub("\\(.*", "", Item_availability))) %>% 
  mutate(month = `Reporting Month`, year = `Reporting Year`)

fi_atr_filtered <- fi_atr %>% filter(month_name %in% unique(fi_integrity$month))

# FI prices -------------------------------------
## by month
fi_prices_by_month_atr <- fi_atr_filtered %>% 
  group_by(year, 
           month = month_name,
           items = Items
  ) %>% 
  summarise(
    mean = round(mean(PRICE_FI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_FI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, items), names_to = "stats", values_to = "atr_values")

fi_prices_by_month_integrity <- fi_integrity %>% 
  group_by(year,
           month,
           items = `Selected Item`
  ) %>% 
  summarise(
    mean = round(mean(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
    median = round(median(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  filter(!is.na(items)) %>% 
  pivot_longer(-c(year, month, items), names_to = "stats", values_to = "integrity_values")

fi_prices_by_month_merged <- full_join(fi_prices_by_month_integrity, fi_prices_by_month_atr,
                                      by = c("year", "month", "items", "stats"))

all(sapply(list(nrow(fi_prices_by_month_integrity), nrow(fi_prices_by_month_atr)),
           FUN = identical, nrow(fi_prices_by_month_merged)))

## by month and province
fi_prices_by_month_province_atr <- fi_atr_filtered %>% 
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

fi_prices_by_month_province_integrity <- fi_integrity %>% 
  group_by(year,            
           month,
           province = Province,
           items = `Selected Item`) %>% 
  summarise(
    mean = round(mean(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
    median = round(median(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  filter(!is.na(items)) %>% 
  pivot_longer(-c(year, month, province, items), names_to = "stats", values_to = "integrity_values")

fi_prices_by_month_province_merged <- full_join(fi_prices_by_month_province_integrity, fi_prices_by_month_province_atr,
                                               by = c("year", "month", "province", "items", "stats"))

all(sapply(list(nrow(fi_prices_by_month_province_integrity), nrow(fi_prices_by_month_province_atr)),
           FUN = identical, nrow(fi_prices_by_month_province_merged)))

diff_in_FI_prices <- list(
  by_month = fi_prices_by_month_merged %>%
    mutate(is_equal = near(integrity_values, atr_values)),
  
  by_month_and_province = fi_prices_by_month_province_merged %>% 
    filter(!(is.na(integrity_values) & is.na(atr_values))) %>%
    mutate(is_equal = near(integrity_values, atr_values))
)

# compare FI availablity -------------------------------------
## by month
fi_availability_by_month_atr <- fi_atr_filtered %>% 
  group_by(
    year,             
    month = month_name,
    items = Items
  ) %>% 
  count(availability = Availability_FI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup()

fi_availability_by_month_integrity <- fi_integrity %>% 
  group_by(
    year,            
    month,
    items = `Selected Item`
  ) %>% 
  count(availability = Item_availability) %>% 
  mutate(integrity_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup() %>% 
  filter(!is.na(items))

fi_availability_by_month_merged <- full_join(fi_availability_by_month_integrity, fi_availability_by_month_atr,
                                            by = c("year", "month", "items", "availability"))

all(sapply(list(nrow(fi_availability_by_month_integrity), nrow(fi_availability_by_month_atr)),
           FUN = identical, nrow(fi_availability_by_month_merged)))

## by month and province
fi_availability_by_month_province_atr <- fi_atr_filtered %>% 
  group_by(
    year,             
    month = month_name,
    province = Province,
    items = Items
  ) %>% 
  count(availability = Availability_FI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup()

fi_availability_by_month_province_integrity <- fi_integrity %>% 
  group_by(
    year,            
    month,
    province = Province,
    items = `Selected Item`
  ) %>% 
  count(availability = Item_availability) %>% 
  mutate(integrity_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup() %>% 
  filter(!is.na(items))

fi_availability_by_month_province_merged <- full_join(fi_availability_by_month_province_integrity, fi_availability_by_month_province_atr,
                                                     by = c("year", "month", "province", "items", "availability"))

all(sapply(list(nrow(fi_availability_by_month_province_integrity), nrow(fi_availability_by_month_province_atr)),
           FUN = identical, nrow(fi_availability_by_month_province_merged)))

diff_in_FI_availability <- list(
  by_month = fi_availability_by_month_merged %>%
    mutate(is_equal = near(integrity_percent, atr_percent))
  ,
  by_month_and_provincde = fi_availability_by_month_province_merged %>% 
    filter(!(is.na(integrity_percent) & is.na(atr_percent))) %>% 
    mutate(is_equal = near(integrity_percent, atr_percent))
)

# 23.83 == 23.86
# round(23.83, 1) == round(23.86, 1)
# near(23.83, 23.86, tol = 0.1)

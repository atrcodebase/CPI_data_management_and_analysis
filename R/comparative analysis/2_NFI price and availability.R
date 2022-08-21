nfi_atr <- nfi_atr %>% 
  filter(!Items %in% c("Painter", "Unskilled labourer", "Tile worker", "Plumber", "Electrician", "Carpenter", "Mason")) %>% 
  mutate(
    Items = case_when(
      Items %in% c("Shared rickshaw", "Shared taxi", "Shared van", "Shared taxi/van/risckshaw  driver") ~ "Shared taxi/van/rickshaw",
      TRUE ~ Items
    ),
    Availability_NFI = str_trim(gsub("\\(.*", "", Availability_NFI)), 
    month_name = month.name[as.numeric(month)]
  )

nfi_integrity <- nfi_integrity %>% 
  mutate(
    STANDARDIZED_PRICE_UNIT = as.numeric(STANDARDIZED_PRICE_UNIT),
    Item_or_service_availability = str_trim(gsub("\\(.*", "", `Item or Service Availability`)),
    `Selected Item` = case_when(
      `Selected Item` == "3-room apartment" ~ "3 Bedroom house",
      `Selected Item` == "4-room apartment" ~ "4 Bedroom house",
      `Selected Item` == "a consultation with a doctor at this facility" ~ "Doctor Consultation Fee",
      TRUE ~ `Selected Item`
    )) %>%
  mutate(month = `Reporting Month`, year = `Reporting Year`)

telecom_atr_filtered <- telecom_atr %>% 
  mutate(month_name = month.name[as.numeric(month)]) %>% 
  filter(month_name %in% unique(nfi_integrity$month))
  
nfi_atr_filtered <- nfi_atr %>%  
  filter(month_name %in% unique(nfi_integrity$month))

# NFI prices ---------------------------
## by month
nfi_prices_by_month_atr <- nfi_atr_filtered %>% 
  group_by(
    year,
    month = month_name,
    items = Items
  ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, items), names_to = "stats", values_to = "atr_values")

nfi_prices_by_month_atr <- rbind(
  nfi_prices_by_month_atr
  ,
  rbind(
    telecom_atr_filtered %>% 
      group_by(
        year,     
        month = month_name,
        stats = "mean"
      ) %>% 
      summarise(
        "national calls within your company network" = round(mean(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(mean(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
    ,
    telecom_atr_filtered %>% 
      group_by(
        year,     
        month = month_name,
        stats = "median"
      ) %>% 
      summarise(
        "national calls within your company network" = round(median(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(median(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
  ) %>% 
    pivot_longer(-c(year, month, stats), names_to = "items", values_to = "atr_values")
)


nfi_prices_by_month_integrity <- nfi_integrity %>% 
  group_by(
    year,
    month,
    items = `Selected Item`
  ) %>% 
  summarise(
    mean = round(mean(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
    median = round(median(STANDARDIZED_PRICE_UNIT, na.rm = T), 2)
  ) %>% 
  ungroup() %>% 
  filter(!is.na(items)) %>% 
  pivot_longer(-c(year, month, items), names_to = "stats", values_to = "integrity_values")

nfi_price_by_month_merge <- full_join(nfi_prices_by_month_integrity, nfi_prices_by_month_atr,
                                     by = c("year", "month", "items", "stats"))

## by month and province
nfi_prices_by_month_province_atr <- nfi_atr_filtered %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    items = Items
  ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(year, month, province, items), names_to = "stats", values_to = "atr_values") %>% 
  filter(!is.na(atr_values))

nfi_prices_by_month_province_atr <- rbind(
  nfi_prices_by_month_province_atr
  ,
  rbind(
    telecom_atr_filtered %>% 
      group_by(
        year,     
        month = month_name,
        province = Province,
        stats = "mean"
      ) %>% 
      summarise(
        "national calls within your company network" = round(mean(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(mean(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
    ,
    telecom_atr_filtered %>% 
      group_by(
        year,     
        month = month_name,
        province = Province,
        stats = "median"
      ) %>% 
      summarise(
        "national calls within your company network" = round(median(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(median(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
  ) %>% 
    pivot_longer(-c(year, month, province, stats), names_to = "items", values_to = "atr_values")
)


nfi_prices_by_month_province_integrity <- nfi_integrity %>% 
  group_by(
    year,     
    month,
    province = Province,
    items = `Selected Item`
  ) %>% 
  summarise(
    mean = round(mean(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
    median = round(median(STANDARDIZED_PRICE_UNIT, na.rm = T), 2)
  ) %>% 
  ungroup() %>% 
  filter(!is.na(items)) %>% 
  pivot_longer(-c(year, month, items, province), names_to = "stats", values_to = "integrity_values")

nfi_price_by_month_province_merge <- full_join(nfi_prices_by_month_province_integrity, nfi_prices_by_month_province_atr,
                                              by = c("year", "month", "province", "items", "stats"))

diff_in_NFI_prices <- list(
  by_month = nfi_price_by_month_merge %>%
    mutate(is_equal = near(integrity_values, atr_values))
  ,
  
  by_month_and_province = nfi_price_by_month_province_merge %>% 
    filter(!(is.na(integrity_values) & is.na(atr_values))) %>% 
    mutate(is_equal = near(integrity_values, atr_values))
)


# NFI availablity ----------------------
## by month
nfi_availability_by_month_atr <- nfi_atr_filtered %>% 
  group_by(
    year,     
    month = month_name,
    items = Items
  ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2)) %>% 
  rename(atr_freq=n) %>% 
  ungroup() %>% 
  filter(!is.na(availability))

nfi_availability_by_month_integrity <- nfi_integrity %>% 
  group_by(
    year,     
    month,
    items = `Selected Item`
  ) %>%
  count(availability = Item_or_service_availability) %>% 
  mutate(integrity_percent = round(n/sum(n)*100, 2)) %>% 
  rename(integrity_freq=n) %>% 
  ungroup() %>% 
  filter(!(is.na(items) | is.na(availability)))

nfi_availability_by_month_merged <- full_join(nfi_availability_by_month_integrity, nfi_availability_by_month_atr,
                                             by = c("year", "month", "items", "availability"))

## by month and province
nfi_availability_by_month_province_atr <- nfi_atr_filtered %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    items = Items
  ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  filter(!is.na(availability)) %>% 
  ungroup()

nfi_availability_by_month_province_integrity <- nfi_integrity %>% 
  group_by(
    year,     
    month,
    province = Province,
    items = `Selected Item`
  ) %>%
  count(availability = Item_or_service_availability) %>% 
  mutate(integrity_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup() %>% 
  filter(!(is.na(items) | is.na(availability)))

nfi_availability_by_month_province_merged <- full_join(nfi_availability_by_month_province_integrity, nfi_availability_by_month_province_atr,
                                                      by = c("year", "month", "province", "items", "availability"))

diff_in_NFI_availability <- list(
  by_month = nfi_availability_by_month_merged %>%
    mutate(is_equal = near(integrity_percent, atr_percent))
  ,
  by_month_and_provincde = nfi_availability_by_month_province_merged %>%
    filter(!(is.na(integrity_percent) & is.na(atr_percent))) %>% 
    mutate(is_equal = near(integrity_percent, atr_percent))
)


nfi_atr <- nfi_atr %>% 
  filter(!Items %in% c("Painter", "Unskilled labourer", "Tile worker", "Plumber", "Electrician", "Carpenter", "Mason")) %>% 
  mutate(
    Items = case_when(
      Items %in% c("Shared rickshaw", "Shared taxi", "Shared van", "Shared taxi/van/risckshaw  driver") ~ "Shared taxi/van/rickshaw",
      TRUE ~ Items
    ),
    Availability_NFI = str_trim(gsub("\\(.*", "", Availability_NFI))
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
    ),
    week = `Reporting Week`
  )

telecom_atr <- telecom_atr %>% filter(week %in% unique(nfi_integrity$week))
nfi_atr <- nfi_atr %>%  filter(week %in% unique(nfi_integrity$week))

# NFI prices ---------------------------
## by week
nfi_prices_by_week_atr <- nfi_atr %>% 
  group_by(
    week = week,
    items = Items
  ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, items), names_to = "stats", values_to = "atr_values")

nfi_prices_by_week_atr <- rbind(
  nfi_prices_by_week_atr
  ,
  rbind(
    telecom_atr %>% 
      group_by(
        week = week,
        stats = "mean"
      ) %>% 
      summarise(
        "national calls within your company network" = round(mean(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(mean(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
    ,
    telecom_atr %>% 
      group_by(
        week = week,
        stats = "median"
      ) %>% 
      summarise(
        "national calls within your company network" = round(median(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(median(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
  ) %>% 
    pivot_longer(-c(week, stats), names_to = "items", values_to = "atr_values")
)


nfi_prices_by_week_integrity <- nfi_integrity %>% 
  group_by(
    week = as.character(week),
    items = `Selected Item`
  ) %>% 
  summarise(
    mean = round(mean(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
    median = round(median(STANDARDIZED_PRICE_UNIT, na.rm = T), 2)
  ) %>% 
  ungroup() %>% 
  filter(!is.na(items)) %>% 
  pivot_longer(-c(week, items), names_to = "stats", values_to = "integrity_values")

nfi_price_by_week_merge <- full_join(nfi_prices_by_week_integrity, nfi_prices_by_week_atr,
                                     by = c("week", "items", "stats"))

## by week and province
nfi_prices_by_week_province_atr <- nfi_atr %>% 
  group_by(
    week = week,
    province = Province,
    items = Items
  ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 2),
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, province, items), names_to = "stats", values_to = "atr_values") %>% 
  filter(!is.na(atr_values))

nfi_prices_by_week_province_atr <- rbind(
  nfi_prices_by_week_province_atr
  ,
  rbind(
    telecom_atr %>% 
      group_by(
        week = week,
        province = Province,
        stats = "mean"
      ) %>% 
      summarise(
        "national calls within your company network" = round(mean(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(mean(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
    ,
    telecom_atr %>% 
      group_by(
        week = week,
        province = Province,
        stats = "median"
      ) %>% 
      summarise(
        "national calls within your company network" = round(median(Cost_Min_National_Call_within_Netwokrs, na.rm = T), 2),
        "national calls to other networks" = round(median(Cost_Min_National_Call_Other_Netwokrs, na.rm = T), 2),
      )
  ) %>% 
    pivot_longer(-c(week, province, stats), names_to = "items", values_to = "atr_values")
)


nfi_prices_by_week_province_integrity <- nfi_integrity %>% 
  group_by(
    week = as.character(week),
    province = Province,
    items = `Selected Item`
  ) %>% 
  summarise(
    mean = round(mean(STANDARDIZED_PRICE_UNIT, na.rm = T), 2),
    median = round(median(STANDARDIZED_PRICE_UNIT, na.rm = T), 2)
  ) %>% 
  ungroup() %>% 
  filter(!is.na(items)) %>% 
  pivot_longer(-c(week, items, province), names_to = "stats", values_to = "integrity_values")

nfi_price_by_week_province_merge <- full_join(nfi_prices_by_week_province_integrity, nfi_prices_by_week_province_atr,
                                              by = c("week", "province", "items", "stats"))

diff_in_NFI_prices <- list(
  by_week = nfi_price_by_week_merge %>%
    mutate(is_equal = near(integrity_values, atr_values))
  ,
  
  by_week_and_province = nfi_price_by_week_province_merge %>% 
    filter(!(is.na(integrity_values) & is.na(atr_values))) %>% 
    mutate(is_equal = near(integrity_values, atr_values))
)


# NFI availablity ----------------------
## by week
nfi_availability_by_week_atr <- nfi_atr %>% 
  group_by(
    week = week,
    items = Items
  ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup() %>% 
  filter(!is.na(availability))

nfi_availability_by_week_integrity <- nfi_integrity %>% 
  group_by(
    week = as.character(week),
    items = `Selected Item`
  ) %>%
  count(availability = Item_or_service_availability) %>% 
  mutate(integrity_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup() %>% 
  filter(!(is.na(items) | is.na(availability)))

nfi_availability_by_week_merged <- full_join(nfi_availability_by_week_integrity, nfi_availability_by_week_atr,
                                             by = c("week", "items", "availability"))

## by week and province
nfi_availability_by_week_province_atr <- nfi_atr %>% 
  group_by(
    week = week,
    province = Province,
    items = Items
  ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  filter(!is.na(availability)) %>% 
  ungroup()

nfi_availability_by_week_province_integrity <- nfi_integrity %>% 
  group_by(
    week = as.character(week),
    province = Province,
    items = `Selected Item`
  ) %>%
  count(availability = Item_or_service_availability) %>% 
  mutate(integrity_percent = round(n/sum(n)*100, 2), n = NULL) %>% 
  ungroup() %>% 
  filter(!(is.na(items) | is.na(availability)))

nfi_availability_by_week_province_merged <- full_join(nfi_availability_by_week_province_integrity, nfi_availability_by_week_province_atr,
                                                      by = c("week", "province", "items", "availability"))

diff_in_NFI_availability <- list(
  by_week = nfi_availability_by_week_merged %>%
    mutate(is_equal = near(integrity_percent, atr_percent))
  ,
  by_week_and_provincde = nfi_availability_by_week_province_merged %>%
    filter(!(is.na(integrity_percent) & is.na(atr_percent))) %>% 
    mutate(is_equal = near(integrity_percent, atr_percent))
)


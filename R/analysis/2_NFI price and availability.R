# NFI prices ---------------------------
nfi_atr <- nfi_atr %>% 
  filter(!Items %in% c("Painter", "Unskilled labourer", "Tile worker", "Plumber", "Electrician", "Carpenter", "Mason")) %>% 
  mutate(
    Items = case_when(
      Items %in% c("Shared rickshaw", "Shared taxi", "Shared van", "Shared taxi/van/risckshaw  driver") ~ "Shared taxi/van/risckshaw driver",
      TRUE ~ Items
    ),
    Availability_NFI = str_trim(gsub("\\(.*", "", Availability_NFI))
  )


## by week
nfi_prices_by_week_atr <- nfi_atr %>% 
  group_by(
    week = week,
    items = Items
  ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 1),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 1),
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
        "national calls within your company network" = round(mean(Cost_Min_National_Call_within_Netwokrs, na.rm = T)),
        "national calls to other networks" = round(mean(Cost_Min_National_Call_Other_Netwokrs, na.rm = T)),
      )
    ,
    telecom_atr %>% 
      group_by(
        week = week,
        stats = "median"
      ) %>% 
      summarise(
        "national calls within your company network" = round(median(Cost_Min_National_Call_within_Netwokrs, na.rm = T)),
        "national calls to other networks" = round(median(Cost_Min_National_Call_Other_Netwokrs, na.rm = T)),
      )
  ) %>% 
    pivot_longer(-c(week, stats), names_to = "items", values_to = "atr_values")
)


## by week and province
nfi_prices_by_week_province_atr <- nfi_atr %>% 
  group_by(
    week = week,
    province = Province,
    items = Items
  ) %>% 
  summarise(
    mean = round(mean(PRICE_NFI_STANDARDIZED, na.rm = T), 1),
    median = round(median(PRICE_NFI_STANDARDIZED, na.rm = T), 1),
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
        "national calls within your company network" = round(mean(Cost_Min_National_Call_within_Netwokrs, na.rm = T)),
        "national calls to other networks" = round(mean(Cost_Min_National_Call_Other_Netwokrs, na.rm = T)),
      )
    ,
    telecom_atr %>% 
      group_by(
        week = week,
        province = Province,
        stats = "median"
      ) %>% 
      summarise(
        "national calls within your company network" = round(median(Cost_Min_National_Call_within_Netwokrs, na.rm = T)),
        "national calls to other networks" = round(median(Cost_Min_National_Call_Other_Netwokrs, na.rm = T)),
      )
  ) %>% 
    pivot_longer(-c(week, province, stats), names_to = "items", values_to = "atr_values")
)


NFI_prices_list <- list(
  by_week = nfi_prices_by_week_atr,
  by_week_and_province = nfi_prices_by_week_province_atr
)

# NFI availablity ----------------------
## by week
nfi_availability_by_week_atr <- nfi_atr %>% 
  group_by(
    week = week,
    items = Items
    ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100), n = NULL) %>% 
  ungroup() %>% 
  filter(!is.na(availability))

## by week and province
nfi_availability_by_week_province_atr <- nfi_atr %>% 
  group_by(
    week = week,
    province = Province,
    items = Items
    ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100), n = NULL) %>% 
  filter(!is.na(availability)) %>% 
  ungroup()

NFI_availability_list <- list(
  by_week = nfi_availability_by_week_atr,
  by_week_and_provincde = nfi_availability_by_week_province_atr
)








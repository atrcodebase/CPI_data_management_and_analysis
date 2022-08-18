# NFI prices ---------------------------
nfi_atr <- nfi_atr %>% 
  filter(!Items %in% c("Painter", "Unskilled labourer", "Tile worker", "Plumber", "Electrician", "Carpenter", "Mason")) %>% 
  mutate(
    Items = case_when(
      Items %in% c("Shared rickshaw", "Shared taxi", "Shared van", "Shared taxi/van/risckshaw  driver") ~ "Shared taxi/van/risckshaw driver",
      TRUE ~ Items
    ),
    Availability_NFI = str_trim(gsub("\\(.*", "", Availability_NFI)),
    month = as.numeric(month),
    month_name = month.name[month]
  )
telecom_atr <- telecom_atr %>% 
  mutate(month = as.numeric(month),
         month_name = month.name[month])

## by month
nfi_prices_by_month_atr <- nfi_atr %>% 
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
    telecom_atr %>% 
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
    telecom_atr %>% 
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


## by month and province
nfi_prices_by_month_province_atr <- nfi_atr %>% 
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
    telecom_atr %>% 
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
    telecom_atr %>% 
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


NFI_prices_list <- list(
  by_month = nfi_prices_by_month_atr,
  by_month_and_province = nfi_prices_by_month_province_atr
)

# NFI availablity ----------------------
## by month
nfi_availability_by_month_atr <- nfi_atr %>% 
  group_by(
    year,     
    month = month_name,
    items = Items
    ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2)) %>% 
  ungroup() %>% 
  filter(!is.na(availability))

## by month and province
nfi_availability_by_month_province_atr <- nfi_atr %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    items = Items
    ) %>%
  count(availability = Availability_NFI) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2)) %>% 
  filter(!is.na(availability)) %>% 
  ungroup()

NFI_availability_list <- list(
  by_month = nfi_availability_by_month_atr,
  by_month_and_provincde = nfi_availability_by_month_province_atr
)








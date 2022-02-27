# Border crossing: Trucks -------------
trucks <- rbind(
  border_driver_survey %>% 
    select(week, enter_exist, TPMA_Location_Name)
  ,
  border_traffice_count_atr %>% 
    select(week, enter_exist, TPMA_Location_Name)
)

trucks_transit_portion <- border_traffice_count_atr %>% 
  mutate(transit_portion = case_when(
    !is.na(transport_third_country_or_to_AFG) ~ transport_third_country_or_to_AFG,
    !is.na(transport_third_country_or_to_AFG_from_second_country) ~ transport_third_country_or_to_AFG_from_second_country
  )) %>% 
  select(week, transit_portion) %>% 
  filter(!is.na(transit_portion))

## by week
border_crossing_trucks_by_week_atr <- trucks %>% 
  group_by(week = week) %>% 
  count(enter_exist) %>% 
  ungroup() %>% 
  drop_na() %>% 
  rename(atr_freq = n)

## by week and location
border_crossing_trucks_by_week_and_location_atr <- trucks %>% 
  group_by(
    week = week,
    location = TPMA_Location_Name
    ) %>% 
  count(enter_exist) %>% 
  ungroup() %>% 
  drop_na() %>% 
  rename(atr_freq = n)

## by week
trucks_transit_portion_by_week_atr <- trucks_transit_portion %>% 
  group_by(week = week) %>% 
  count(transit_portion) %>% 
  mutate(atr_percent = round((n/sum(n))*100,1)) %>% 
  ungroup() %>% 
  rename(atr_freq = n)

border_crossing_trucks_list <- list(
  by_week = border_crossing_trucks_by_week_atr,
  by_week_and_location = border_crossing_trucks_by_week_and_location_atr,
  trucks_transit_portion = trucks_transit_portion_by_week_atr
)

# Border crossing: Tonnage -------------
border_driver_survey <- border_driver_survey %>% 
  mutate(tonnage = case_when(
    goods == "Food" ~ if_food,
    goods == "Fuel" ~ if_fuel,
    goods == "Medicine" ~ if_medicine
  ))

# by week
border_crossing_tonnage_by_week_atr <- border_driver_survey %>% 
  group_by(week, goods, enter_exist) %>% 
  summarise(
    total_tonnage = sum(tonnage, na.rm = T),
    mean_tonnage = round(mean(tonnage, na.rm = T), 0)
  ) %>% 
  filter(!goods %in% c("No", NA)) %>% 
  pivot_longer(-c(week, goods, enter_exist), names_to = "stats", values_to = "atr_values")

# by week and province
border_crossing_tonnage_by_week_and_province_atr <- border_driver_survey %>% 
  group_by(week, Province, goods, enter_exist) %>% 
  summarise(
    total_tonnage = sum(tonnage, na.rm = T),
    mean_tonnage = round(mean(tonnage, na.rm = T), 0)
  ) %>% 
  filter(!goods %in% c("No", NA)) %>% 
  pivot_longer(-c(week, Province, goods, enter_exist), names_to = "stats", values_to = "atr_values")

border_crossing_tonnage_list <- list(
  by_week = border_crossing_tonnage_by_week_atr,
  by_week_and_province = border_crossing_tonnage_by_week_and_province_atr
)

# Border crossing: Taxes -------------
## proportion of trucks in transit
trucks_in_transit <- rbind(
  border_driver_survey %>% 
    mutate(
      is_transit = case_when(
        transported_load_transit == "No, my destination is to/from Afghanistan" ~ "Destination to/from Afghanistan",
        transported_load_transit == "Yes, my transported load is in transit to/from another country" ~ "In transit"
      )
    ) %>% 
    select(week, Province, enter_exist, is_transit)
  ,
  border_traffice_count_atr %>%
    mutate(
      is_transit = case_when(
        enter_exist == "Vehicles that are entering Afghanistan" ~ transport_third_country_or_to_AFG,
        enter_exist == "Vehicles that are exiting Afghanistan" ~ transport_third_country_or_to_AFG_from_second_country
      )
    ) %>% 
    mutate(is_transit = case_when(
      is_transit %in% c("No, my destination is directly from Afghanistan to a second country",
                        "No, my final destination is to Afghanistan") ~ "Destination to/from Afghanistan",
      is_transit == "Yes, my transported load is in transit to a third country" ~ "In transit"
    )) %>%
    select(week, Province, enter_exist, is_transit) %>%
    filter(!is.na(is_transit))
)

# by week
trucks_in_transit_by_week_atr <- trucks_in_transit %>% 
  group_by(week) %>% 
  count(is_transit) %>% 
  drop_na() %>% 
  rename(atr_freq = n)

# by week and province
trucks_in_transit_by_week_and_province_atr <- trucks_in_transit %>% 
  group_by(week, Province) %>% 
  count(is_transit) %>% 
  drop_na() %>% 
  rename(atr_freq = n)

## proportion of drivers paying tax
# by week
drivers_paying_tax_by_week_atr <- border_driver_survey %>% 
  group_by(week, enter_exist) %>% 
  count(do_you_pay_tax) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100), n = NULL)

drivers_paying_tax_by_week_and_province_atr <- border_driver_survey %>% 
  group_by(week, Province, enter_exist) %>% 
  count(do_you_pay_tax) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100), n = NULL)

## average tax paid on goods
# by week
average_tax_paid_on_goods_by_week_atr <- border_driver_survey %>% 
  group_by(week, enter_exist, goods) %>% 
  summarise(atr_mean = round(mean(tax_amount, na.rm = T))) %>% 
  filter(!is.na(atr_mean))
# by week and province
average_tax_paid_on_goods_by_week_and_province_atr <- border_driver_survey %>% 
  group_by(week, Province, enter_exist, goods) %>% 
  summarise(atr_mean = round(mean(tax_amount, na.rm = T))) %>% 
  filter(!is.na(atr_mean))

border_crossing_taxes_list = list(
  trucks_in_transit_by_week = trucks_in_transit_by_week_atr,
  trucks_in_transit_week_province = trucks_in_transit_by_week_and_province_atr,
  drivers_paying_tax_by_week =  drivers_paying_tax_by_week_atr,
  drivers_paying_tax_weekProvince = drivers_paying_tax_by_week_and_province_atr,
  average_tax_paid_by_week = average_tax_paid_on_goods_by_week_atr,
  average_tax_paid_week_province = average_tax_paid_on_goods_by_week_and_province_atr
)

# Border crossing: Aid Commodities -------------
# by week
border_crossing_aid_commodities_by_week_atr <- rbind(
  border_traffice_count_atr %>% 
    group_by(week) %>% 
    count(
      question = "Is the vehicle transporting aid commodities?",
      response = Is_the_vehicle_transporting_aid_commodities
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(week) %>%
    count(
      question = "Number of trucks transporing aid commodities, by donor countries",
      response = Which_country
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(week) %>% 
    count(
      question = "Type of aid commodities",
      response = Type_Aid_Commodities
    ) %>% 
    drop_na()
) %>% 
  rename(atr_values = n)

# by week and province
border_crossing_aid_commodities_by_week_and_province_atr <- rbind(
  border_traffice_count_atr %>% 
    group_by(week, Province) %>% 
    count(
      question = "Is the vehicle transporting aid commodities?",
      response = Is_the_vehicle_transporting_aid_commodities
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(week, Province) %>%
    count(
      question = "Number of trucks transporing aid commodities, by donor countries",
      response = Which_country
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(week, Province) %>% 
    count(
      question = "Type of aid commodities",
      response = Type_Aid_Commodities
    ) %>% 
    drop_na()
) %>% 
  rename(atr_values = n)

border_crossing_aid_commodities_list <- list(
  by_week = border_crossing_aid_commodities_by_week_atr,
  by_week_and_province = border_crossing_aid_commodities_by_week_and_province_atr
)









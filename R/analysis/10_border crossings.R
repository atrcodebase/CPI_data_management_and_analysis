# Border crossing: Trucks -------------
# Number of trucks crossing the border
trucks <- rbind(
  border_driver_survey %>% 
    select(week, enter_exist, TPMA_Location_Name)
  ,
  border_traffice_count_atr %>% 
    select(week, enter_exist, TPMA_Location_Name)
)

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

# Proportion of trucks in transit
trucks_transit_portion <- rbind(
  border_traffice_count_atr %>% 
    mutate(transit_portion = case_when(
      transport_third_country_or_to_AFG %in% "No, my final destination is to Afghanistan" ~ "Entering trucks with Afghanistan as final destination",
      transport_third_country_or_to_AFG %in% "Yes, my transported load is in transit to a third country" ~ "Entering trucks in transit",
      transport_third_country_or_to_AFG_from_second_country %in% "No, my destination is directly from Afghanistan to a second country" ~ "Exiting trucks with Afghanistan as departure point",
      transport_third_country_or_to_AFG_from_second_country %in% "Yes, my transported load is in transit to a third country" ~ "Entering trucks in transit",
      is.na(transport_third_country_or_to_AFG) & is.na(transport_third_country_or_to_AFG_from_second_country) ~ "Destination not clear"
    )) %>% 
    select(week, Province, transit_portion)
  ,
  border_driver_survey %>% 
    mutate(transit_portion = case_when(
      transported_load_transit %in% "No, my destination is to/from Afghanistan" ~ "Entering trucks with Afghanistan as final destination",
      transported_load_transit %in% "Yes, my transported load is in transit to/from another country" ~ "Exiting trucks in transit from a third country",
      is.na(transported_load_transit) ~ "Destination not clear"
    )) %>% 
    select(week, Province, transit_portion)
) %>% filter(!is.na(transit_portion))

## by week
trucks_transit_portion_by_week_atr <- trucks_transit_portion %>% 
  group_by(week = week) %>% 
  count(transit_portion) %>% 
  mutate(atr_percent = round((n/sum(n))*100, 2), n = NULL)

## by week and province
trucks_transit_portion_by_week_province_atr <- trucks_transit_portion %>% 
  group_by(
    week = week,
    Province
  ) %>% 
  count(transit_portion) %>% 
  mutate(atr_percent = round((n/sum(n))*100, 2), n = NULL)

border_crossing_trucks_list <- list(
  by_week = border_crossing_trucks_by_week_atr,
  by_week_and_location = border_crossing_trucks_by_week_and_location_atr,
  trucks_in_transit_week = trucks_transit_portion_by_week_atr,
  trucks_in_transit_province = trucks_transit_portion_by_week_province_atr
)

# Border crossing: Tonnage -------------
border_driver_survey <- border_driver_survey %>% 
  mutate(tonnage = case_when(
    goods == "Food" & if_food_unit == "Tons" ~ if_food,
    goods == "Food" & if_food_unit == "KG" ~ if_food*0.001,
    goods == "Fuel" & if_fuel_unit == "Tons" ~ if_fuel,
    goods == "Fuel" & if_fuel_unit == "KG" ~ if_fuel*0.001,
    goods == "Medicine" & if_medicine_unit == "Tons" ~ if_medicine,
    goods == "Medicine" & if_medicine_unit == "KG" ~ if_medicine*0.001
  ))

food_nonfood <- c(
  "Food item & Non-food",
  "Food item & Non-food item",
  "Food item & Construction material",
  "Food item & Medicine",
  "Food item & Non-food item & Construction material",
  "Food item & Non-food item (any non-food item other than fuel, construction materials and medicine)",
  "Food item & Livestock/poultry"
)
food_items <- c(
  "Food item",
  "Food item & Fruits and vegetables",
  "Food item & Fresh fruits and vegetables",
  "Fresh fruits and vegetables",
  "Fruits and vegetables"
)
nonfood_items <- c(
  "Construction material",
  "Construction material & Livestock/poultry",
  "Non-food item",
  "Non-food item & Construction material",
  "Non-food item (any non-food item other than fuel, construction materials and medicine)",
  "Non-food item (any non-food item other than fuel, construction materials and medicine) & Livestock/poultry",
  "Non-food item (any non-food item other than fuel, construction materials and medicine) & Medicine",
  "Non-food item (any non-food item other than fuel, construction materials and medicine) & Other"
)

border_traffice_count_atr <- border_traffice_count_atr %>%
  mutate(Overall_weight = case_when(
    Unit_overall %in% "Kg" ~ as.character(as.numeric(Overall_weight)*0.001),
    TRUE ~ Overall_weight
  ),
  item_categories = case_when(
    item_loaded %in% food_nonfood ~ "Food & Non-Food Items",
    item_loaded %in% c("Emergency response supplies", "Tractors") ~ "Emergency response supplies & Tractors",
    item_loaded %in% food_items ~ "Food Items",
    item_loaded %in% nonfood_items ~ "Non-Food Items",
    item_loaded %in% c("Don't wish to respond", "I don't know") ~ "Truck loads unclear",
    TRUE ~ item_loaded
    )
  )

border_crossing_tonnage <- border_driver_survey %>% 
  select(week, Province, enter_exist, item_categories=goods, Overall_weight=tonnage, truck_destination=transported_load_transit) %>%
  mutate(truck_destination = case_when(
    truck_destination %in% "No, my destination is to/from Afghanistan" ~ "Entering trucks with Afghanistan as final destination",
    truck_destination %in% "Yes, my transported load is in transit to/from another country" ~ "Exiting trucks in transit from a third country",
    is.na(truck_destination) ~ "Destination not clear"
  )) %>% 
  rbind(border_traffice_count_atr %>%
          filter(week %notin% c(1:9, 48:52)) %>% 
          mutate(truck_destination = case_when(
            transport_third_country_or_to_AFG %in% "No, my final destination is to Afghanistan" ~ "Entering trucks with Afghanistan as final destination",
            transport_third_country_or_to_AFG %in% "Yes, my transported load is in transit to a third country" ~ "Entering trucks in transit",
            transport_third_country_or_to_AFG_from_second_country %in% "No, my destination is directly from Afghanistan to a second country" ~ "Exiting trucks with Afghanistan as departure point",
            transport_third_country_or_to_AFG_from_second_country %in% "Yes, my transported load is in transit to a third country" ~ "Entering trucks in transit",
            is.na(transport_third_country_or_to_AFG) & is.na(transport_third_country_or_to_AFG_from_second_country) ~ "Destination not clear"
          )) %>% 
          select(week, Province, enter_exist, item_categories, Overall_weight, truck_destination))


# by week
border_crossing_tonnage_by_week_atr <- border_crossing_tonnage %>%
  group_by(week, enter_exist, item_categories) %>%
  summarise(
    total_tonnage = round(sum(as.numeric(Overall_weight), na.rm = T)),
    mean_tonnage = round(mean(as.numeric(Overall_weight), na.rm = T), 2)
  ) %>%   
  filter(!item_categories %in% c("No", NA)) %>% 
  pivot_longer(-c(week, item_categories, enter_exist), names_to = "stats", values_to = "atr_values")

# by week and province
border_crossing_tonnage_by_week_and_province_atr <- border_crossing_tonnage %>% 
  group_by(week, Province, item_categories, enter_exist) %>% 
  summarise(
    total_tonnage = sum(as.numeric(Overall_weight), na.rm = T),
    mean_tonnage = round(mean(as.numeric(Overall_weight), na.rm = T), 2)
  ) %>% 
  filter(!item_categories %in% c("No", NA)) %>% 
  pivot_longer(-c(week, Province, item_categories, enter_exist), names_to = "stats", values_to = "atr_values")

# by week and Truck destination
border_crossing_tonnage_by_week_and_truck_destination_atr <- border_crossing_tonnage %>% 
  group_by(week, truck_destination, item_categories, enter_exist) %>% 
  summarise(
    total_tonnage = sum(as.numeric(Overall_weight), na.rm = T),
    mean_tonnage = round(mean(as.numeric(Overall_weight), na.rm = T), 2)
  ) %>% 
  filter(!item_categories %in% c("No", NA)) %>% 
  pivot_longer(-c(week, truck_destination, item_categories, enter_exist), names_to = "stats", values_to = "atr_values")

border_crossing_tonnage_list <- list(
  by_week = border_crossing_tonnage_by_week_atr,
  by_week_and_province = border_crossing_tonnage_by_week_and_province_atr,
  by_week_and_truck_dest = border_crossing_tonnage_by_week_and_truck_destination_atr
)

# Border crossing: Taxes -------------
# proportion of drivers paying tax
## by week
drivers_paying_tax_by_week_atr <- border_driver_survey %>% 
  group_by(week, enter_exist) %>% 
  count(do_you_pay_tax) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

## by week and province
drivers_paying_tax_by_week_and_province_atr <- border_driver_survey %>% 
  group_by(week, Province, enter_exist) %>% 
  count(do_you_pay_tax) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

# average tax paid on goods
## by week
average_tax_paid_on_goods_by_week_atr <- border_driver_survey %>% 
  group_by(week, enter_exist, goods) %>% 
  summarise(atr_mean = round(mean(tax_amount, na.rm = T), 2)) %>% 
  filter(!is.na(atr_mean))

## by week and province
average_tax_paid_on_goods_by_week_and_province_atr <- border_driver_survey %>% 
  group_by(week, Province, enter_exist, goods) %>% 
  summarise(atr_mean = round(mean(tax_amount, na.rm = T), 2)) %>% 
  filter(!is.na(atr_mean))

border_crossing_taxes_list = list(
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









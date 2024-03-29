#Fixing labels according to dashboard
border_traffice_count_atr <- border_traffice_count_atr %>% 
  mutate(truck_destination = case_when(
    transport_third_country_or_to_AFG %in% "No, my final destination is to Afghanistan" ~ "Entering trucks with Afghanistan as final destination",
    transport_third_country_or_to_AFG %in% "Yes, my transported load is in transit to a third country" ~ "Entering trucks in transit",
    transport_third_country_or_to_AFG_from_second_country %in% "No, my destination is directly from Afghanistan to a second country" ~ "Exiting trucks with Afghanistan as departure point",
    transport_third_country_or_to_AFG_from_second_country %in% "Yes, my transported load is in transit to a third country" ~ "Entering trucks in transit",
    is.na(transport_third_country_or_to_AFG) & is.na(transport_third_country_or_to_AFG_from_second_country) ~ "Destination not clear"
  ),
  month_name = month.name[as.numeric(month)])

border_driver_survey <- border_driver_survey %>% 
  mutate(truck_destination = case_when(
    transported_load_transit %in% "No, my destination is to/from Afghanistan" ~ "Entering trucks with Afghanistan as final destination",
    transported_load_transit %in% "Yes, my transported load is in transit to/from another country" ~ "Exiting trucks in transit from a third country",
    is.na(transported_load_transit) ~ "Destination not clear"
  ),
  month_name = month.name[as.numeric(month)])

# Border crossing: Trucks -------------
# Number of trucks crossing the border
trucks <- rbind(
  border_driver_survey %>% 
    select(year, month_name, enter_exist, TPMA_Location_Name)
  ,
  border_traffice_count_atr %>% 
    select(year, month_name, enter_exist, TPMA_Location_Name)
)

## by month
border_crossing_trucks_by_month_atr <- trucks %>% 
  group_by(year, month_name) %>% 
  count(enter_exist) %>% 
  ungroup() %>% 
  drop_na() %>% 
  rename(atr_freq = n)

## by month and location
border_crossing_trucks_by_month_and_location_atr <- trucks %>% 
  group_by(
    year,
    month = month_name,
    location = TPMA_Location_Name
    ) %>% 
  count(enter_exist) %>% 
  ungroup() %>% 
  drop_na() %>% 
  rename(atr_freq = n)

# Proportion of trucks in transit
trucks_transit_portion <- rbind(
  border_traffice_count_atr %>% 
    select(year, month_name, Province, truck_destination),
  border_driver_survey %>% 
    select(year, month_name, Province, truck_destination)
) %>% filter(!is.na(truck_destination))

## by month
trucks_transit_portion_by_month_atr <- trucks_transit_portion %>% 
  group_by(year,
           month = month_name) %>% 
  count(truck_destination) %>% 
  mutate(atr_percent = round((n/sum(n))*100, 2), n = NULL)

## by month and province
trucks_transit_portion_by_month_province_atr <- trucks_transit_portion %>% 
  group_by(
    year,     
    month = month_name,
    Province
  ) %>% 
  count(truck_destination) %>% 
  mutate(atr_percent = round((n/sum(n))*100, 2), n = NULL)

border_crossing_trucks_list <- list(
  by_month = border_crossing_trucks_by_month_atr,
  by_month_and_location = border_crossing_trucks_by_month_and_location_atr,
  trucks_in_transit_month = trucks_transit_portion_by_month_atr,
  trucks_in_transit_province = trucks_transit_portion_by_month_province_atr
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

#Tonnage Categories based on Dashboard
food_nonfood <- c(
  "Food item & Non-food",
  "Food item & Non-food item",
  "Food item & Construction material",
  "Food item & Medicine",
  "Food items & Medicine and health supplies", #added myself
  "Food item & Non-food item & Construction material",
  "Food item & Non-food item (any non-food item other than fuel, construction materials and medicine)",
  "Food item & Livestock/poultry"
)
food_items <- c(
  "Food item",
  "Food items",
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
  "Non-food item (any non-food item other than fuel, construction materials and medicine) & Other",
  "Non-food item (any non-food item other than fuel, construction materials and medicine) & Fuel" #added myself
)

#Sorting items into Dashboard categoriesd
border_traffice_count_atr <- border_traffice_count_atr %>%
  mutate(
  #combining items loaded and aid commodities loaded in one variable
  all_items_loaded = case_when(
    !is.na(Type_Aid_Commodities) & is.na(item_loaded) ~ Type_Aid_Commodities,
    !is.na(Type_Aid_Commodities_Other) & is.na(item_loaded) ~ Type_Aid_Commodities_Other,
    TRUE ~ item_loaded
  ),
  item_categories = case_when(
    all_items_loaded %in% food_nonfood ~ "Food & Non-Food Items",
    all_items_loaded %in% c("Emergency response supplies", "Tractors", "Tractor") ~ "Emergency response supplies & Tractors",
    all_items_loaded %in% food_items ~ "Food Items",
    all_items_loaded %in% nonfood_items ~ "Non-Food Items",
    all_items_loaded %in% c("Don't wish to respond", "I don't know") ~ "Truck loads unclear",
    all_items_loaded %in% "Medicine and health supplies" ~ "Medicine",
    TRUE ~ all_items_loaded
    )
  )
border_crossing_tonnage <- border_driver_survey %>% 
  select(year, month_name, Province, enter_exist, item_categories=goods, Overall_weight=tonnage, truck_destination=transported_load_transit) %>%
  rbind(border_traffice_count_atr %>%
          filter(week %notin% c(1:9, 48:52)) %>% 
          select(year, month_name, Province, enter_exist, item_categories, Overall_weight, truck_destination))

# by month
border_crossing_tonnage_by_month_atr <- border_crossing_tonnage %>%
  group_by(year, month=month_name, enter_exist, item_categories) %>%
  summarise(
    total_tonnage = round(sum(as.numeric(Overall_weight), na.rm = T)),
    mean_tonnage = round(mean(as.numeric(Overall_weight), na.rm = T), 2)
  ) %>%   
  filter(!item_categories %in% c("No", NA)) %>% 
  pivot_longer(-c(year, month, item_categories, enter_exist), names_to = "stats", values_to = "atr_values")

# by month and province
border_crossing_tonnage_by_month_and_province_atr <- border_crossing_tonnage %>% 
  group_by(year, month=month_name, Province, item_categories, enter_exist) %>% 
  summarise(
    total_tonnage = sum(as.numeric(Overall_weight), na.rm = T),
    mean_tonnage = round(mean(as.numeric(Overall_weight), na.rm = T), 2)
  ) %>% 
  filter(!item_categories %in% c("No", NA)) %>% 
  pivot_longer(-c(year, month, Province, item_categories, enter_exist), names_to = "stats", values_to = "atr_values")

# by month and Truck destination
border_crossing_tonnage_by_month_and_truck_destination_atr <- border_crossing_tonnage %>% 
  group_by(year, month=month_name, truck_destination, item_categories, enter_exist) %>% 
  summarise(
    total_tonnage = sum(as.numeric(Overall_weight), na.rm = T),
    mean_tonnage = round(mean(as.numeric(Overall_weight), na.rm = T), 2)
  ) %>% 
  filter(!item_categories %in% c("No", NA)) %>% 
  pivot_longer(-c(year, month, truck_destination, item_categories, enter_exist), names_to = "stats", values_to = "atr_values")

border_crossing_tonnage_list <- list(
  by_month = border_crossing_tonnage_by_month_atr,
  by_month_and_province = border_crossing_tonnage_by_month_and_province_atr,
  by_month_and_truck_dest = border_crossing_tonnage_by_month_and_truck_destination_atr
)

# Border crossing: Taxes -------------
# proportion of drivers paying tax
## by month
drivers_paying_tax_by_month_atr <- border_driver_survey %>% 
  group_by(year, month=month_name, enter_exist) %>% 
  count(do_you_pay_tax) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

## by month and province
drivers_paying_tax_by_month_and_province_atr <- border_driver_survey %>% 
  group_by(year, month=month_name, Province, enter_exist) %>% 
  count(do_you_pay_tax) %>% 
  drop_na() %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

# average tax paid on goods
## by month
average_tax_paid_on_goods_by_month_atr <- border_driver_survey %>% 
  group_by(year, month=month_name, enter_exist, goods) %>% 
  summarise(atr_mean = round(mean(tax_amount, na.rm = T), 2)) %>% 
  filter(!is.na(atr_mean))

## by month and province
average_tax_paid_on_goods_by_month_and_province_atr <- border_driver_survey %>% 
  group_by(year, month=month_name, Province, enter_exist, goods) %>% 
  summarise(atr_mean = round(mean(tax_amount, na.rm = T), 2)) %>% 
  filter(!is.na(atr_mean))

border_crossing_taxes_list = list(
  drivers_paying_tax_by_month =  drivers_paying_tax_by_month_atr,
  drivers_paying_tax_monthProvince = drivers_paying_tax_by_month_and_province_atr,
  average_tax_paid_by_month = average_tax_paid_on_goods_by_month_atr,
  average_tax_paid_month_province = average_tax_paid_on_goods_by_month_and_province_atr
)

# Border crossing: Aid Commodities -------------
# by month
border_crossing_aid_commodities_by_month_atr <- rbind(
  border_traffice_count_atr %>% 
    group_by(year, month) %>% 
    count(
      question = "Is the vehicle transporting aid commodities?",
      response = Is_the_vehicle_transporting_aid_commodities
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(year, month) %>%
    count(
      question = "Number of trucks transporing aid commodities, by donor countries",
      response = Which_country
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(year, month) %>% 
    count(
      question = "Type of aid commodities",
      response = Type_Aid_Commodities
    ) %>% 
    drop_na()
) %>% 
  rename(atr_values = n)

# by month and province
border_crossing_aid_commodities_by_month_and_province_atr <- rbind(
  border_traffice_count_atr %>% 
    group_by(year, month=month_name, Province) %>% 
    count(
      question = "Is the vehicle transporting aid commodities?",
      response = Is_the_vehicle_transporting_aid_commodities
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(year, month=month_name, Province) %>%
    count(
      question = "Number of trucks transporing aid commodities, by donor countries",
      response = Which_country
    ) %>% 
    drop_na()
  ,
  border_traffice_count_atr %>% 
    group_by(year, month=month_name, Province) %>% 
    count(
      question = "Type of aid commodities",
      response = Type_Aid_Commodities
    ) %>% 
    drop_na()
) %>% 
  rename(atr_values = n)

border_crossing_aid_commodities_list <- list(
  by_month = border_crossing_aid_commodities_by_month_atr,
  by_month_and_province = border_crossing_aid_commodities_by_month_and_province_atr
)









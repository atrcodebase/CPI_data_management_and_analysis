# changes in number of transactions -------------
hawala_atr <- hawala_atr %>% 
  mutate(
    Transfer_Changes = gsub("The total number of domestic transfers has |The total number of domestic transfers |The total number of international transfers has |The total number of international transfers ", "", Transfer_Changes),
    week = paste0("week-", week)
  )

## by week
transaction_changes_by_week_atr <- hawala_atr %>% 
  group_by(
    week = week,
    destination_type = Hawala_Type
  ) %>% 
  count(status = Transfer_Changes) %>% 
  drop_na() %>%
  mutate(atr_percent = round(n/sum(n)*100)) %>% 
  ungroup()

## by week and province
transaction_changes_by_week_province_atr <- hawala_atr %>% 
  group_by(
    week = week,
    province = Province,
    destination_type = Hawala_Type
  ) %>% 
  count(status = Transfer_Changes) %>% 
  drop_na() %>%
  mutate(atr_percent = round(n/sum(n)*100)) %>% 
  ungroup()

transaction_changes_atr <- list(
  domestic_by_week = transaction_changes_by_week_atr %>% 
    filter(destination_type == "Domestic"),
  domestic_by_week_and_province = transaction_changes_by_week_province_atr %>% 
  filter(destination_type == "Domestic"),
  
  international_by_week = transaction_changes_by_week_atr %>% 
    filter(destination_type == "International"),
  international_by_week_province = transaction_changes_by_week_province_atr %>% 
  filter(destination_type == "International")
)

## common destination
destination_atr_1st <- hawala_atr %>% 
  group_by(
    week = week,
    destination_type = Hawala_Type,
    rank = "1st"
  ) %>% 
  count(destination = Money_Transfer_Destination1st) %>% 
  drop_na() %>%
  ungroup()

destination_atr_2nd <- hawala_atr %>% 
  group_by(
    week = week,
    destination_type = Hawala_Type,
    rank = "2nd"
  ) %>% 
  count(destination = Money_Transfer_Destination2nd) %>% 
  drop_na() %>%
  ungroup()

destination_atr_3rd <- hawala_atr %>% 
  group_by(
    week = week,
    destination_type = Hawala_Type,
    rank = "3rd"
  ) %>% 
  count(destination = Money_Transfer_Destination3rd) %>% 
  drop_na() %>%
  ungroup()

common_destination_atr_all <- rbind(destination_atr_1st, destination_atr_2nd, destination_atr_3rd) %>% 
  group_by(week, destination_type, destination) %>% 
  mutate(total = sum(n)) %>% 
  ungroup() %>% 
  filter(!destination %in% c("No Third Destination", "No Second Destination")) %>%
  pivot_wider(names_from = rank, values_from = n, values_fill = 0) %>% 
  relocate(total, .after = `3rd`)
  

common_destination_atr <- list(
  domestic_destination = common_destination_atr_all %>%
    filter(destination_type == "Domestic"),
  international_destination = common_destination_atr_all %>%
    filter(destination_type == "International")
)

# ability to transfer money -----------------
transfer_money_by_week_atr <- hawala_atr %>% 
  group_by(
    week = week,
    destination_type = Hawala_Type
    ) %>% 
  count(Money_Transfer_Availability) %>% 
  mutate(atr_percent = round(n/sum(n)*100)) %>% 
  ungroup()

transfer_money_by_week_province_atr <- hawala_atr %>% 
  group_by(
    week = week,
    province = Province,
    destination_type = Hawala_Type
    ) %>% 
  count(Money_Transfer_Availability) %>% 
  mutate(atr_percent = round(n/sum(n)*100)) %>% 
  ungroup()

transfer_money_atr <- list(
  by_week = transfer_money_by_week_atr,
  by_week_and_province = transfer_money_by_week_province_atr
)




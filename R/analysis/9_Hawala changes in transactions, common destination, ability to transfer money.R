# changes in number of transactions -------------
hawala_atr <- hawala_atr %>% 
  mutate(Transfer_Changes = gsub("The total number of domestic transfers has |The total number of domestic transfers |The total number of international transfers has |The total number of international transfers ", "", Transfer_Changes),
         month_name = month.name[as.numeric(month)])

hawala_atr_v2 <- hawala_atr_v2 %>% 
  mutate(Transfer_Changes = gsub("The total number of domestic transfers has |The total number of domestic transfers |The total number of international transfers has |The total number of international transfers ", "", Transfer_Changes),
         month_name = month.name[as.numeric(month)])

## by month
transaction_changes_by_month_atr <- hawala_atr %>% 
  group_by(
    year,
    month = month_name,
    destination_type = Hawala_Type
  ) %>% 
  count(status = Transfer_Changes) %>% 
  drop_na() %>%
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

transaction_changes_by_month_atr_v2 <- hawala_atr_v2 %>% 
  distinct(KEY, .keep_all = TRUE) %>% 
  group_by(
    year,     
    month = month_name,
    destination_type = Hawala_Type
  ) %>% 
  count(status = Transfer_Changes) %>% 
  drop_na() %>%
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

transaction_changes_by_month_atr <- rbind(
  transaction_changes_by_month_atr,
  transaction_changes_by_month_atr_v2
)

## by month and province
transaction_changes_by_month_province_atr <- hawala_atr %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    destination_type = Hawala_Type
  ) %>% 
  count(status = Transfer_Changes) %>% 
  drop_na() %>%
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

transaction_changes_by_month_province_atr_v2 <- hawala_atr_v2 %>% 
  distinct(KEY, .keep_all = TRUE) %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    destination_type = Hawala_Type
  ) %>% 
  count(status = Transfer_Changes) %>% 
  drop_na() %>%
  mutate(atr_percent = round(n/sum(n)*100, 2), n = NULL)

transaction_changes_by_month_province_atr <- rbind(
  transaction_changes_by_month_province_atr,
  transaction_changes_by_month_province_atr_v2
)

transaction_changes_list <- list(
  domestic_by_month = transaction_changes_by_month_atr %>% 
    filter(destination_type %in% c("Domestic", "domestically")),
  domestic_by_month_and_province = transaction_changes_by_month_province_atr %>% 
  filter(destination_type %in% c("Domestic", "domestically")),
  
  international_by_month = transaction_changes_by_month_atr %>% 
    filter(destination_type %in% c("International", "internationally")),
  international_by_month_province = transaction_changes_by_month_province_atr %>% 
  filter(destination_type %in% c("International", "internationally"))
)

## common destination
common_destination_atr <- hawala_atr %>% 
  select(year, month, Hawala_Type, Money_Transfer_Destination1st, Money_Transfer_Destination2nd, Money_Transfer_Destination3rd) %>% 
  pivot_longer(-c(year, month, Hawala_Type), values_to = "HAWALA_DESTINATION") %>% 
  group_by(
    year,
    month,
    destination_type = Hawala_Type
  ) %>% 
  count(HAWALA_DESTINATION, name = "atr_freq") %>% 
  drop_na() %>% 
  ungroup()

common_destination_atr_v2 <- hawala_atr_v2 %>%
  distinct(KEY, HAWALA_TOP3_DESTINATION_RANK, .keep_all = TRUE) %>% 
  group_by(
    year,     
    month = month_name,
    destination_type = Hawala_Type
  ) %>% 
  count(HAWALA_DESTINATION, name = "atr_freq") %>% 
  drop_na() %>% 
  ungroup()

common_destination_atr <- rbind(
  common_destination_atr,
  common_destination_atr_v2
) %>% 
  filter(!HAWALA_DESTINATION %in% c("No Second Destination", "No Third Destination"))

common_destination_list <- list(
  domestic_destination = common_destination_atr %>%
    filter(destination_type %in% c("Domestic", "domestically")),
  international_destination = common_destination_atr %>%
    filter(destination_type %in% c("International", "internationally"))
)

# ability to transfer money -----------------
transfer_money_by_month_atr <- hawala_atr %>%
  group_by(
    year,     
    month = month_name,
    destination_type = Hawala_Type
    ) %>% 
  count(Money_Transfer_Availability) %>% 
  mutate(percent = round(n/sum(n)*100, 2)) %>% 
  rename(freq = n) %>% 
  pivot_longer(-c(year, month, destination_type, Money_Transfer_Availability), names_to = "aggregation_method", values_to = "atr_value") %>% 
  ungroup()

transfer_money_by_month_atr_v2 <- hawala_atr_v2 %>%
  distinct(KEY, .keep_all = TRUE) %>% 
  group_by(
    year,     
    month = month_name,
    destination_type = Hawala_Type
  ) %>% 
  count(Money_Transfer_Availability) %>% 
  mutate(percent = round(n/sum(n)*100, 2)) %>% 
  rename(freq = n) %>% 
  pivot_longer(-c(year, month, destination_type, Money_Transfer_Availability), names_to = "aggregation_method", values_to = "atr_value") %>% 
  ungroup()

transfer_money_by_month_atr <- rbind(
  transfer_money_by_month_atr,
  transfer_money_by_month_atr_v2
)
  
transfer_money_by_month_province_atr <- hawala_atr %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    destination_type = Hawala_Type
    ) %>% 
  count(Money_Transfer_Availability) %>% 
  mutate(percent = round(n/sum(n)*100, 2)) %>% 
  rename(freq = n) %>% 
  pivot_longer(-c(year, month, province, destination_type, Money_Transfer_Availability), names_to = "aggregation_method", values_to = "atr_value") %>% 
  ungroup()

transfer_money_by_month_province_atr_v2 <- hawala_atr %>% 
  distinct(KEY, .keep_all = TRUE) %>% 
  group_by(
    year,     
    month = month_name,
    province = Province,
    destination_type = Hawala_Type
  ) %>% 
  count(Money_Transfer_Availability) %>% 
  mutate(percent = round(n/sum(n)*100, 2)) %>% 
  rename(freq = n) %>% 
  pivot_longer(-c(year, month, province, destination_type, Money_Transfer_Availability), names_to = "aggregation_method", values_to = "atr_value") %>% 
  ungroup()

transfer_money_by_month_province_atr <- rbind(
  transfer_money_by_month_province_atr,
  transfer_money_by_month_province_atr_v2
)

transfer_money_list <- list(
  domestic_by_month = transfer_money_by_month_atr %>% 
    filter(destination_type %in% c("Domestic", "domestically")),
  domestic_by_month_and_province = transfer_money_by_month_province_atr %>% 
    filter(destination_type %in% c("Domestic", "domestically"))
    ,
  international_by_month = transfer_money_by_month_atr %>% 
    filter(destination_type %in% c("International", "internationally")),
  international_by_month_province = transfer_money_by_month_province_atr %>% 
    filter(destination_type %in% c("International", "internationally"))
)

# Transfer Fee -----------------
`%notin%` <- Negate(`%in%`)

transfer_fee_domestic_intl <- hawala_atr_v2 %>% 
  filter(Transfer_Fee_Amount_Destination_Fee %notin% c(NA, "I don't know", "Not applicable/we don't have this service")) %>% 
  mutate(Range_num_k = case_when(
    Range_num %in% "10000" ~ "10k",
    Range_num %in% "50000" ~ "50k",
    Range_num %in% "100000" ~ "100k",
    Range_num %in% "500000" ~ "500k",
    TRUE ~ Range_num
  )) 

transfer_fee_domestic_by_month_atr <- transfer_fee_domestic_intl %>% 
  filter(Hawala_Type %in% "domestically") %>% 
  group_by(year, month_name, Range_num_k) %>% 
  summarize(mean_atr = round(mean(Transfer_Fee_Amount_only)))
  
transfer_fee_domestic_by_month_province_atr <- transfer_fee_domestic_intl %>% 
  filter(Hawala_Type %in% "domestically") %>% 
  group_by(year, month_name, Range_num_k, HAWALA_ORIGIN) %>% 
  summarize(mean_atr = round(mean(Transfer_Fee_Amount_only)))


transfer_fee_internationally_by_month_atr <- transfer_fee_domestic_intl %>% 
  filter(Hawala_Type %in% "internationally") %>% 
  group_by(year, month_name, Range_num_k) %>% 
  summarize(mean_atr = round(mean(Transfer_Fee_Amount_only)))

transfer_fee_internationally_by_month_province_atr <- transfer_fee_domestic_intl %>% 
  filter(Hawala_Type %in% "internationally") %>% 
  group_by(year, month_name, Range_num_k, HAWALA_ORIGIN) %>% 
  summarize(mean_atr = round(mean(Transfer_Fee_Amount_only)))

transfer_fee_domestic_intl_list <- list(
  domestic_fee_by_month = transfer_fee_domestic_by_month_atr,
  domestic_fee_by_month_province = transfer_fee_domestic_by_month_province_atr,
  international_fee_by_month = transfer_fee_internationally_by_month_atr,
  international_fee_by_month_province = transfer_fee_internationally_by_month_province_atr
)

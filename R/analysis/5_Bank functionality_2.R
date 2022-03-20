# bank functionality - 2 ------------
bank_operationality_atr <- bank_operationality_atr %>% 
  mutate(provide_full_services = ifelse(Operational_Status == "Providing full services", "Yes", "No"))

## by week
bank_operationality_by_week_atr <- bank_operationality_atr %>%
  select(Days_Week_Open, Operational_Status) %>% 
  lapply(function(response)
    table(
      week = bank_operationality_atr$week,
      response
    ) %>% data.frame() %>% 
      group_by(week) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>%
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup()
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = week)

## by week and province
bank_operationality_by_week_province_atr <- bank_operationality_atr %>%
  select(Days_Week_Open, Operational_Status) %>% 
  lapply(function(response)
    table(
      week = bank_operationality_atr$week,
      province = bank_operationality_atr$Province,
      response
    ) %>% data.frame() %>% 
      group_by(week, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>%
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup()
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = province)

## branches providing full services
bank_branches_full_services_atr <- bank_operationality_atr %>% 
  group_by(week, Bank_Name) %>% 
  count(provide_full_services) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2)) %>% 
  ungroup() %>% 
  filter(provide_full_services == "Yes") %>% 
  select(-c(n, provide_full_services))

bank_functionality_list_2 <- list(
  by_week = bank_operationality_by_week_atr,
  by_week_and_province = bank_operationality_by_week_province_atr,
  bank_branches_with_FullServices = bank_branches_full_services_atr
)


# bank functionality - 2 ------------
bank_operationality_atr <- bank_operationality_atr %>% 
  mutate(provide_full_services = ifelse(Operational_Status == "Providing full services", "Yes", "No"),
         month_name = month.name[as.numeric(month)])

## by month
bank_operationality_by_month_atr <- bank_operationality_atr %>%
  select(Days_Week_Open, Operational_Status) %>% 
  mutate(Days_Week_Open = as.character(Days_Week_Open),
         Days_Week_Open = case_when(
           Days_Week_Open == 0 ~ "Not Open",
    TRUE ~ Days_Week_Open
  )) %>% 
  lapply(function(response)
    table(
      year = bank_operationality_atr$year,
      month = bank_operationality_atr$month_name,
      response
    ) %>% data.frame() %>% 
      group_by(year, month) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>%
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup()
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = month)

## by month and province
bank_operationality_by_month_province_atr <- bank_operationality_atr %>%
  select(Days_Week_Open, Operational_Status) %>% 
  lapply(function(response)
    table(
      year = bank_operationality_atr$year,       
      month = bank_operationality_atr$month_name,
      province = bank_operationality_atr$Province,
      response
    ) %>% data.frame() %>% 
      group_by(year, month, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>%
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup()
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = province)

## branches providing full services
bank_branches_full_services_atr <- bank_operationality_atr %>% 
  group_by(year, month, Bank_Name) %>% 
  count(provide_full_services) %>% 
  mutate(atr_percent = round(n/sum(n)*100, 2)) %>% 
  ungroup() %>% 
  filter(provide_full_services == "Yes") %>% 
  select(-c(n, provide_full_services))

bank_functionality_list_2 <- list(
  by_month = bank_operationality_by_month_atr,
  by_month_and_province = bank_operationality_by_month_province_atr,
  bank_branches_with_FullServices = bank_branches_full_services_atr
)


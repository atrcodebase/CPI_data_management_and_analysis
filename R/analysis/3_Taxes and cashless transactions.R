# tax -----------
fi_tax_atr <- plyr::join(fi_tax_atr, select(fi_atr, week, KEY_Main), by=c("KEY_Main"), type="left", match="first")
nfi_tax_atr <- plyr::join(nfi_tax_atr, select(nfi_atr, week, KEY_Main), by=c("KEY_Main"), type="left", match="first")

## by week
fi_tax_by_week_atr <- fi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, week = fi_tax_atr$week) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100), Freq = NULL) %>% 
      ungroup()
    ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(week, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = week)

nfi_tax_by_week_atr <- nfi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, week = nfi_tax_atr$week) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(week, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = week)

tax_by_week_atr <- rbind(
  fi_tax_by_week_atr,
  nfi_tax_by_week_atr
)

## by week and province
fi_tax_by_week_province_atr <- fi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, week = fi_tax_atr$week, province = fi_tax_atr$Province) %>% data.frame() %>% 
      group_by(week, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100), Freq = NULL) %>%
      ungroup()
  ) %>%  
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(week, province, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = week)

nfi_tax_by_week_province_atr <- nfi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, week = nfi_tax_atr$week, province = nfi_tax_atr$Province) %>% data.frame() %>% 
      group_by(week, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100), Freq = NULL) %>%
      ungroup()
  ) %>%  
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(week, province, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = week)


tax_by_week_province_atr <- rbind(
  fi_tax_by_week_province_atr,
  nfi_tax_by_week_province_atr
)


tax_list <- list(
  by_week = tax_by_week_atr,
  by_week_and_province = tax_by_week_province_atr
)

# cashless transaction ---------------
## by week
fi_cashless_transaction_by_week_atr <- fi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, week = fi_tax_atr$week) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(week, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = week)


nfi_cashless_transaction_by_week_atr <- nfi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, week = nfi_tax_atr$week) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(week, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = week)

cashless_transaction_by_week_atr <- rbind(
  fi_cashless_transaction_by_week_atr,
  nfi_cashless_transaction_by_week_atr
)

## by week and province

fi_cashless_transaction_by_week_province_atr <- fi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, week = fi_tax_atr$week, province = fi_tax_atr$Province) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(week, province, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = week)


nfi_cashless_transaction_by_week_province_atr <- nfi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, week = nfi_tax_atr$week, province = nfi_tax_atr$Province) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(week, province, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = week)

cashless_transaction_by_week_province_atr <- rbind(
  fi_cashless_transaction_by_week_province_atr,
  nfi_cashless_transaction_by_week_province_atr
)

cashless_transaction_list <- list(
  by_week = cashless_transaction_by_week_atr,
  by_week_and_province = cashless_transaction_by_week_province_atr
)


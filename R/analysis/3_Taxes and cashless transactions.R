# tax -----------
fi_tax_atr <- plyr::join(fi_tax_atr, select(fi_atr, year, month, KEY_Main), by=c("KEY_Main"), type="left", match="first")
nfi_tax_atr <- plyr::join(nfi_tax_atr, select(nfi_atr, year, month, KEY_Main), by=c("KEY_Main"), type="left", match="first")

fi_tax_atr <- fi_tax_atr %>% 
  mutate(month_name = month.name[as.numeric(month)])
nfi_tax_atr <- nfi_tax_atr %>% 
  mutate(month_name = month.name[as.numeric(month)])

## by month
fi_tax_by_month_atr <- fi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, year = fi_tax_atr$year, month = fi_tax_atr$month_name) %>% data.frame() %>% 
      group_by(year, month) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
    ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(year, month, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = month)

nfi_tax_by_month_atr <- nfi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, year = nfi_tax_atr$year, month = nfi_tax_atr$month_name) %>% data.frame() %>% 
      group_by(year, month) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(year, month, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = month)

tax_by_month_atr <- rbind(
  fi_tax_by_month_atr,
  nfi_tax_by_month_atr
)

## by month and province
fi_tax_by_month_province_atr <- fi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, year = fi_tax_atr$year, month = fi_tax_atr$month_name, province = fi_tax_atr$Province) %>% data.frame() %>% 
      group_by(year, month, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>%
      ungroup()
  ) %>%  
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(year, month, province, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = month)

nfi_tax_by_month_province_atr <- nfi_tax_atr %>% 
  select(Tax_Payment_Previous, Tax_Payment_Current, Tax_Status) %>% 
  lapply(function(levels)
    table(levels, year = nfi_tax_atr$year, month = nfi_tax_atr$month_name, province = nfi_tax_atr$Province) %>% data.frame() %>% 
      group_by(year, month, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>%
      ungroup()
  ) %>%  
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Tax_Payment_Previous" ~ "% of shopkeepers paid tax before 15 August",
    question == "Tax_Payment_Current" ~ "% of shopkeepers currently paying tax",
    question == "Tax_Status" ~ "Change in tax payments"
  )) %>% 
  select(year, month, province, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = month)


tax_by_month_province_atr <- rbind(
  fi_tax_by_month_province_atr,
  nfi_tax_by_month_province_atr
)


tax_list <- list(
  by_month = tax_by_month_atr,
  by_month_and_province = tax_by_month_province_atr
)

# cashless transaction ---------------
## by month
fi_cashless_transaction_by_month_atr <- fi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, year = fi_tax_atr$year, month = fi_tax_atr$month_name) %>% data.frame() %>% 
      group_by(year, month) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(year, month, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = month)


nfi_cashless_transaction_by_month_atr <- nfi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, year = nfi_tax_atr$year, month = nfi_tax_atr$month_name) %>% data.frame() %>% 
      group_by(year, month) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(year, month, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = month)

cashless_transaction_by_month_atr <- rbind(
  fi_cashless_transaction_by_month_atr,
  nfi_cashless_transaction_by_month_atr
)

## by month and province
fi_cashless_transaction_by_month_province_atr <- fi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, year = fi_tax_atr$year, month = fi_tax_atr$month_name, province = fi_tax_atr$Province) %>% data.frame() %>% 
      group_by(year, month) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(year, month, province, question, levels, everything()) %>% 
  mutate(respondents_type = "FI", .before = month)


nfi_cashless_transaction_by_month_province_atr <- nfi_tax_atr %>% 
  select(Exchange_Other_Than_Cash, Exchange_Other_Than_Cash_Duration) %>% 
  lapply(function(levels)
    table(levels, year = nfi_tax_atr$year, month = nfi_tax_atr$month_name, province = nfi_tax_atr$Province) %>% data.frame() %>% 
      group_by(year, month) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), Freq = NULL) %>% 
      ungroup()
  ) %>%   
  data.table::rbindlist(idcol = "question") %>% 
  mutate(question = case_when(
    question == "Exchange_Other_Than_Cash" ~ "Accept cashless transaction",
    question == "Exchange_Other_Than_Cash_Duration" ~ "Time began accepting cashless transaction"
  )) %>% 
  select(year, month, province, question, levels, everything()) %>% 
  mutate(respondents_type = "NFI", .before = month)

cashless_transaction_by_month_province_atr <- rbind(
  fi_cashless_transaction_by_month_province_atr,
  nfi_cashless_transaction_by_month_province_atr
)

cashless_transaction_list <- list(
  by_month = cashless_transaction_by_month_atr,
  by_month_and_province = cashless_transaction_by_month_province_atr
)


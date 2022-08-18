# client's ability to withdraw full anount and waiting time at ATM & cashier ------------
bank_respondents_atr <- bank_respondents_atr %>% 
  mutate(Withdraw_Full_Amount = case_when(
    (Come_To_Bank_Widthdraw_Money == "Yes" & Perform_Transaction_Cashier == "No" & Use_ATM == "No") ~ "Could not withdraw money",
    Withdraw_Full_Amount %in% "No, I didn’t receive any money" ~ "Could not withdraw money",
    Withdraw_Full_Amount == "Yes" ~ "Full amount",
    TRUE ~ Withdraw_Full_Amount
  ),
  How_Long_Wait_Transcation = case_when(
    How_Long_Wait_Transcation == "Between 3 and 6 hours" ~ "Between more than 3 hours and less than 6 hours",
    How_Long_Wait_Transcation == "1 hour or less" ~ "Less than 1 hour",
    How_Long_Wait_Transcation == "More than 6 hours" ~ "Between 6 and 8 hours",
    TRUE ~ How_Long_Wait_Transcation
  ),
  month_name = month.name[as.numeric(month)])

## by month
bank_withdraw_ability_and_waiting_time_by_month_atr <- bank_respondents_atr %>% 
  select(
    `Were you able to withdraw the full amount you are entitled to on a weekly basis?` = Withdraw_Full_Amount,
    `How long did you wait to use the ATM?` = How_Long_Wait_ATM,
    `How long did you wait to perform a transaction with a cashier?` = How_Long_Wait_Transcation
  ) %>% 
  lapply(function(response)
    table(
      year = bank_respondents_atr$year,
      month = bank_respondents_atr$month_name,
      response
      ) %>%
      data.frame() %>% 
      group_by(year, month) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>% 
      select(everything(), atr_freq = Freq)
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  select(year, month, question, response, everything())

## by month and province
bank_withdraw_ability_and_waiting_time_by_month_province_atr <- bank_respondents_atr %>% 
  select(
    `Were you able to withdraw the full amount you are entitled to on a weekly basis?` = Withdraw_Full_Amount,
    `How long did you wait to use the ATM?` = How_Long_Wait_ATM,
    `How long did you wait to perform a transaction with a cashier?` = How_Long_Wait_Transcation
  ) %>% 
  lapply(function(response)
    table(
      year = bank_respondents_atr$year,       
      month = bank_respondents_atr$month_name,
      province = bank_respondents_atr$Province,
      response
      ) %>%
      data.frame() %>% 
      group_by(year, month, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>% 
      select(everything(), atr_freq = Freq)
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  select(year, month, province, question, response, everything())

withdraw_ability_and_waiting_time_list <- list(
  by_month = bank_withdraw_ability_and_waiting_time_by_month_atr,
  by_month_and_province = bank_withdraw_ability_and_waiting_time_by_month_province_atr
)








  
  
  
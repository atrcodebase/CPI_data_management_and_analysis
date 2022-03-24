# client's ability to withdraw full anount and waiting time at ATM & cashier ------------
bank_respondents_atr <- bank_respondents_atr %>% 
  mutate(Withdraw_Full_Amount = case_when(
    (Come_To_Bank_Widthdraw_Money == "Yes" & Perform_Transaction_Cashier == "No" & Use_ATM == "No") ~ "Could not withdraw money",
    Withdraw_Full_Amount == "No, I didn’t receive any money" ~ "Could not withdraw money",
    Withdraw_Full_Amount == "Yes" ~ "Full amount",
    TRUE ~ Withdraw_Full_Amount
  ),
  How_Long_Wait_Transcation = case_when(
    How_Long_Wait_Transcation == "Between 3 and 6 hours" ~ "Between more than 3 hours and less than 6 hours",
    How_Long_Wait_Transcation == "Less than 1 hour" ~ "1 hour or less",
    How_Long_Wait_Transcation == "More than 6 hours" ~ "Between 6 and 8 hours",
    TRUE ~ How_Long_Wait_Transcation
  ))

## by week
bank_withdraw_ability_and_waiting_time_by_week_atr <- bank_respondents_atr %>% 
  select(
    `Were you able to withdraw the full amount you are entitled to on a weekly basis?` = Withdraw_Full_Amount,
    `How long did you wait to use the ATM?` = How_Long_Wait_ATM,
    `How long did you wait to perform a transaction with a cashier?` = How_Long_Wait_Transcation
  ) %>% 
  lapply(function(response)
    table(
      week = bank_respondents_atr$week,
      response
      ) %>%
      data.frame() %>% 
      group_by(week) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>% 
      select(everything(), atr_freq = Freq)
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  select(week, question, response, everything())

## by week and province
bank_withdraw_ability_and_waiting_time_by_week_province_atr <- bank_respondents_atr %>% 
  select(
    `Were you able to withdraw the full amount you are entitled to on a weekly basis?` = Withdraw_Full_Amount,
    `How long did you wait to use the ATM?` = How_Long_Wait_ATM,
    `How long did you wait to perform a transaction with a cashier?` = How_Long_Wait_Transcation
  ) %>% 
  lapply(function(response)
    table(
      week = bank_respondents_atr$week,
      province = bank_respondents_atr$Province,
      response
      ) %>%
      data.frame() %>% 
      group_by(week, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2)) %>% 
      select(everything(), atr_freq = Freq)
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  select(week, province, question, response, everything())

withdraw_ability_and_waiting_time_list <- list(
  by_week = bank_withdraw_ability_and_waiting_time_by_week_atr,
  by_week_and_province = bank_withdraw_ability_and_waiting_time_by_week_province_atr
)








  
  
  
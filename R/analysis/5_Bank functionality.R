# bank functionality ------------
# test
bank_atr <- bank_atr %>% 
  mutate(Total_Number_Withdraws_Changed = case_when(
    Total_Number_Withdraws_Changed %in% c("The total number of withdraws has decreased", "The total number of withdraws has decreased a bit", "The total number of withdrawals has decreased a lot") ~ "Decrease",
    Total_Number_Withdraws_Changed %in% c("The total number of withdraws have increased", "The total number of withdrawals has increased a bit", "The total number of withdrawals has increased a lot") ~ "Increased",
    Total_Number_Withdraws_Changed %in% c("The total number of withdraws have stayed the same", "The total number of withdrawals has stayed the same") ~ "Stayed the same",
    TRUE ~ Total_Number_Withdraws_Changed
  ))

### by week
bank_functionality_by_week_atr <- bank_atr %>%
  select(
    `Was the branch open when you arrived?` = Branch_Open,
    `Does this branch have an operational ATM?` = Branch_Operational_ATM,
    `How many days per week is the branch open?` = Days_Per_Week_Open,
    `How many hours per day is this branch usually open?` = Hours_Day_Branch_Open,
    `Change in No. of withdrawals` = Total_Number_Withdraws_Changed
  ) %>% 
  lapply(function(response)
    table(
      week = bank_atr$week,
      response
      ) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), atr_freq = Freq, Freq = NULL) %>% 
      ungroup()
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = week)

### by week and province
bank_functionality_by_week_province_atr <- bank_atr %>% 
  select(
    `Was the branch open when you arrived?` = Branch_Open,
    `Does this branch have an operational ATM?` = Branch_Operational_ATM,
    `How many days per week is the branch open?` = Days_Per_Week_Open,
    `How many hours per day is this branch usually open?` = Hours_Day_Branch_Open,
    `Change in No. of withdrawals` = Total_Number_Withdraws_Changed
  ) %>% 
  lapply(function(response)
    table(
      week = bank_atr$week,
      province = bank_atr$Province,
      response
      ) %>% data.frame() %>% 
      group_by(week, province) %>%
      mutate(atr_percent = round(Freq/sum(Freq)*100, 2), atr_freq = Freq, Freq = NULL) %>%
      ungroup()
  ) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = province) %>% 
  filter(!is.na(atr_percent))

bank_functionality_list <- list(
  by_week = bank_functionality_by_week_atr,
  by_week_and_province = bank_functionality_by_week_province_atr
)






  
  
  




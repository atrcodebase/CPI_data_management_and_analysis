# withdrawal limit --------------------
bank_atr <- bank_atr %>% 
  mutate(
    `What is the monthly withdrawal limit for business AFN accounts in this bank?` = as.numeric(Withdrawal_Limit_Businees_Bank_Max_Amount_AFN),
    `What is the monthly withdrawal limit for business USD accounts in this bank?` = as.numeric(Withdrawal_Limit_Businees_Bank_Max_Amount_USD),
    `What is the weekly withdrawal limit for individual AFN accounts in this bank?`= as.numeric(Withdrawal_Limit_individual_Bank_AFN),
    `What is the weekly withdrawal limit for individual USD accounts in this bank?` = as.numeric(Withdrawal_Limit_individual_Bank_USD)
  )

## by week
withdrawal_limit_by_week_atr <- bank_atr %>% 
  select(
    week = week,
    `What is the monthly withdrawal limit for business AFN accounts in this bank?`,
    `What is the monthly withdrawal limit for business USD accounts in this bank?`,
    `What is the weekly withdrawal limit for individual AFN accounts in this bank?`,
    `What is the weekly withdrawal limit for individual USD accounts in this bank?`,
  ) %>% 
  group_by(week) %>% 
  summarise(across(everything(),
                   function(x)
                     round(mean(x, na.rm = T), 2)
  )
  ) %>% 
  ungroup() %>% 
  pivot_longer(-week, names_to = "question", values_to = "mean_atr")

# by week and province
withdrawal_limit_by_week_province_atr <- bank_atr %>% 
  select(
    week = week,
    province = Province,
    `What is the monthly withdrawal limit for business AFN accounts in this bank?`,
    `What is the monthly withdrawal limit for business USD accounts in this bank?`,
    `What is the weekly withdrawal limit for individual AFN accounts in this bank?`,
    `What is the weekly withdrawal limit for individual USD accounts in this bank?`,
  ) %>% 
  group_by(week, province) %>% 
  summarise(across(everything(),
                   function(x)
                     round(mean(x, na.rm = T), 2)
  )
  ) %>% 
  ungroup() %>% 
  pivot_longer(-c(week, province), names_to = "question", values_to = "mean_atr") %>% 
  filter(!is.na(mean_atr))

withdrawal_limit_list <- list(
  by_week = withdrawal_limit_by_week_atr,
  by_week_and_province = withdrawal_limit_by_week_province_atr
)

#Change in Salary ----------------------
## by month
emp_salary_change_by_month_atr <- gov_emp_salary_atr %>%
  select(Aware_of_Salary_Changes,
         Salary_Revised,
         Changes_of_Salary) %>% 
  lapply(function(response)
    table(
      year = gov_emp_salary_atr$year,
      month = gov_emp_salary_atr$month_name,
      response
    ) %>% data.frame() %>% 
      group_by(year, month) %>% 
      mutate(atr_freq = Freq) %>% 
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup() %>% 
      arrange(desc(atr_freq))) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = month)

## by month and province
emp_salary_change_by_month_province_atr <- gov_emp_salary_atr %>%
  select(Changes_of_Salary) %>% 
  lapply(function(response)
    table(
      year = gov_emp_salary_atr$year,
      month = gov_emp_salary_atr$month_name,
      province = gov_emp_salary_atr$Province,
      response
    ) %>% data.frame() %>% 
      group_by(year, month, province) %>% 
      mutate(atr_freq = Freq) %>% 
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup() %>% 
      arrange(desc(atr_freq))) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  filter(atr_freq != 0) %>% 
  relocate(question, .after = month)

salary_change_list <- list(
  by_month = emp_salary_change_by_month_atr,
  by_month_and_province = emp_salary_change_by_month_province_atr
)



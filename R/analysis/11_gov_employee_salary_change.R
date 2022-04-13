#Change in Salary ----------------------
## by week
emp_salary_change_by_week_atr <- gov_emp_salary_atr %>%
  select(Aware_of_Salary_Changes,
         Salary_Revised,
         Changes_of_Salary) %>% 
  lapply(function(response)
    table(
      week = gov_emp_salary_atr$week,
      month = gov_emp_salary_atr$month_name,
      response
    ) %>% data.frame() %>% 
      group_by(week, month) %>% 
      mutate(atr_freq = Freq, Freq = NULL) %>% 
      ungroup() %>% 
      arrange(desc(atr_freq))) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = month)

## by week and province
emp_salary_change_by_week_province_atr <- gov_emp_salary_atr %>%
  select(Changes_of_Salary) %>% 
  lapply(function(response)
    table(
      week = gov_emp_salary_atr$week,
      month = gov_emp_salary_atr$month_name,
      province = gov_emp_salary_atr$Province,
      response
    ) %>% data.frame() %>% 
      group_by(week, month, province) %>% 
      mutate(atr_freq = Freq, Freq = NULL) %>% 
      ungroup() %>% 
      arrange(desc(atr_freq))) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  filter(atr_freq != 0) %>% 
  relocate(question, .after = month)

salary_change_list <- list(
  by_week = emp_salary_change_by_week_atr,
  by_week_and_province = emp_salary_change_by_week_province_atr
)



# Gov Employee Salary ------------
## by week
employee_salary_by_week_atr <- gov_emp_salary_atr %>% 
  select(Gender_Of_Interviewee, 
         Job_Location, 
         Professional_Stream, 
         Salary_Paid,
         Last_Time_Paid, 
         Salary_Payment_Type,
         Salary_Status,
         Partially_Paid_Salary) %>% 
  lapply(function(response)
    table(
      week = gov_emp_salary_atr$week,
      month = gov_emp_salary_atr$month_name,
      response
    ) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(atr_freq = Freq) %>% 
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup() %>% 
      arrange(desc(atr_freq))) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = month)

## by week and province
employee_salary_by_week_province_atr <- gov_emp_salary_atr %>% 
  select(Gender_Of_Interviewee, 
         Job_Location, 
         Professional_Stream, 
         Salary_Paid,
         Last_Time_Paid, 
         Salary_Payment_Type,
         Salary_Status,
         Partially_Paid_Salary) %>% 
  lapply(function(response)
    table(
      week = gov_emp_salary_atr$week,
      month = gov_emp_salary_atr$month_name,
      province = gov_emp_salary_atr$Province,
      response
    ) %>% data.frame() %>% 
      group_by(week, month, province) %>% 
      mutate(atr_freq = Freq) %>% 
      filter(Freq != 0) %>% select(-Freq) %>% 
      ungroup() %>% 
      arrange(desc(atr_freq))) %>% 
  data.table::rbindlist(idcol = "question") %>% 
  relocate(question, .after = month)

salary_payment_list_1 <- list(
  by_week = employee_salary_by_week_atr,
  by_week_and_province = employee_salary_by_week_province_atr
)


# Gov Employee Salary ------------
gov_emp_salary_atr <- gov_emp_salary_atr %>%
  mutate(month_name = month.name[as.numeric(month)])
  # filter(Salary_Paid %in% "Yes")

## by month
employee_salary_by_month_atr <- gov_emp_salary_atr %>% 
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
      year=gov_emp_salary_atr$year,
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
employee_salary_by_month_province_atr <- gov_emp_salary_atr %>% 
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
  relocate(question, .after = month)

salary_payment_list_1 <- list(
  by_month = employee_salary_by_month_atr,
  by_month_and_province = employee_salary_by_month_province_atr
)


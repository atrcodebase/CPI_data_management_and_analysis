##Gov Emp Salary - 2 -------------------

#Breaking Paid_Salary_periods_Months into repeated columns
month_cols <- c("sh_Sonbola", "sh_Mizan", "sh_Aqrab", "sh_Qaws", "sh_Jadi", "sh_Dalw", "sh_Hout", "sh_Hamal", "sh_Sawr")
gov_emp_salary_atr[,month_cols] = as.numeric(NA)

gov_emp_salary_atr <- gov_emp_salary_atr %>% 
  relocate(month_cols, .after=Paid_Salary_periods_Months) %>%
  mutate(across(.cols = month_cols, function(x){
    x = case_when(
      grepl(str_remove(cur_column(), "sh_"), Paid_Salary_periods_Months) ~ 1,
      TRUE ~ 0)
  })) %>% 
  rowwise() %>% 
  mutate(Number_months_paid = case_when(
    !is.na(Paid_Salary_periods_Months) ~ str_count(Paid_Salary_periods_Months, " & ")+1
  ), .after=Paid_Salary_periods_Months)

## by week
payment_percentage_by_week_atr <- gov_emp_salary_atr %>%
  filter(Salary_Paid == "Yes") %>%
  select(starts_with("sh_")) %>% 
  lapply(function(x)
    table(
      week = gov_emp_salary_atr$week[gov_emp_salary_atr$Salary_Paid %in% "Yes"],
      x
    ) %>% data.frame() %>% 
      group_by(week) %>% 
      mutate(Perc = round(Freq/sum(Freq)*100), 
             denominator = sum(Freq))) %>% 
  data.table::rbindlist(idcol="months") %>% 
  filter(x != 0) %>% select(-x) %>%
  mutate(months = str_remove(months, "sh_")) %>% 
  relocate(months, .after = week)
#Average total of months got paid
payment_num_month <- gov_emp_salary_atr %>% 
  group_by(month_name) %>% 
  summarize(mean = round(mean(Number_months_paid, na.rm=T),2))

## by week and province
payment_amount_by_week_province_atr <- gov_emp_salary_atr %>%
  select(week, Province, starts_with("sh_")) %>%
  pivot_longer(-c(Province, week), names_to = "months") %>%
  mutate(months = str_remove(months, "sh_")) %>%
  group_by(week, months, Province) %>%
  summarize(Freq = sum(value)) %>%
  ungroup() %>%
  arrange(months)

payment_num_month_by_province <- gov_emp_salary_atr %>% 
  filter(Salary_Paid == "Yes") %>% 
  group_by(month_name, Province) %>% 
  summarize(mean = round(mean(Number_months_paid, na.rm=T),2))

salary_payment_list_2 <- list(
  by_week = payment_percentage_by_week_atr,
  by_week_and_province = payment_amount_by_week_province_atr,
  avg_month_paid = payment_num_month,
  avg_month_paid_by_province = payment_num_month_by_province
)




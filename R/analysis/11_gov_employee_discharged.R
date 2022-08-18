##Discharged civil servants --------------------------
## by month
terminated_emp_by_month_atr <- rbind(
  #terminated employees
  gov_emp_salary_atr %>% 
    group_by(year, month_name, Position_Terminated_Since_Political_Transition) %>% 
    summarize(Freq = length(Position_Terminated_Since_Political_Transition)) %>% 
    pivot_longer(Position_Terminated_Since_Political_Transition, names_to = "question"), 
  #Alternative source of income (terminated emp)
  gov_emp_salary_atr %>% 
    filter(Position_Terminated_Since_Political_Transition == "Yes") %>%
    group_by(year, month_name, Alternative_sources) %>% 
    summarize(Freq = length(Alternative_sources)) %>% 
    pivot_longer(Alternative_sources, names_to = "question"),
  #Income source (terminated emp)
  gov_emp_salary_atr %>% 
    filter(Position_Terminated_Since_Political_Transition == "Yes" & Alternative_sources == "Yes") %>%
    group_by(year, month_name, Has_Alternative_sources) %>% 
    summarize(Freq = length(Has_Alternative_sources)) %>% 
    pivot_longer(Has_Alternative_sources, names_to = "question"),
  #Received salary (terminated emp)
  gov_emp_salary_atr %>% 
    filter(Position_Terminated_Since_Political_Transition == "Yes") %>%
    group_by(year, month_name, Salary_Paid) %>% 
    summarize(Freq = length(Salary_Paid)) %>% 
    pivot_longer(Salary_Paid, names_to = "question"),
  #Salary paid amount (terminated emp)
  gov_emp_salary_atr %>% 
    filter(Position_Terminated_Since_Political_Transition == "Yes" & Salary_Paid == "Yes") %>%
    group_by(year, month_name, Salary_Status) %>% 
    summarize(Freq = length(Salary_Status)) %>% 
    pivot_longer(Salary_Status, names_to = "question")
  
) %>% 
  relocate(Freq, .after = value)

#Terminated employees by job location
terminated_emp_by_month_job_location_atr <- gov_emp_salary_atr %>% 
  group_by(year, month_name, Job_Location, Position_Terminated_Since_Political_Transition) %>% 
  summarize(Freq = length(Position_Terminated_Since_Political_Transition))

terminated_emp_list <- list(
  by_month = terminated_emp_by_month_atr,
  terminated_emp_job_location = terminated_emp_by_month_job_location_atr
)


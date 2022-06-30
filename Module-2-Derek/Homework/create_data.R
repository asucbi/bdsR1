
salaries <- read_csv("data/employee-compensation-report-calendar-year-2021-6.csv")

df <-   salaries %>% 
  mutate(Department = if_else(grepl("(Parks & Rec|Parks and Rec)", Department), "Parks and Recreation", Department)) %>% 
  group_by(Department) %>% 
  mutate(
    Department = gsub(" Department", "", Department),
    Department = gsub(" Dept", "", Department),
    ) %>% 
  filter(n() > 250) %>% 
  select(-`Benefits Category`, -Name, -`...12`) %>% 
  rename(
    job = `Job Title`,
    timeclass = `Full/Part Time`,
    startdate = `Hire Date`,
    enddate = `Termination Date`,
    hourly_wage = `Hourly Rate`,
    regular_pay = `Regular Pay`,
    overtime_pay = `Overtime Pay`,
    other_pay = `Other Pay`,
    department = Department
  ) %>% 
  mutate(
    total_pay = regular_pay + overtime_pay + other_pay
  ) %>% 
  filter(is.na(enddate)) %>% 
  select(-enddate) %>% 
  mutate(
    reg_hours = regular_pay/hourly_wage/52,
    overtime_hours = overtime_pay/(hourly_wage*1.5)/52,
    total_hours = reg_hours + overtime_hours
  )

write_csv(df, "data/phx-salaries.csv")

## exploration and validation

df %>%
  ggplot(mapping = aes(x = total_pay)) +
    geom_histogram(binwidth = 10000) +
    facet_wrap(~department) +
    scale_x_continuous(labels=scales::dollar_format()) +
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1))
# 
# df %>% 
#   filter(total_pay > 200000) %>% 
#   select(Department, job, total_pay)


## note these are overtime hours *paid for*, which is not necessarily
## overtime hours worked (Fire get 3hrs automatically if they are called in)
df %>% 
  mutate(
    reg_hours = regular_pay/hourly_wage/52,
    overtime_hours = overtime_pay/(hourly_wage*1.5)/52,
    total_hours = reg_hours + overtime_hours
  ) %>%
  ggplot(mapping = aes(x = total_hours)) +
    geom_histogram(binwidth = 2) +
    # geom_vline(xintercept=40) +
    # geom_vline(xintercept=80) +
    # geom_vline(xintercept=168) +
    facet_wrap(~Department)
    # scale_x_continuous(labels=scales::dollar_format()) +
  # theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1))

## do more senior officers get more overtime hours? (yes but not the oldest ones)
## also note hiring freeze from 2008-2015
df %>% 
  filter(department=="Police") %>% 
  # filter(overtime_hours > 1) %>%
  mutate(startdate = lubridate::mdy(startdate)) %>% 
  ggplot(aes(x=ordered(lubridate::year(startdate)), y=overtime_hours)) +
  geom_boxplot()



# Source https://insights.stackoverflow.com/survey

path <- "C:\\Users\\dyzio\\Downloads\\_INZYNIERKA\\ANKIETY\\developer_survey_2018\\survey_results_public.csv"
survey <- read.csv(file = path, sep = ",", header = TRUE)

salary = table(survey$Salary)
salaryFrame = as.data.frame(salary)


library(tidyverse)
library(ggplot2)
library(GGally)

#read data
ins<- read.csv("data/insurance.csv")
head(ins)
# data structure
str(ins)
#Children is discrete values so changing it to factors
ins$children<- as.factor(ins$children)
#Lets check some vizzes
ggplot(ins, aes(sex,charges)) +
  geom_boxplot()
#Smokers v/s Non-smokers
ggplot(ins, aes(bmi,charges, col=smoker)) + 
  geom_point()
#
#ggpairs(ins)
#Smokers v/s non-smoker Parents
#Mother
 ins %>% 
   filter(children!=0, sex=="female") %>% 
   group_by(smoker) %>%
  summarise(Avgbmi= mean(bmi), AvgCharges= mean(charges), n=n()) 
#Father
 ins %>% 
   filter(children != 0, sex == "male") %>% 
   group_by(smoker) %>% 
   summarise(Avgbmi = mean(bmi), Avgcharges = mean(charges), n = n())
#Region effect
 ins %>% 
   group_by(region) %>% 
   summarise(Avgbmi = mean(bmi), Avgcharges = mean(charges), n = n())
 #make age groups
 ins <- ins %>% 
   mutate(agegp = case_when(age >= 18 & age <25 ~ "18-25",
                            age >= 25 & age <35 ~ "25-35",
                            age >= 35 & age <45 ~ "35-45",
                            age >= 45 & age <55 ~ "45-55",
                            age >= 55 ~ "55+"))
 #convert agegp to factors
 ins$agegp <- as.factor(ins$agegp)
 
#age and region groups 
 ins %>% 
   group_by(region, agegp) %>% 
   summarise(Avgbmi = mean(bmi), Avgcharges = mean(charges), n = n())

#calculate avg charges
 Abc2 <- ins %>% 
   group_by( age,sex, smoker)%>% summarise(AvgCharges= mean(charges))  
#spread 
 spread(Abc2, key = smoker, value = AvgCharges)
 
 
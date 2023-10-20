# augmentation exp

library(tidyverse)
beans <- as_tibble(soybean_damage)
beans

# remove .jpg
beans <- beans %>% 
  mutate(leaf_plot = gsub(".jpg", "", leaf_plot))

# time to do math 
# I just want a few rows to mess with first
beans_test <- beans[1:10,]
beans_test

# beans_test %>% 
#   mutate(test = beans_test[seq_along(beans_test) %% 2==0,'post'])

timing <- c("total", "damaged")
test <- beans_test %>% 
  group_by(leaf_plot) %>% 
  mutate(timing = timing) %>% 
  select(leaf_plot, total_area, timing)
test

#get the difference of each two columns
test_new <- test %>% 
  group_by(leaf_plot) %>% 
  mutate(dmg_diff = total_area - lag(total_area)) %>% 
  na.omit() %>% 
  select(leaf_plot, dmg_diff) %>% 
  mutate(dmg_diff = abs(dmg_diff)) %>% 
test_new

#check to make sure these values are correct 
diff(test$total_area[1:2])
diff(test$total_area[3:4])

beans$leaf_plot <- as.factor(beans$leaf_plot)
# now to do this to the whole data set (beans)
beans_new <- beans %>% 
  group_by(leaf_plot) %>% 
  mutate(dmg_diff = total_area - lag(total_area)) %>% 
  na.omit() %>% 
  select(leaf_plot, dmg_diff) %>% 
  mutate(dmg_diff = abs(dmg_diff)) %>% 
  mutate(across(c('dmg_diff'),round,2))
  
beans_new 

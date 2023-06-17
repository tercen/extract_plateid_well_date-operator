library(tercen)
library(tidyverse)

ctx = tercenCtx()

df <- ctx %>% rselect()


df <- df %>% 
  extract(col =1L, into = c("date"),      "([[:digit:]]+)", remove = FALSE)

df <- df %>%   
  extract(col =1L, into = c("well_id"),   "([ABCDEFGH][[:digit:]]+)", remove = FALSE) %>%
  extract(col = "well_id",   into = "well_row",  regex = "([[:alpha:]]+)", remove =FALSE) %>%
  extract(col = "well_id",   into = "well_col",  regex = "([[:digit:]]+)", remove =FALSE)

df <- df %>%    
  extract(col =1L, into = c("plate_id"),  "(Plate[[:alnum:]]+)",      remove = FALSE) %>% 
  extract(col =1L, into = c("plate_id2"), "(Plate-[[:alnum:]]+)",     remove = FALSE) %>%
  extract(col =1L, into = c("plate_id3"), "(plate[[:alnum:]]+)",      remove = FALSE) %>%
  extract(col =1L, into = c("plate_id4"), "(Platte-[[:alnum:]]+)",    remove = FALSE) %>%
  unite(col="plate_all", contains("plat"), sep = "", remove = TRUE, na.rm = TRUE)

df <- df %>%   
  extract(col = "plate_all", into = "plate_num", regex = "([[:digit:]]+)", remove =TRUE) %>%
  mutate(plate_num = as.double(plate_num))

well_row_key <-list()
well_row_key['A'] <- 1
well_row_key['B'] <- 2
well_row_key['C'] <- 3
well_row_key['D'] <- 4
well_row_key['E'] <- 5
well_row_key['F'] <- 6
well_row_key['G'] <- 7
well_row_key['H'] <- 8

well_col_key <-list()
well_col_key['01'] <- 1
well_col_key['02'] <- 2
well_col_key['03'] <- 3
well_col_key['04'] <- 4
well_col_key['05'] <- 5
well_col_key['06'] <- 6
well_col_key['07'] <- 7
well_col_key['08'] <- 8
well_col_key['09'] <- 9
well_col_key['10'] <- 10
well_col_key['11'] <- 11
well_col_key['12'] <- 12

df <- df  %>% mutate(well_row_num = unlist(well_row_key[well_row]))
df <- df  %>% mutate(well_col_num = unlist(well_col_key[well_col]))

df_out <- df %>%
  select(-c(1))


df_out %>% 
  mutate(.ri = seq_len(nrow(.))-1L) %>%
  ctx$addNamespace() %>%
  ctx$save()
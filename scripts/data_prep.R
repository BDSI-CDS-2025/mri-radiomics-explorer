# data_prep.R
# one-off ETL script to build *processed/*
#
# to run: Rscript scripts/data_prep.R

library(dplyr)
library(arrow)

raw_im <- read.csv('data/raw/imagingFeatures.csv')
raw_clin <- read.csv('data/raw/clinicalData_clean.csv')

# harmonize id and column names
cln <- raw_im %>% 
    inner_join(raw_clin, by='Patient.ID') %>%
    janitor::clean_names() %>% # resulting names only consist of '_', character, number, and letter
    mutate(across(where(is.character), ~na_if(., ''))) %>% 
    mutate(across(where(is.numeric), scale))

# https://www.rdocumentation.org/packages/dplyr/versions/1.0.10/topics/na_if
# . represents the current column and ~ will be used for anonymous functions applied across columns
# across() will select all comments with the given condition
# is.character means that the data type for that column is a character
# any argument matching the second value will be replaced with the first (NA)
# is.numeric means that the data type for that column is numeric
# scale will standardize every column so that it has mean zero and standard deviation 1

arrow::write_parquet(cln, 'data/processed/duke_cleaned.parquet')

# rds = R data serialization file
saveRDS(cln, 'data/processed/duke_cleaned.rds')
#!/usr/bin/env Rscript

# replace words with snake case; e.g., "Specimen ID" becomes "specimen_id"
snake_case = function(x) str_to_lower(str_replace_all(x, ' ', '_'))

# rename all columns in df by applying func
modify_names = function(df, func) {
  old_names = names(df)
  new_names = sapply(old_names, func)
  rename(df, !!!setNames(as.list(old_names), new_names))
}

# read in the original data
read_csv('IsolateData.csv', n_max=100) %>%
  # gather the antibiotic testing columns
  gather('key', 'measure', `AMI Equiv`:`TIO Concl`) %>%
  # remove antibiotic tests that were not done
  filter(!is.na(measure)) %>%
  # e.g., break up the key "AMI Equiv" to drug "AMI" and metric "Equiv"
  mutate(drug=str_match(key, '^([A-Z]{3})\\s')[,2],
         metric=str_match(key, '^[A-Z]{3}\\s(.*)')[,2]) %>%
  select(-key) %>%
  # rename all the columns
  modify_names(snake_case) %>%
  # replace "Region 2" with just 2
  mutate(region=as.integer(str_extract(region_name, '\\d+'))) %>%
  select(-region_name) %>%
  # replace age group '="0-4"' with just '0-4'
  mutate(age_group=str_replace_all(age_group, '"', ''),
         age_group=str_replace_all(age_group, '=', '')) %>%
  # sort
  arrange(specimen_id, drug, metric) %T>%
  glimpse %>%
  write_tsv('narms.tsv')

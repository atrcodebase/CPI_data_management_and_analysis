# Required packages 

#### Check if All packages are installed -------------------------------------------------------
packages <- c("tidyverse", "glue", "openxlsx", "googlesheets4", "writexl", "readxl")
new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

#### Load Packages -------------------------------------------------------
library(tidyverse)
library(glue)
library(openxlsx)
library(googlesheets4)
library(writexl)
library(readxl)

rm("new_packages", "packages")



# TODO: Update the script for below forms
# Form 4: IME version 2 (from week 11 onwards)
# Form 5.1: Bank Operationality Status
# form 9: MMOs
# form 10: Government Employee_Salary_Payment_Verification
# form 11: Railway Count


# load required packages --------------------------------------------------------
source("R/required_packages.R")

# Custom Functions --------------------------------------------------------
`%notin%` <- Negate(`%in%`)

perc_fun <- function(var, level){
  round( mean({{var}} == level , na.rm = T) * 100,1)
}

# 1 - Food Items

# Read Data ---------------------------------------------------------------
data_path <- "output/merge data forms_applied cleaning log/"
source("R/read_data_merged.R")

# Unify Units -------------------------------------------------------------

fi_sub_items <- fi_sub_items %>% mutate(
  UNIT_AMOUNT_FI_CALCULATED = case_when(
    Item_In_Stock_Shop == "Yes" & choice == "Shampoo" & Unit_FI == "Liter (L)" ~ Unit_Amount_FI * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Soap (bar)" & Unit_FI == "1 set of bar soaps" ~ 6,
    TRUE ~ Unit_Amount_FI
  ),
  PRICE_FI_CALCULATED = case_when(
    Item_In_Stock_Shop == "Yes" & choice == "Bananas" & Unit_FI == "Kilogram (KG)" ~ Price_FI / (Unit_Amount_FI*0.54054),
    Item_In_Stock_Shop == "Yes" & choice == "Garlic" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Imported vegetable oil" & Unit_FI == "Liter (L)" ~ Price_FI * 1.0845,
    Item_In_Stock_Shop == "Yes" & choice == "Imported vegetable oil" & Unit_FI == "grams" ~ Price_FI / Unit_Amount_FI * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "bread" ~ (Price_FI / weight_nan) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Nan (small loaf)" ~ (Price_FI / weight_nan) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Milk (fresh)" & Unit_FI == "Kilogram (KG)" ~ Price_FI / 0.970873786,
    Item_In_Stock_Shop == "Yes" & choice == "Milk (fresh)" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000 / 0.970873786,
    Item_In_Stock_Shop == "Yes" & choice == "Yogurt" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Laundry detergent" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Tomato paste" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Tomato paste" & Unit_FI == "Kilogram (KG)" & Unit_Amount_FI < 1 ~ (Price_FI / Unit_Amount_FI),
    # Item_In_Stock_Shop == "Yes" & choice == "Tomato paste" & Unit_FI == "Kilogram (KG)" & Unit_Amount_FI >= 1 ~ (Price_FI / Unit_Amount_FI) * 0.8,
    Item_In_Stock_Shop == "Yes" & choice == "Pasta" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Green tea (loose leaf)" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Wrapped sweets" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Chickpeas" & Unit_FI == "grams" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Toothpaste" & Unit_FI == "milliliter (mL)" ~ (Price_FI / Unit_Amount_FI) * 100,
    Item_In_Stock_Shop == "Yes" & choice == "Toothpaste" & Unit_FI == "grams" ~ ((Price_FI / Unit_Amount_FI) / 0.769) * 100,
    Item_In_Stock_Shop == "Yes" & choice == "Imported vegetable oil" & Unit_FI == "milliliter (mL)" ~ (Price_FI / Unit_Amount_FI) * 1000 * 1.136,
    Item_In_Stock_Shop == "Yes" & choice == "Milk (fresh)" & Unit_FI == "milliliter (mL)" ~ (Price_FI / Unit_Amount_FI) * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "Shampoo" ~ (Price_FI / UNIT_AMOUNT_FI_CALCULATED) * 400,
    Item_In_Stock_Shop == "Yes" & choice == "Salt" & Unit_FI == "grams" ~ Price_FI / Unit_Amount_FI * 1000,
    Item_In_Stock_Shop == "Yes" & choice == "White sugar" & Unit_FI == "grams" ~ Price_FI / Unit_Amount_FI * 1000,
    TRUE ~ Price_FI
  ),
  
  UNIT_AMOUNT_FI_CALCULATED = case_when(
    Item_In_Stock_Shop == "Yes" & choice == "Bananas" & Unit_FI == "Kilogram (KG)" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Garlic" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Yogurt" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Imported vegetable oil" & Unit_FI == "milliliter (mL)" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Imported vegetable oil" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Milk (fresh)" & Unit_FI == "milliliter (mL)" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Milk (fresh)" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Laundry detergent" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Tomato paste" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Pasta" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Green tea (loose leaf)" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Wrapped sweets" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Chickpeas" & Unit_FI == "grams" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Shampoo" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Toothpaste" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "bread" ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "Salt" & Unit_FI == "grams"  ~ 1,
    Item_In_Stock_Shop == "Yes" & choice == "White sugar" & Unit_FI == "grams"  ~ 1,
    TRUE ~ UNIT_AMOUNT_FI_CALCULATED
  ),
  
  UNIT_FI_STANDARDIZED = case_when(
    Item_In_Stock_Shop == "Yes" & choice == "Bananas" ~ "Set of 12 (Dozen)",
    Item_In_Stock_Shop == "Yes" & choice == "Garlic" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Imported vegetable oil" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Milk (fresh)" ~ "Liter (L)",
    Item_In_Stock_Shop == "Yes" & choice == "Yogurt" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Laundry detergent" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Tomato paste" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Pasta" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Green tea (loose leaf)" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Wrapped sweets" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Chickpeas" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Toothpaste" ~ "100 ML",
    Item_In_Stock_Shop == "Yes" & choice == "Shampoo" ~ "400 ML",
    Item_In_Stock_Shop == "Yes" & choice == "Soap (bar)" ~ "1 bar soap",
    Item_In_Stock_Shop == "Yes" & choice == "bread" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Nan (small loaf)" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "Salt" ~ "Kilogram (KG)",
    Item_In_Stock_Shop == "Yes" & choice == "White sugar" ~ "Kilogram (KG)",
    
    TRUE ~ Unit_FI
  ),
  UNIT_AMOUNT_FI_STANDARDIZED = case_when(
    Item_In_Stock_Shop == "Yes" ~ 1
  ),
  
  PRICE_FI_STANDARDIZED = case_when(
    Item_In_Stock_Shop == "Yes" & choice %notin% c("Toothpaste",
                                                   "Shampoo"
    )  ~ PRICE_FI_CALCULATED / UNIT_AMOUNT_FI_CALCULATED,
    TRUE ~ PRICE_FI_CALCULATED
  ), .after = weight_nan
) %>% select(-c(UNIT_AMOUNT_FI_CALCULATED, PRICE_FI_CALCULATED ))


# MERGE main sheet
# Make a subset of main sheet to to be merged with repeat sheets.
fi_main_sub <- fi_main  %>% select(
  SubmissionDate,
  Starttime,
  Endtime,
  duration,
  year,
  month,
  week,
  Planned_data_collection_period_TPMA,
  Sector_Name,
  Number_of_TPMA_visits_by_Sector,
  TPMA_Location_Visit_Type,
  TPMA_Location_Visit_ID,
  Number_of_TPMA_Visits_by_Location_Type,
  Number_of_TPMA_Visits_by_Location,
  Type_Of_Visit,
  Location_Type,
  Type_of_center,
  Region,
  Interviewee_Respondent_Type,
  KEY
)

# Changed KEY_main_sheet to KEY_Main
fi_merged_data <- fi_main_sub %>% right_join(fi_sub_items, by = c("KEY" = "KEY_Main"), keep =T)  %>% 
  select( -KEY.x ) %>% rename(KEY = KEY.y)

# 2 - Non-Food Items
# recode price and units
nfi_sub_items <- nfi_sub_items %>%
  mutate(
    price_NFI_calculated = case_when(
    Item_In_Stock_Shop == "Yes" & (Unit_NFI == "Gallon (G)") ~ Price_Cost_NFI / 5,
      # Item_In_Stock_Shop == "Yes" & choice %in% c("Fabric for boys (child)", "Fabric for girls (child)", "Fabric for men", "Fabric for women" ) ~ Price_Cost_NFI * Required_Fabric,
      TRUE ~ Price_Cost_NFI,
    ),
    UNIT_NFI_STANDARDIZED = case_when(
      Item_In_Stock_Shop == "Yes" & Unit_NFI == "Gallon (G)" ~ "Litre (L)",
      Item_In_Stock_Shop == "Yes" & choice == "Notebooks for students (40 pages, ruled/commonly used/regular quality notebook)"  ~ "1 Notebook",
      Item_In_Stock_Shop == "Yes" & choice == "Pens (commonly used/regular quality)"  ~ "1 Pen",
      # Item_In_Stock_Shop == "Yes" & choice == "Fabric for boys (child)"  ~ "Fabric for boys clothing",
      # Item_In_Stock_Shop == "Yes" & choice == "Fabric for girls (child)"  ~ "Fabric for girls clothing",
      # Item_In_Stock_Shop == "Yes" & choice == "Fabric for men"  ~ "Fabric for men's clothing",
      # Item_In_Stock_Shop == "Yes" & choice == "Fabric for women"  ~ "Fabric for fabric women's clothing",
      TRUE ~ Unit_NFI
    ),
    PRICE_NFI_STANDARDIZED = case_when(
      !is.na(Unit_NFI_Amount) ~ price_NFI_calculated / Unit_NFI_Amount,
      TRUE ~ price_NFI_calculated
    ),
    .after = Price_Cost_NFI
  ) %>% select(-c(price_NFI_calculated))


# MERGE main sheet
# Make a subset of main sheet to to be merged with repeat sheets.
nfi_main_sub <- nfi_main  %>% select(
  SubmissionDate,
  Starttime,
  Endtime,
  duration,
  year,
  month,
  week,
  Planned_data_collection_period_TPMA,
  Sector_Name,
  Number_of_TPMA_visits_by_Sector,
  TPMA_Location_Visit_Type,
  TPMA_Location_Visit_ID,
  Number_of_TPMA_Visits_by_Location_Type,
  Number_of_TPMA_Visits_by_Location,
  Type_Of_Visit,
  Location_Type,
  Type_of_center,
  Region,
  Interviewee_Respondent_Type,
  KEY
  
)

nfi_merged_data <- nfi_main_sub %>% right_join(nfi_sub_items, by = c("KEY" = "KEY_Main"), keep = T) %>% 
  select( -KEY.x ) %>% rename(KEY = KEY.y)

nfi_merged_data <- nfi_merged_data %>% 
  mutate(
    UNIT_AMOUNT_NFI_STANDARDIZED = 1,
    .after = UNIT_NFI_STANDARDIZED,
  ) %>% select(-c(unit2, `SET-OF-Nfi_items_available`))

# filter NFI from FI
fi_merged_data_NFI <- fi_merged_data %>% 
  filter(choice %in% c("Laundry detergent", "Soap (bar)", "Shampoo","Toothpaste")) %>% 
  rename(
    Unit_NFI = Unit_FI,
    Unit_NFI_Amount = Unit_Amount_FI,
    Price_Cost_NFI = Price_FI,
    UNIT_NFI_STANDARDIZED = UNIT_FI_STANDARDIZED,
    PRICE_NFI_STANDARDIZED = PRICE_FI_STANDARDIZED,
    UNIT_AMOUNT_NFI_STANDARDIZED = UNIT_AMOUNT_FI_STANDARDIZED,
    Availability_NFI = Availability_FI
    
    
  ) %>% select(-c(weight_nan)) %>% 
  mutate(
    Required_Fabric = "",
    .after = PRICE_NFI_STANDARDIZED
  )

nfi_merged_final <- rbind(nfi_merged_data, fi_merged_data_NFI)
nfi_merged_final <- nfi_merged_final %>% mutate(
  Labour_Weekly_Working_Days = "",
  .after = Availability_NFI
)

# Market Survices
ms_sub_items_3_bedroom <- ms_sub_items %>% filter(
  choice == "Real Estate Agent"
  ) %>%  mutate(
  Price_Cost_NFI = case_when(
    choice == "Real Estate Agent" ~ Rent_Cost_2_Bedroom,
  ),
  choice = case_when(
    choice == "Real Estate Agent" ~ "3 Bedroom house",
  )
 
)

ms_sub_items_4_bedroom <- ms_sub_items %>% filter(
  choice == "Real Estate Agent"
) %>%  mutate(
  Price_Cost_NFI = case_when(
    choice == "Real Estate Agent" ~ Rent_Cost_3_Bedroom,
  ),
  choice = case_when(
    choice == "Real Estate Agent" ~ "4 Bedroom house",
  )
  
)

real_state <- rbind(ms_sub_items_3_bedroom, ms_sub_items_4_bedroom )

# Doctors Fee
doctors_fee <- ms_sub_items %>% filter(
  choice == "Paracetamol"
) %>%  mutate(
  Price_Cost_NFI = case_when(
    choice == "Paracetamol" ~ NFI_Fee,
  ),
  choice = case_when(
    choice == "Paracetamol" ~ "Doctor Consultation Fee",
  ),
  Unit_NFI = case_when(
    TRUE ~ "Doctor Consultation"
  ),
  Availability_NFI = case_when(
    TRUE ~ ""
  ),
  Item_In_Stock_Shop = case_when(
    TRUE ~ ""
  ),
  unit2 = case_when(
    TRUE ~ ""
  )
  
)

# Labour dataset
ms_sub_labour_type_fixed <- ms_sub_labour_type %>% rename(
  choice = Labour_Types,
  ) %>% 
  mutate(
    unit2 = "",
    fee   = "",
    Item_In_Stock_Shop = "",
    Unit_NFI = "1 Day",
    Unit_NFI_Amount = 1,
    Price_Cost_NFI  = Labour_Rate,
    .after = choice
  ) %>% select(-c(`SET-OF-Labour_Types_rep`, Labour_Rate)) %>% 
  mutate(
    Availability_NFI = "",
    .after = Price_Cost_NFI
  ) #%>% select(-c(labour_gender))

ms_sub_items_reshaped <- ms_sub_items %>% 
  mutate(
    Price_Cost_NFI = case_when(
      
      choice == "Men’s haircut" ~ Barber_Fee,
      choice == "One child’s (boy) perahan wa tonban" ~ Tailor_Fee_Perahan,
      choice == "One girl’s dress" ~ Tailor_Fee_Perahan,
      choice == "One man’s perahan wa tonban" ~ Tailor_Fee_Perahan,
      choice == "One women’s perahan" ~ Tailor_Fee_Perahan,
      choice %in% c("Shared taxi/van/risckshaw driver", "Shared taxi/van/risckshaw  driver") ~ Price_Taxi,
      TRUE ~ Price_Cost_NFI,
    ),
      choice = case_when(
        choice %in% c("Shared taxi/van/risckshaw driver", "Shared taxi/van/risckshaw  driver") ~ Transportation_Type,
        TRUE ~ choice
      ),
      
    ) %>% filter(choice != "Real Estate Agent") 
 
ms_sub_items_reshaped_real_state <- rbind(ms_sub_items_reshaped, real_state)

ms_sub_items_reshaped_real_state <- rbind(ms_sub_items_reshaped_real_state, doctors_fee) %>% 
  select(-c(NFI_Fee,
            Transportation_Type,
            Price_Taxi,
            Tailor_Fee_Perahan,
            Barber_Fee,
            Rent_Cost_3_Bedroom,
            Rent_Cost_2_Bedroom,
            `SET-OF-Nfi_items_available`
  )) %>% mutate(
    Labour_Weekly_Working_Days = "",
    .after = Availability_NFI
  )

MS_all_NFI_merged <- rbind(ms_sub_items_reshaped_real_state, ms_sub_labour_type_fixed) %>% 
  select(-c(unit2,	fee))

ms_main_clean <- ms_main %>% select(
  -c(
    `Geopoint1-Latitude`,
    `Geopoint1-Longitude`,
    Sector_Name,
    Number_of_TPMA_visits_by_Sector,
    TPMA_Location_Visit_ID,
    Number_of_TPMA_Visits_by_Location_Type,
    Number_of_TPMA_Visits_by_Location,
    Type_Of_Visit,
    Sampling_Proposed_By,
    Type_Of_Sampling,
    `SET-OF-Sub_resp`
  )
)

ms_main_sub <- ms_main %>% select(
  SubmissionDate,
  Starttime,
  Endtime,
  duration,
  year,
  month,
  week,
  Planned_data_collection_period_TPMA,
  Sector_Name,
  Number_of_TPMA_visits_by_Sector,
  TPMA_Location_Visit_Type,
  TPMA_Location_Visit_ID,
  Number_of_TPMA_Visits_by_Location_Type,
  Number_of_TPMA_Visits_by_Location,
  Type_Of_Visit,
  Location_Type,
  Region,
  Type_of_center,
  Interviewee_Respondent_Type,
  KEY
)

ms_nfi_merged <- ms_main_sub %>% right_join(MS_all_NFI_merged, by = c("KEY" = "KEY_Main"), keep = T ) %>% 
  select( -KEY.x ) %>% rename(KEY = KEY.y)

ms_nfi_merged <- ms_nfi_merged %>% mutate(
  UNIT_NFI_STANDARDIZED = case_when(
    choice == "Shared taxi" ~ "1 Ride",
    choice == "Shared van" ~ "1 Ride",
    choice == "Shared rickshaw" ~ "1 Ride",
    choice == "3 Bedroom house" ~ "1 Month",
    choice == "4 Bedroom house" ~ "1 Month",
    choice == "Carpenter" ~ Unit_NFI,
    choice == "Doctor Consultation Fee" ~ Unit_NFI,
    choice == "Electrician" ~ Unit_NFI,
    choice == "Mason" ~ Unit_NFI,
    choice == "Men’s haircut" ~ "1 Haircut",
    choice == "One child’s (boy) perahan wa tonban" ~ "Tailor fee for 1 set of clothes",
    choice == "One girl’s dress" ~ "Tailor fee for 1 set of clothes",
    choice == "One man’s perahan wa tonban" ~ "Tailor fee for 1 set of clothes",
    choice == "One women’s perahan" ~ "Tailor fee for 1 set of clothes",
    choice == "Painter" ~ Unit_NFI,
    choice == "Paracetamol" ~ "Packet of 10 tablets",
    choice == "Plumber" ~ Unit_NFI,
    choice == "Tile worker" ~ Unit_NFI,
    choice == "Unskilled labourer" ~ Unit_NFI,
  ),
    UNIT_AMOUNT_NFI_STANDARDIZED = 1,
    PRICE_NFI_STANDARDIZED = Price_Cost_NFI,
    Required_Fabric = "",
  .after = Price_Cost_NFI
)

NFI_all_merged_final <- rbind(nfi_merged_final, ms_nfi_merged)
NFI_all_merged_final$Required_Fabric <- as.numeric(NFI_all_merged_final$Required_Fabric)

NFI_all_merged_final <- NFI_all_merged_final %>% select(-c(SubmissionDate,
                                                           duration,
                                                           Sector_Name,
                                                           Number_of_TPMA_visits_by_Sector,
                                                           TPMA_Location_Visit_Type,
                                                           TPMA_Location_Visit_ID,
                                                           Number_of_TPMA_Visits_by_Location_Type,
                                                           Number_of_TPMA_Visits_by_Location,
                                                           Type_Of_Visit
)) %>% rename(Items = choice) 

NFI_all_merged_final$Labour_Weekly_Working_Days <- as.numeric(NFI_all_merged_final$Labour_Weekly_Working_Days)
NFI_all_merged_final$PRICE_NFI_STANDARDIZED <- round(as.numeric(NFI_all_merged_final$PRICE_NFI_STANDARDIZED), 4)

NFI_all_merged_final <- NFI_all_merged_final %>% mutate(
  PRICE_NFI_STANDARDIZED = case_when(
    PRICE_NFI_STANDARDIZED == 9999 ~ NA_real_,
    PRICE_NFI_STANDARDIZED == 8888 ~ NA_real_,
    TRUE ~ PRICE_NFI_STANDARDIZED
  )
  
)

fi_main <- fi_main %>% select(-c(`SET-OF-Sub_resp`))

NFI_list <- list(
  NFI_PRICE_DATA = NFI_all_merged_final,
  NFI_TAX_BARTER = nfi_sub_rep,
  NFI_MARKETS = nfi_main,
  NFI_KI = nfi_sub_resp,
  SERVICES_MARKETS = ms_main_clean,
  SERVICES_KI = ms_sub_resp
)

# Prepare Food Items
fi_merged_data_sub <- fi_merged_data %>% select(-c(SubmissionDate,
                                               duration,
                                               Sector_Name,
                                               Number_of_TPMA_visits_by_Sector,
                                               TPMA_Location_Visit_Type,
                                               TPMA_Location_Visit_ID,
                                               Number_of_TPMA_Visits_by_Location_Type,
                                               Number_of_TPMA_Visits_by_Location,
                                               Type_Of_Visit
)) %>% rename(Items = choice) %>% filter(Items %notin% c("Laundry detergent", "Soap (bar)", "Shampoo","Toothpaste"))

fi_merged_data_sub$PRICE_FI_STANDARDIZED <- round(fi_merged_data_sub$PRICE_FI_STANDARDIZED, 4)

# fi_sub_rep_merged
FI_LIST <- list(
  FI_PRICES_DATA = fi_merged_data_sub,
  FI_TAX_BARTER = fi_sub_rep,
  FI_MARKETS = fi_main,
  FI_KI = fi_sub_resp
)

# HAWALA ------------------------------------------------------------------
mex_main_sub <- mex_main %>% select(
  Starttime,
  Endtime,
  year,
  month,
  week,
  Planned_data_collection_period_TPMA,
  Site_Visit_ID,
  Site_Visit_Subcategory_ID,
  TPMA_Location_Name,
  TPMA_Location_ID,
  Type_Of_Visit,
  Location_Type,
  Type_of_center,
  Region,
  Province,
  District,
  Interviewee_Respondent_Type,
  KEY
  
)

mex_cur_ex <- mex_cur_ex %>% select(
  -c(
    Site_Visit_ID,
    Site_Visit_Subcategory_ID,
    TPMA_Location_Name,
    TPMA_Location_ID,
    Province,
    District,
    `SET-OF-Currency_Exchangers`
    
  )
)

mex_cur_ex_merged <- mex_main_sub %>% right_join(mex_cur_ex, by = c("KEY" = "KEY_Main"), keep = T) %>% 
  select( -KEY.x ) %>% rename(KEY = KEY.y) 
  
exchange <- mex_cur_ex_merged %>% filter(exchange_unit != 0) %>% select(
  -c(
    Money_Transfer_Availability,
    Money_Transfer_Destination1st,
    Money_Transfer_Destination2nd,
    Money_Transfer_Destination3rd,
    Money_Transfer_Destination_Other,
    Transfer_Fee_Same,
    Transfer_Max_Amount,
    Transfer_Changes,
    exchange
  )
) %>% rename(Currency = choice)

Hawala <- mex_cur_ex_merged %>% mutate(
  HAWALA_ORIGIN = "",
  HAWALA_DESTINATION = "",
  .after = exchange
) %>% select(
  -c(
    exchange_unit,
    Exchange_Rate_buying,
    Exchange_Rate_selling,
    Currency_Availability,
    
  )
)

hawala_dest_same1 <- Hawala %>% filter(Transfer_Fee_Same == "Yes") %>% mutate(Dest_temp = 1) 
hawala_dest_same2 <- Hawala %>% filter(Transfer_Fee_Same == "Yes") %>% mutate(Dest_temp = 2)
hawala_dest_same3 <- Hawala %>% filter(Transfer_Fee_Same == "Yes") %>% mutate(Dest_temp = 3)

hawala_dest_same_all <- rbind(hawala_dest_same1,hawala_dest_same2 )
hawala_dest_same_all <- rbind(hawala_dest_same_all, hawala_dest_same3)

mex_trans_fee_same_sub <- mex_trans_fee_same %>% select(-c(
  Site_Visit_ID,
  Site_Visit_Subcategory_ID,
  TPMA_Location_Name,
  TPMA_Location_ID,
  Province,
  District,
  KEY,
  KEY_Main
  
  
))

hawala_dest_same_all_merged <- hawala_dest_same_all %>% left_join(mex_trans_fee_same_sub, by = c("KEY" = "PARENT_KEY")) %>%  

  mutate(
    HAWALA_ORIGIN = Province,
    HAWALA_DESTINATION = case_when(
      Dest_temp == 1 ~ Money_Transfer_Destination1st,
      Dest_temp == 2 ~ Money_Transfer_Destination2nd,
      Dest_temp == 3 ~ Money_Transfer_Destination3rd,
      
    )
  ) %>% rename(
    Transfer_Fee_Amount_Destination_Rang1 = Transfer_Fee_Amount_Rang_Rang1,
    Transfer_Fee_Amount_Destination_Rang2 = Transfer_Fee_Amount_Rang_Rang2,
    Transfer_Fee_Amount_Destination_Fee = Transfer_Fee_Amount_Fee,
    Transfer_Fee_Amount_Destination_Fee_Type = Transfer_Fee_Amount_Fee_Type
  ) %>%  select(

    Starttime:exchange,
    Money_Transfer_Availability,
    HAWALA_ORIGIN:HAWALA_DESTINATION,
    Dest_temp,
    Transfer_Fee_Amount_Destination_Rang1:Transfer_Fee_Amount_Destination_Fee_Type,
    Transfer_Max_Amount:Transfer_Changes,
    PARENT_KEY,
    KEY_Main
  )


hawala_dest_1 <- Hawala %>% filter(Transfer_Fee_Same == "No") %>% mutate(Dest_temp = 1)

mex_trans_fee_amount_1_sub <- mex_trans_fee_amount_1 %>% select(-c(
  Site_Visit_ID,
  Site_Visit_Subcategory_ID,
  TPMA_Location_Name,
  TPMA_Location_ID,
  Province,
  District,
  KEY,
  KEY_Main
))

hawala_dest_1_merged <- mex_trans_fee_amount_1_sub %>%  left_join(hawala_dest_1, by = c("PARENT_KEY" = "KEY")) %>%  
  
  mutate(
    HAWALA_ORIGIN = Province,
    HAWALA_DESTINATION = case_when(
      Dest_temp == 1 ~ Money_Transfer_Destination1st.x
      
    )
  ) %>% select(-c(Money_Transfer_Destination1st.y)) %>% rename(Transfer_Fee_Amount_Destination_Rang1 = Transfer_Fee_Amount_Destination_1_Rang1,
                                                               Transfer_Fee_Amount_Destination_Rang2 = Transfer_Fee_Amount_Destination_1_Rang2,
                                                               Transfer_Fee_Amount_Destination_Fee = Transfer_Fee_Amount_Destination_1_Fee,
                                                               Transfer_Fee_Amount_Destination_Fee_Type = Transfer_Fee_Amount_Destination_1_Fee_Type,
                                                               Money_Transfer_Destination1st = Money_Transfer_Destination1st.x
)

hawala_dest_2 <- Hawala %>% filter(Transfer_Fee_Same == "No") %>% mutate(Dest_temp = 2)

mex_trans_fee_amount_2_sub <- mex_trans_fee_amount_2 %>% select(-c(
  Site_Visit_ID,
  Site_Visit_Subcategory_ID,
  TPMA_Location_Name,
  TPMA_Location_ID,
  Province,
  District,
  KEY,
  KEY_Main
))

hawala_dest_2_merged <- mex_trans_fee_amount_2_sub %>%  left_join(hawala_dest_2, by = c( "PARENT_KEY" = "KEY")) %>%  
  
  mutate(
    HAWALA_ORIGIN = Province,
    HAWALA_DESTINATION = case_when(
      Dest_temp == 2 ~ Money_Transfer_Destination2nd.x
      
    )
  ) %>% select(-c(Money_Transfer_Destination2nd.y)) %>% rename(Transfer_Fee_Amount_Destination_Rang1 = Transfer_Fee_Amount_Destination_2_Rang1,
                                                               Transfer_Fee_Amount_Destination_Rang2 = Transfer_Fee_Amount_Destination_2_Rang2,
                                                               Transfer_Fee_Amount_Destination_Fee = Transfer_Fee_Amount_Destination_2_Fee,
                                                               Transfer_Fee_Amount_Destination_Fee_Type = Transfer_Fee_Amount_Destination_2_Fee_Type,
                                                               Money_Transfer_Destination2nd = Money_Transfer_Destination2nd.x)

hawala_dest_3 <- Hawala %>% filter(Transfer_Fee_Same == "No") %>% mutate(Dest_temp = 3) 

mex_trans_fee_amount_3_sub <- mex_trans_fee_amount_3 %>% select(-c(
  Site_Visit_ID,
  Site_Visit_Subcategory_ID,
  TPMA_Location_Name,
  TPMA_Location_ID,
  Province,
  District,
  KEY,
  KEY_Main
))

hawala_dest_3_merged <- mex_trans_fee_amount_3_sub %>% left_join(hawala_dest_3, by = c("PARENT_KEY" = "KEY")) %>%  
  
  mutate(
    HAWALA_ORIGIN = Province,
    HAWALA_DESTINATION = case_when(
      Dest_temp == 3 ~ Money_Transfer_Destination3rd.x
      
    )
  ) %>% select(-c(Money_Transfer_Destination3rd.y)) %>% rename(Transfer_Fee_Amount_Destination_Rang1 = Transfer_Fee_Amount_Destination_3_Rang1,
                                                                   Transfer_Fee_Amount_Destination_Rang2 = Transfer_Fee_Amount_Destination_3_Rang2,
                                                                   Transfer_Fee_Amount_Destination_Fee = Transfer_Fee_Amount_Destination_3_Fee,
                                                                   Transfer_Fee_Amount_Destination_Fee_Type = Transfer_Fee_Amount_Destination_3_Fee_Type,
                                                                   Money_Transfer_Destination3rd = Money_Transfer_Destination3rd.x)

hawala_dest_not_same_all <- rbind(hawala_dest_1_merged, hawala_dest_2_merged)
hawala_dest_not_same_all <- rbind(hawala_dest_not_same_all, hawala_dest_3_merged)

hawala_dest_not_same_all <- hawala_dest_not_same_all %>% select(Starttime:exchange,
                                                                 Money_Transfer_Availability,
                                                                 HAWALA_ORIGIN:HAWALA_DESTINATION,
                                                                 Dest_temp,
                                                                 Transfer_Fee_Amount_Destination_Rang1:Transfer_Fee_Amount_Destination_Fee_Type,
                                                                 # Transfer_Max_Amount.y:Transfer_Changes.y,
                                                                Transfer_Max_Amount = Transfer_Max_Amount.y,
                                                                Transfer_Changes = Transfer_Changes.y,
                                                                 # Transfer_Max_Amount.x:Transfer_Changes.x,
                                                                 PARENT_KEY,
                                                                KEY_Main
                                                                 )

hawal_fee_all_merged <- rbind(hawala_dest_same_all_merged, hawala_dest_not_same_all) %>% rename(
  HAWALA_TOP3_DESTINATION_RANK = Dest_temp, Hawala_Type = choice
)

mex_cur_ex_Hawal <- mex_cur_ex_merged %>%  filter(choice %in% c("International", "Domestic")) %>% select(
  -c(
    exchange,
    exchange_unit,
    Exchange_Rate_buying,
    Exchange_Rate_selling,
    Currency_Availability,
    
  )
)  %>% rename(Hawala_Type = choice)

hawala_list <- list(
  CURRENCY_RATE = exchange,
  HAWALA_MAIN = mex_cur_ex_Hawal,
  HAWALA_FEE = hawal_fee_all_merged,
  MARKET = mex_main,
  KI = mex_sub_rep
)


# 4.1 - Hawala V2, 11th week onward

# Exchange Data
mex_main_sub_v2 <- mex_main_v2 %>% select(
  Starttime,
  Endtime,
  year,
  month,
  week,
  Planned_data_collection_period_TPMA,
  Site_Visit_ID,
  Site_Visit_Subcategory_ID,
  TPMA_Location_Name,
  TPMA_Location_ID,
  Type_Of_Visit,
  Location_Type,
  Type_of_center,
  Region,
  Province,
  District,
  Interviewee_Respondent_Type,
  KEY
)


mex_cur_ex_v2 <- mex_cur_ex_v2 %>% select(
  -c(
    Site_Visit_ID,
    Site_Visit_Subcategory_ID,
    TPMA_Location_Name,
    TPMA_Location_ID,
    Province,
    District,
    `SET-OF-Currency_Exchangers`,
    exchange
    
  )
)

mex_cur_ex_merged_v2 <- mex_main_sub_v2 %>% right_join(mex_cur_ex_v2, by = c("KEY" = "KEY_Main"), keep = T) %>% 
  select( -KEY.x ) %>% 
  rename(KEY = KEY.y) %>%
  rename(Currency = choice)


# Hawala
# Merge main sheet with Hawala Repeat sheet
mex_hawala_transfer_v2 <- mex_hawala_transfer_v2 %>% select(
  -c(Site_Visit_ID, Site_Visit_Subcategory_ID, TPMA_Location_Name, TPMA_Location_ID, Province, District)
) %>% left_join(mex_main_sub_v2, by = c("KEY_Main" = "KEY")) %>% 
  relocate(Starttime:Interviewee_Respondent_Type, .before = choice)

#Reshapes Hawala V2 data for all destinations
reshape_hawala <- function(data, transfer_fee_cols, dest_type, fee_type){
  
  mex_hawala_transfer_v2_reshaped <- data.frame()
  for(i in 1:3){
    
    destination <- case_when(
      i == 1 ~ "Money_Transfer_Destination1st",
      i == 2 ~ "Money_Transfer_Destination2nd",
      i == 3 ~ "Money_Transfer_Destination3rd"
    )
    fee_percentage_amount <- case_when(
      fee_type == "Percentage" ~ "Percentage of the total amount being transferred",
      fee_type == "Amount" ~ "Set fee based on the total amount being transferred"
    )
    
    if(dest_type == "diff"){
      transfer_fee_cols_sub <- case_when(
        destination == "Money_Transfer_Destination1st" ~ transfer_fee_cols[[1]],
        destination == "Money_Transfer_Destination2nd" ~ transfer_fee_cols[[2]],
        destination == "Money_Transfer_Destination3rd" ~ transfer_fee_cols[[3]]
      )
    } else {
      transfer_fee_cols_sub <- transfer_fee_cols
    }
    
    
    # Hawala destination fee
    mex_hawala_transfer_v2_reshaped_sub <- data %>% 
      filter(get(destination) %notin% c("No Second Destination", "No Third Destination")) %>% 
      select(Starttime:Interviewee_Respondent_Type,
             Hawala_Type = choice,
             Money_Transfer_Availability,
             # HAWALA_ORIGIN = Province,
             HAWALA_DESTINATION = destination,
             all_of(transfer_fee_cols_sub),
             Transfer_Max_Amount,
             Transfer_Changes,
             PARENT_KEY,
             KEY,
             KEY_Main
      ) %>% 
      mutate(
        Fee_Percentage_OR_Amount = fee_percentage_amount,
        HAWALA_TOP3_DESTINATION_RANK = i,
        HAWALA_ORIGIN = Province,
        Transfer_Fee_Amount_Destination_Fee_Type = fee_type,
      ) %>% 
      relocate(HAWALA_TOP3_DESTINATION_RANK , .after = HAWALA_DESTINATION) %>%
      relocate(HAWALA_ORIGIN, .before = HAWALA_DESTINATION) %>% 
      pivot_longer(!c(Starttime:HAWALA_TOP3_DESTINATION_RANK, 
                      Transfer_Max_Amount:Transfer_Fee_Amount_Destination_Fee_Type),
                   names_to = "Range",
                   values_to = "Transfer_Fee_Amount_Destination_Fee"
      ) %>% 
      relocate(Transfer_Fee_Amount_Destination_Fee_Type:Transfer_Fee_Amount_Destination_Fee,
               .after = HAWALA_TOP3_DESTINATION_RANK)
    
    mex_hawala_transfer_v2_reshaped <- rbind(mex_hawala_transfer_v2_reshaped, mex_hawala_transfer_v2_reshaped_sub)
  }
  return(mex_hawala_transfer_v2_reshaped)
}

transfer_fee_cols <- list(
  same_dest_per = c(
    "Transfer_Fee_10000_Same_dest_range1_Per",
    "Transfer_Fee_50000_Same_dest_range2_Per",
    "Transfer_Fee_100000_Same_dest_range3_Per",
    "Transfer_Fee_500000_Same_dest_range4_Per"
  ),
  same_dest_amo = c(
    "Transfer_Fee_10000_Same_dest_range1_Amo",
    "Transfer_Fee_50000_Same_dest_range2_Amo",
    "Transfer_Fee_100000_Same_dest_range3_Amo",
    "Transfer_Fee_500000_Same_dest_range4_Amo"
  ),
  diff_dest_per = list(
    first_dest_per = c(
      "Transfer_Fee_10000_first_dest_range1_Per",
      "Transfer_Fee_50000_first_dest_range2_Per",
      "Transfer_Fee_100000_first_dest_range3_Per",
      "Transfer_Fee_500000_first_dest_range4_Per"
    ),
    second_dest_per = c(
      "Transfer_Fee_10000_Second_dest_range1_Per",
      "Transfer_Fee_50000_Second_dest_range2_Per",
      "Transfer_Fee_100000_Second_dest_range3_Per",
      "Transfer_Fee_500000_Second_dest_range4_Per"
    ),
    third_dest_per = c(
      "Transfer_Fee_10000_Third_dest_range1_Per",
      "Transfer_Fee_50000_Third_dest_range2_Per",
      "Transfer_Fee_100000_Third_dest_range3_Per",
      "Transfer_Fee_500000_Third_dest_range4_Per"
    )
  ),
  diff_dest_amo = list(
    first_dest_amo = c(
      "Transfer_Fee_10000_first_dest_range1_Amo",
      "Transfer_Fee_50000_first_dest_range2_Amo",
      "Transfer_Fee_100000_first_dest_range3_Amo",
      "Transfer_Fee_500000_first_dest_range4_Amo"
    ),
    second_dest_amo = c(
      "Transfer_Fee_10000_Second_dest_range1_Amo",
      "Transfer_Fee_50000_Second_dest_range2_Amo",
      'Transfer_Fee_100000_Second_dest_range3_Amo',
      "Transfer_Fee_500000_Second_dest_range4_Amo"
    ),
    third_dest_amo = c(
      "Transfer_Fee_10000_Third_dest_range1_Amo",
      "Transfer_Fee_50000_Third_dest_range2_Amo",
      "Transfer_Fee_100000_Third_dest_range3_Amo",
      "Transfer_Fee_500000_Third_dest_range4_Amo"
    )
  )
)

mex_hawala_transfer_same_dest_per <- reshape_hawala(mex_hawala_transfer_v2, transfer_fee_cols$same_dest_per, "same", "Percentage")
mex_hawala_transfer_same_dest_amo <- reshape_hawala(mex_hawala_transfer_v2, transfer_fee_cols$same_dest_amo, "same", "Amount")
mex_hawala_transfer_diff_dest_per <- reshape_hawala(mex_hawala_transfer_v2, transfer_fee_cols$diff_dest_per, "diff", "Percentage")
mex_hawala_transfer_diff_dest_amo <- reshape_hawala(mex_hawala_transfer_v2, transfer_fee_cols$diff_dest_amo, "diff", "Amount")

# Hawala all 3 destinations for same & diff fee AND percentage & amount
hawala_fee_all_merged_v2 <- rbind(
  mex_hawala_transfer_same_dest_per,
  mex_hawala_transfer_same_dest_amo,
  mex_hawala_transfer_diff_dest_per,
  mex_hawala_transfer_diff_dest_amo
)

hawala_list_v2 <- list(
  CURRENCY_RATE = mex_cur_ex_merged_v2,
  HAWALA_FEE = hawala_fee_all_merged_v2
)

# 5 - Banks
bank_manager <- banks_main %>% select(
  -c(SubmissionDate,
     Duration,
     Date_And_Time,
     `Geopoint1-Latitude`,
     `Geopoint1-Longitude`,
     Surveyor_Id,
     Surveyor_Gender,
     Sector_Name,
     TPMA_Location_Visit_ID,
     Number_of_TPMA_visits_by_Sector,
     Number_of_TPMA_Visits_by_Location_Type,
     Sector_Name,
     Type_Of_Visit,
     Sampling_Proposed_By,
     Type_Of_Sampling,
     # More_than_weekly_limit_Please_explain_Indiv_Accounts_AFN,
     # More_than_weekly_limit_Please_explain_Indiv_Accounts_USD,
     # More_than_monthly_limit_Please_explain_Business_Accounts_AFN,
     # More_than_monthly_limit_Please_explain_Business_Accounts_USD,
     # More_than_weekly_limit_Please_explain_Indiv_Accounts_ATM_AFN,
     # More_than_weekly_limit_Please_explain_Indiv_Accounts_ATM_USD,
     # More_than_monthly_limit_Please_explain_Business_Accounts_ATM_AFN,
     # More_than_monthly_limit_Please_explain_Business_Accounts_ATM_USD,
     TPMA_Location_Visit_Type
     
     
     )
) %>% relocate(Region, .before = Province) %>% 
  relocate(Planned_data_collection_period_TPMA, .after = week) %>% 
  relocate(Location_Type, .after = District) %>%  
  relocate(KEY, .after = last_col())  

bank_manager_sub <- bank_manager %>% select(
  Starttime,
  Endtime,
  year,
  month,
  week,
  Location_Type,
  Planned_data_collection_period_TPMA,
  Region,
  Type_of_center,
  KEY
)


banks_resp_que_merged <- bank_manager_sub %>% right_join(banks_resp_que, by = c("KEY" = "PARENT_KEY")) %>% 
  select(-c(Did_Not_Recive_Full_Amount_Audio)) %>% 
  rename(KEY = KEY.y, KEY_Main = KEY) %>% 
  relocate(KEY_Main, .after = last_col()) %>% 
  relocate(Planned_data_collection_period_TPMA, .after = week) %>% 
  relocate(Region, .before = Province) %>% 
  relocate(Location_Type, .after = District) %>% 
  relocate(Type_of_center, .after = Location_Type) 


bank_list <- list(
  BANK_BRANCH_LEVEL = bank_manager,
  BANK_RESPONDENT_LEVEL = banks_resp_que_merged
)

# 6 - Border Traffic Count
br_traf_count_main <- br_traf_count_main %>% mutate(
  enter_exist = case_when(
    enter_exist == "Enter each vehicle as it enters into the Afghan border from outside" ~ "Vehicles that are entering Afghanistan",
    enter_exist == "Enter each vehicle as it exits the Afghan border" ~ "Vehicles that are exiting Afghanistan",
    TRUE ~ enter_exist
  )
) %>% select(-c(SubmissionDate,
                Duration,
                Surveyor_Id,
                Surveyor_Gender,
                Sector_Name,
                Number_of_TPMA_visits_by_Sector,
                TPMA_Location_Visit_ID,
                Number_of_TPMA_Visits_by_Location_Type,
                Number_of_TPMA_Visits_by_Location,
                Type_Of_Visit,
                Sampling_Proposed_By,
                Type_Of_Sampling,
                `SET-OF-Traffic_count`,
                Type_of_center
                ))
  
br_traf_count_main_sub <- br_traf_count_main %>% 
  select(
    Starttime,
    Endtime,
    year,
    month,
    week,
    Planned_data_collection_period_TPMA,
    Region,
    KEY,
    TPMA_Location_Visit_Type,
    Region,
    enter_exist
  )

br_traf_count_count_merged <- br_traf_count_main_sub %>% right_join(br_traf_count_count, by = c( "KEY"= "PARENT_KEY")) %>%
  select(-c(`SET-OF-Traffic_count`, record_starttime,stop_starttime)) %>% 
  rename(KEY = KEY.y, KEY_Main = KEY) %>% 
  relocate(KEY_Main, .after = last_col()) %>% 
  relocate(Region, .before = Province)
  
Trafic_count_list <- list(
  BORDER_TRAFFIC_COUNT = br_traf_count_count_merged,
  BORDER_DETAILS = br_traf_count_main
   
)

# 7 - Border Driver Survey
br_driver_main <- br_driver_main %>% 
  select(-c(Sector_Name,
            Number_of_TPMA_visits_by_Sector,
            TPMA_Location_Visit_ID,
            Number_of_TPMA_Visits_by_Location_Type,
            Number_of_TPMA_Visits_by_Location,
            Type_Of_Visit,
            TPMA_Location_Visit_Type,
            Sampling_Proposed_By,
            Type_Of_Sampling
  )) %>% 
  rename(
    Cereals = food_transport_1,
    Packed_and_processed_foods = food_transport_2,
    Canned_goods = food_transport_3,
    Tubers = food_transport_4,
    Fruits_vegetables = food_transport_5,
    Dried_fruits = food_transport_6,
    Pulses = food_transport_7,
    Milk_dairy = food_transport_8,
    Fish_meat_eggs_poultry = food_transport_9,
    Sugar_salt = food_transport_10,
    Tea_coffee = food_transport_11,
    Oil_fat_butter = food_transport_12,
    Bottled_water = food_transport_13,
    Livestock = food_transport_14
    
  ) %>% mutate(
    if_food = case_when(
      if_food == 9999 ~ NA_real_,
      if_food == 8888 ~ NA_real_,
      if_food == 7777 ~ NA_real_,
      TRUE ~ if_food
    ),
    tax_per_unitamount = case_when(
      tax_per_unitamount == 9999 ~ NA_real_,
      tax_per_unitamount == 99999 ~ NA_real_,
      tax_per_unitamount == 8888 ~ NA_real_,
      tax_per_unitamount == 7777 ~ NA_real_,
      TRUE ~ tax_per_unitamount
    ),
    if_fuel = case_when(
      if_fuel == 9999 ~ NA_real_,
      if_fuel == 8888 ~ NA_real_,
      if_fuel == 7777 ~ NA_real_,
      TRUE ~ if_fuel
    ),
    tax_amount = case_when(
      tax_amount == 9999 ~ NA_real_,
      tax_amount == 8888 ~ NA_real_,
      tax_amount == 7777 ~ NA_real_,
      TRUE ~ tax_amount
    )
  )

# 8 - Telecom Servivice
telecom_data_sub <- telecom_data %>% 
  select(
    Starttime,
    Endtime,
    year,
    month,
    week,
    Planned_data_collection_period_TPMA,
    Site_Visit_ID,
    Site_Visit_Subcategory_ID,
    TPMA_Location_Name,
    TPMA_Location_ID,
    Location_Type,
    Type_of_center,
    Region,
    Province,
    District,
    Planned_data_collection_period_TPMA,
    Type_of_center,
    Provider,
    Gender_Of_Interviewee,
    Consent,
    Cost_Min_National_Call_within_Netwokrs,
    Cost_Min_National_Call_Other_Netwokrs,
    KEY
  )


# 9 - MMO
# mmo_main_clean <- mmo_main %>% select(
#   Starttime,
#   Endtime,
#   year,
#   month,
#   week,
#   Planned_data_collection_period_TPMA,
#   Site_Visit_ID,
#   Site_Visit_Subcategory_ID,
#   TPMA_Location_Name,
#   TPMA_Location_ID,
#   Location_Type,
#   Type_of_center,
#   Region,
#   Province,
#   District,
#   MMO_Name,
#   Respondent_gender,
#   consent,
#   International_Transfer_Made,
#   Max_Amount_Transferred_Domestically_One_Time,
#   Max_Amount_Withdrawn_Doestically,
#   Type_Domestic_Transfers_fee_Total_Amount,
#   Type_Domestic_Withdrawal_fee_Amount,
#   Number_Outgoing_Transfers,
#   Numberr_Incoming_Transfres,
#   KEY
# )
# 
# mmo_main_sub <- mmo_main_clean %>% 
#   select(
#     -c(
#       Respondent_gender,
#       consent,
#       International_Transfer_Made,
#       Max_Amount_Transferred_Domestically_One_Time,
#       Max_Amount_Withdrawn_Doestically,
#       Type_Domestic_Transfers_fee_Total_Amount,
#       Type_Domestic_Withdrawal_fee_Amount,
#       Number_Outgoing_Transfers,
#       Numberr_Incoming_Transfres,
#       MMO_Name,
#       Site_Visit_ID,
#       TPMA_Location_ID
#     )
#   )
# 
# 
# mmo_amnt_domestic_merged <- mmo_main_sub %>% right_join(mmo_amnt_domestic, by = c("KEY" = "PARENT_KEY"), keep = T) %>% 
#   select(-c(KEY.x, `SET-OF-Set_Fee_Total_Amount_Domestic_Transferred`)) %>% 
#   rename(KEY = KEY.y) %>% 
#   relocate(Site_Visit_ID, .before = Site_Visit_Subcategory_ID) %>% 
#   relocate(TPMA_Location_ID, .after = TPMA_Location_Name)
# 
# mmo_amount_witdraw_merged <- mmo_main_sub %>% right_join(mmo_amount_witdraw, by = c("KEY" = "PARENT_KEY"), keep = T) %>% 
#   select(-c(KEY.x, `SET-OF-Set_Fee_Total_Amount_Witdrawal_Transferred`)) %>% 
#   rename(KEY = KEY.y) %>% 
#   relocate(Site_Visit_ID, .before = Site_Visit_Subcategory_ID) %>% 
#   relocate(TPMA_Location_ID, .after = TPMA_Location_Name)
# 
# 
# MMO_LIST <- list(
#   MMO = mmo_main_clean,
#   DOMISTIC_TRANSFER_FEE = mmo_amnt_domestic_merged,
#   DOMISTIC_WITHDRAWAL_FEE = mmo_amount_witdraw_merged
# )

# Export datasets
openxlsx::write.xlsx(FI_LIST, "output/Client_Datasets/FI_DATA_Merged.xlsx")
openxlsx::write.xlsx(NFI_list, "output/Client_Datasets/NFI_AND_SERVICES_DATA_Merged.xlsx")
openxlsx::write.xlsx(hawala_list, "output/Client_Datasets/HAWALA_EXCHANGE_DATA_Merged.xlsx")
openxlsx::write.xlsx(hawala_list_v2, "output/Client_Datasets/HAWALA_EXCHANGE_DATA_Merged_v2.xlsx")
openxlsx::write.xlsx(bank_list, "output/Client_Datasets/BANK_DATA_Merged.xlsx")
openxlsx::write.xlsx(Trafic_count_list, "output/Client_Datasets/BORDER_TRAFFIC_COUNT_DATA_Merged.xlsx")
openxlsx::write.xlsx(br_driver_main, "output/Client_Datasets/BORDER_DRIVER_SURVEY_DATA_Merged.xlsx")
openxlsx::write.xlsx(telecom_data_sub, "output/Client_Datasets/TELECOM_DATA_Merged.xlsx")
# openxlsx::write.xlsx(MMO_LIST, "output/Client_Datasets/merged/MMO_DATA_Merged.xlsx")




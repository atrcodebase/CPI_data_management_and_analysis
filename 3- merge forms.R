##### merge forms ------------------------------------------------------------------------
source("1- read data.R")
output_path <- "output/merged data forms/"

# form 1: FI -----------------------------------------------------------------------------
merge_data(weekly, "fi", "CPI_Market_FI_Dataset")
fi_list <- list(
  main = fi_main,
  fi_subresps = fi_fi_subresps,
  subreps_ava_nava_tax_bartering = fi_subreps_ava_nava_tax_bartering,
  fi_items_prices_avail_notavail = fi_fi_items_prices_avail_notavail
)


# form 2: NFI ----------------------------------------------------------------------------
merge_data(weekly, "nfi", "CPI_Market_NFI_Dataset")
nfi_list <- list(
  main = nfi_main,
  nfi_subresps = nfi_nfi_subresps,
  nsubreps_ava_nava_tax_bartering = nfi_nsubreps_ava_nava_tax_bartering,
  nfi_items_prices_avail_notavail = nfi_nfi_items_prices_avail_notavail
)


## form 3: services ----------------------------------------------------------------------
merge_data(weekly, "market_services", "CPI_Market_Services_Dataset")
market_services_list <- list(
  main = market_services_main,
  subrespondents = market_services_subrespondents,
  subrespondents_avail_notavail = market_services_subrespondents_avail_notavail,
  subrespondents_available_data = market_services_subrespondents_available_data,
  Labour = market_services_Labour
)


## form 4: IME and Hawala (from week 1-10) -----------------------------------------------
merge_data(weekly, "ime_hawala", "CPI_Market_IME_Hawala_Dataset")
ime_hawala_list <- list(
  main = ime_hawala_main,
  ime_hawala_subresps = ime_hawala_ime_hawala_subresps,
  ime_hawala_avail_navail = ime_hawala_ime_hawala_avail_navail,
  exchange_rate_and_hawaladest = ime_hawala_exchange_rate_and_hawaladest,
  same_fee_for_selected_dest_same = ime_hawala_same_fee_for_selected_dest_same,
  transfer_fees_1st_dest = ime_hawala_transfer_fees_1st_dest,
  transfer_fees_2nd_dest = ime_hawala_transfer_fees_2nd_dest,
  transfer_fees_3rd_dest = ime_hawala_transfer_fees_3rd_dest
)

## IME version 2 (from week 11 onwards) --------------------------------------------------
merge_data(weekly, "ime_hawala_V2", "CPI_Market_IME_Hawala_Dataset", 
           reference_week="W11 datasets")
ime_hawala_list_v2 <- list(
  main = ime_hawala_V2_main,
  ime_hawala_subresps = ime_hawala_V2_ime_hawala_subresps,
  ime_hawala_Currency_Exchange = ime_hawala_V2_ime_hawala_Currency_Exchange,
  ime_hawala_Hawala_Transfer = ime_hawala_V2_ime_hawala_Hawala_Transfer
)

## form 5: Bank --------------------------------------------------------------------------
merge_data(weekly, "bank", "CPI_Bank_Dataset")
bank_list <- list(
  bank_manager = bank_bank_manager,
  queues_interview = bank_queues_interview
)

## Form 5.1: Bank Operationality Status, from week 8 onwards -----------------------------
merge_data(weekly, "bank_operationality", "CPI_Bank_Operationality_Status_Dataset", 
           reference_week = "W8 datasets")
bank_operationality_list <- list(
  bank_operationality_data = bank_operationality_bank_operationality_data,
  no_bank = bank_operationality_no_bank
)

## form 6: Border Traffic Count. It isn't available for week 1 ---------------------------
merge_data(weekly, "border_traffic_count", 
           "CPI_Border_Count_of_Transport_Traffic_Dataset", reference_week="W2 datasets")
border_traffic_count_list <- list(
  data = border_traffic_count_data,
  Traffic_count = border_traffic_count_Traffic_count
)

## form 7: Border Transport Driver Surveys. It is available only for week 1 and 2 --------
merge_data(weekly, "border_transport_driver", 
           "CPI_Border_Transport_Driver_Survey_Dataset")

## form 8: Telecom -----------------------------------------------------------------------
merge_data(weekly, "telecome_service", "CPI_Telecom_Service_Providers_Dataset")

# form 10: Government Employee_Salary_Payment_Verification -------------------------------
merge_data(weekly, "gov_emp_salary", "CPI_Government_Employee_Salary_Dataset", 
           reference_week = "W16 datasets",
           gov_emp_weeks <- c(16,22, 29, "m7"))

# Export ---------------------------------------------------------------------------------
writexl::write_xlsx(fi_list, glue::glue("{output_path}CPI_Market_FI_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(nfi_list,  glue::glue("{output_path}CPI_Market_NFI_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(market_services_list,  glue::glue("{output_path}CPI_Market_Services_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(ime_hawala_list,  glue::glue("{output_path}CPI_Market_IME_Hawala_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(ime_hawala_list_v2,  glue::glue("{output_path}CPI_Market_IME_Hawala_Dataset_v2_merge.xlsx"), format_headers = F)
writexl::write_xlsx(bank_list,  glue::glue("{output_path}CPI_Bank_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(bank_operationality_list, glue::glue("{output_path}CPI_Bank_Operationality_Status_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(border_traffic_count_list,  glue::glue("{output_path}CPI_Border_Count_of_Transport_Traffic_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(list(data = border_transport_driver_data), glue::glue("{output_path}CPI_Border_Transport_Driver_Survey_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(list(telecom_data = telecome_service_telecom_data), glue::glue("{output_path}CPI_Telecom_Service_Providers_Dataset_merge.xlsx"), format_headers = F)
writexl::write_xlsx(list(data = gov_emp_salary_data), glue::glue("{output_path}CPI_Government_Employee_Salary_Dataset_merge.xlsx"), format_headers = F)


# Remove extra objects -------------------------------------------------------------------
rm(list = ls()[ls() %notin% c("%notin%", "weekly")])


## Form 9 - MMOs (available only for week 1 and 8. Both are pilot data)
# mmo_main <- rbind(
#   mmo_w1[["main"]],
#   mmo_w8[["main"]]
# )

# mmo_sub_resp <- rbind(
#   mmo_w1[["mmo_sub_resp"]],
#   mmo_w8[["mmo_sub_resp"]]
# )

# mmo_percentage_fee_per_transfer <- rbind(
#   mmo_w1[["mmo_percentage_fee_per_transfer"]],
#   mmo_w8[["mmo_percentage_fee_per_transfer"]]
# )

# mmo_amount_fee_per_transfer <- rbind(
#   mmo_w1[["mmo_amount_fee_per_transfer"]],
#   mmo_w8[["mmo_amount_fee_per_transfer"]]
# )

# mmo_pecentage_fee_per_withdraw <- rbind(
#   mmo_w1[["mmo_pecentage_fee_per_withdraw"]],
#   mmo_w8[["mmo_pecentage_fee_per_withdraw"]]
# )

# mmo_amount_fee_per_withdraw <- rbind(
#   mmo_w1[["mmo_amount_fee_per_withdraw"]],
#   mmo_w8[["mmo_amount_fee_per_withdraw"]]
# )

# mmo_list <- list(
#   main = mmo_main,
#   mmo_sub_resp = mmo_sub_resp,
#   mmo_percentage_fee_per_transfer = mmo_percentage_fee_per_transfer,
#   mmo_amount_fee_per_transfer = mmo_amount_fee_per_transfer,
#   mmo_pecentage_fee_per_withdraw = mmo_pecentage_fee_per_withdraw,
#   mmo_amount_fee_per_withdraw = mmo_amount_fee_per_withdraw
# )

# identical(names(mmo_w8), names(mmo_list))
# writexl::write_xlsx(mmo_list, glue::glue("{output_path}CPI_MMOs_Dataset_merge.xlsx"))

## form 11: Railway Count. Available only in week 10




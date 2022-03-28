##### merge forms (should be updated on weekly basis) --------------------------------------------------
source("1- read data.R")
output_path <- "output/merged data forms/"

# form 1: FI
fi_main <- rbind(
  fi_w1[["main"]],
  fi_w2[["main"]],
  fi_w3[["main"]],
  fi_w4[["main"]],
  fi_w5[["main"]],
  fi_w6[["main"]],
  fi_w7[["main"]],
  fi_w8[["main"]],
  fi_w9[["main"]],
  fi_w10[["main"]],
  fi_w11[["main"]],
  fi_w12[["main"]],
  fi_w13[["main"]],
  fi_w14[["main"]],
  fi_w15[["main"]],
  fi_w16[["main"]],
  fi_w17[["main"]],
  fi_w18[["main"]],
  fi_w19[["main"]]
)

fi_subresps <- rbind(
  fi_w1[["fi_subresps"]],
  fi_w2[["fi_subresps"]],
  fi_w3[["fi_subresps"]],
  fi_w4[["fi_subresps"]],
  fi_w5[["fi_subresps"]],
  fi_w6[["fi_subresps"]],
  fi_w7[["fi_subresps"]],
  fi_w8[["fi_subresps"]],
  fi_w9[["fi_subresps"]],
  fi_w10[["fi_subresps"]],
  fi_w11[["fi_subresps"]],
  fi_w12[["fi_subresps"]],
  fi_w13[["fi_subresps"]],
  fi_w14[["fi_subresps"]],
  fi_w15[["fi_subresps"]],
  fi_w16[["fi_subresps"]],
  fi_w17[["fi_subresps"]],
  fi_w18[["fi_subresps"]],
  fi_w19[["fi_subresps"]]
)

fi_subreps_ava_nava_tax_bartering <- rbind(
  fi_w1[["subreps_ava_nava_tax_bartering"]],
  fi_w2[["subreps_ava_nava_tax_bartering"]],
  fi_w3[["subreps_ava_nava_tax_bartering"]],
  fi_w4[["subreps_ava_nava_tax_bartering"]],
  fi_w5[["subreps_ava_nava_tax_bartering"]],
  fi_w6[["subreps_ava_nava_tax_bartering"]],
  fi_w7[["subreps_ava_nava_tax_bartering"]],
  fi_w8[["subreps_ava_nava_tax_bartering"]],
  fi_w9[["subreps_ava_nava_tax_bartering"]],
  fi_w10[["subreps_ava_nava_tax_bartering"]],
  fi_w11[["subreps_ava_nava_tax_bartering"]],
  fi_w12[["subreps_ava_nava_tax_bartering"]],
  fi_w13[["subreps_ava_nava_tax_bartering"]],
  fi_w14[["subreps_ava_nava_tax_bartering"]],
  fi_w15[["subreps_ava_nava_tax_bartering"]],
  fi_w16[["subreps_ava_nava_tax_bartering"]],
  fi_w17[["subreps_ava_nava_tax_bartering"]],
  fi_w18[["subreps_ava_nava_tax_bartering"]],
  fi_w19[["subreps_ava_nava_tax_bartering"]]
)

fi_items_prices_avail_notavail <- rbind(
  fi_w1[["fi_items_prices_avail_notavail"]],
  fi_w2[["fi_items_prices_avail_notavail"]],
  fi_w3[["fi_items_prices_avail_notavail"]],
  fi_w4[["fi_items_prices_avail_notavail"]],
  fi_w5[["fi_items_prices_avail_notavail"]],
  fi_w6[["fi_items_prices_avail_notavail"]],
  fi_w7[["fi_items_prices_avail_notavail"]],
  fi_w8[["fi_items_prices_avail_notavail"]],
  fi_w9[["fi_items_prices_avail_notavail"]],
  fi_w10[["fi_items_prices_avail_notavail"]],
  fi_w11[["fi_items_prices_avail_notavail"]],
  fi_w12[["fi_items_prices_avail_notavail"]],
  fi_w13[["fi_items_prices_avail_notavail"]],
  fi_w14[["fi_items_prices_avail_notavail"]],
  fi_w15[["fi_items_prices_avail_notavail"]],
  fi_w16[["fi_items_prices_avail_notavail"]],
  fi_w17[["fi_items_prices_avail_notavail"]],
  fi_w18[["fi_items_prices_avail_notavail"]],
  fi_w19[["fi_items_prices_avail_notavail"]]
)

fi_list <- list(
  main = fi_main,
  fi_subresps = fi_subresps,
  subreps_ava_nava_tax_bartering = fi_subreps_ava_nava_tax_bartering,
  fi_items_prices_avail_notavail = fi_items_prices_avail_notavail
)

identical(names(fi_w1), names(fi_list))
writexl::write_xlsx(fi_list, glue::glue("{output_path}CPI_Market_FI_Dataset_merge.xlsx"), format_headers = F)

# form 2: NFI
nfi_main <- rbind(
  nfi_w1[["main"]],
  nfi_w2[["main"]],
  nfi_w3[["main"]],
  nfi_w4[["main"]],
  nfi_w5[["main"]],
  nfi_w6[["main"]],
  nfi_w7[["main"]],
  nfi_w8[["main"]],
  nfi_w9[["main"]],
  nfi_w10[["main"]],
  nfi_w11[["main"]],
  nfi_w12[["main"]],
  nfi_w13[["main"]],
  nfi_w14[["main"]],
  nfi_w15[["main"]],
  nfi_w16[["main"]],
  nfi_w17[["main"]],
  nfi_w18[["main"]],
  nfi_w19[["main"]]
)

nfi_subresps <- rbind(
  nfi_w1[["nfi_subresps"]],
  nfi_w2[["nfi_subresps"]],
  nfi_w3[["nfi_subresps"]],
  nfi_w4[["nfi_subresps"]],
  nfi_w5[["nfi_subresps"]],
  nfi_w6[["nfi_subresps"]],
  nfi_w7[["nfi_subresps"]],
  nfi_w8[["nfi_subresps"]],
  nfi_w9[["nfi_subresps"]],
  nfi_w10[["nfi_subresps"]],
  nfi_w11[["nfi_subresps"]],
  nfi_w12[["nfi_subresps"]],
  nfi_w13[["nfi_subresps"]],
  nfi_w14[["nfi_subresps"]],
  nfi_w15[["nfi_subresps"]],
  nfi_w16[["nfi_subresps"]],
  nfi_w17[["nfi_subresps"]],
  nfi_w18[["nfi_subresps"]],
  nfi_w19[["nfi_subresps"]]
)

nfi_nsubreps_ava_nava_tax_bartering <- rbind(
  nfi_w1[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w2[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w3[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w4[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w5[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w6[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w7[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w8[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w9[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w10[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w11[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w12[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w13[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w14[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w15[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w16[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w17[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w18[["nsubreps_ava_nava_tax_bartering"]],
  nfi_w19[["nsubreps_ava_nava_tax_bartering"]]
)

nfi_items_prices_avail_notavail <- rbind(
  nfi_w1[["nfi_items_prices_avail_notavail"]],
  nfi_w2[["nfi_items_prices_avail_notavail"]],
  nfi_w3[["nfi_items_prices_avail_notavail"]],
  nfi_w4[["nfi_items_prices_avail_notavail"]],
  nfi_w5[["nfi_items_prices_avail_notavail"]],
  nfi_w6[["nfi_items_prices_avail_notavail"]],
  nfi_w7[["nfi_items_prices_avail_notavail"]],
  nfi_w8[["nfi_items_prices_avail_notavail"]],
  nfi_w9[["nfi_items_prices_avail_notavail"]],
  nfi_w10[["nfi_items_prices_avail_notavail"]],
  nfi_w11[["nfi_items_prices_avail_notavail"]],
  nfi_w12[["nfi_items_prices_avail_notavail"]],
  nfi_w13[["nfi_items_prices_avail_notavail"]],
  nfi_w14[["nfi_items_prices_avail_notavail"]],
  nfi_w15[["nfi_items_prices_avail_notavail"]],
  nfi_w16[["nfi_items_prices_avail_notavail"]],
  nfi_w17[["nfi_items_prices_avail_notavail"]],
  nfi_w18[["nfi_items_prices_avail_notavail"]],
  nfi_w19[["nfi_items_prices_avail_notavail"]]
)

nfi_list <- list(
  main = nfi_main,
  nfi_subresps = nfi_subresps,
  nsubreps_ava_nava_tax_bartering = nfi_nsubreps_ava_nava_tax_bartering,
  nfi_items_prices_avail_notavail = nfi_items_prices_avail_notavail
)

identical(names(nfi_w1), names(nfi_list))
writexl::write_xlsx(nfi_list,  glue::glue("{output_path}CPI_Market_NFI_Dataset_merge.xlsx"), format_headers = F)

## form 3: services
market_services_main <- rbind(
  market_services_w1[["main"]],
  market_services_w2[["main"]],
  market_services_w3[["main"]],
  market_services_w4[["main"]],
  market_services_w5[["main"]],
  market_services_w6[["main"]],
  market_services_w7[["main"]],
  market_services_w8[["main"]],
  market_services_w9[["main"]],
  market_services_w10[["main"]],
  market_services_w11[["main"]],
  market_services_w12[["main"]],
  market_services_w13[["main"]],
  market_services_w14[["main"]],
  market_services_w15[["main"]],
  market_services_w16[["main"]],
  market_services_w17[["main"]],
  market_services_w18[["main"]],
  market_services_w19[["main"]]
  )

market_services_subrespondents <- rbind(
  market_services_w1[["subrespondents"]],
  market_services_w2[["subrespondents"]],
  market_services_w3[["subrespondents"]],
  market_services_w4[["subrespondents"]],
  market_services_w5[["subrespondents"]],
  market_services_w6[["subrespondents"]],
  market_services_w7[["subrespondents"]],
  market_services_w8[["subrespondents"]],
  market_services_w9[["subrespondents"]],
  market_services_w10[["subrespondents"]],
  market_services_w11[["subrespondents"]],
  market_services_w12[["subrespondents"]],
  market_services_w13[["subrespondents"]],
  market_services_w14[["subrespondents"]],
  market_services_w15[["subrespondents"]],
  market_services_w16[["subrespondents"]],
  market_services_w17[["subrespondents"]],
  market_services_w18[["subrespondents"]],
  market_services_w19[["subrespondents"]]
)

market_services_subrespondents_avail_notavail <- rbind(
  market_services_w1[["subrespondents_avail_notavail"]],
  market_services_w2[["subrespondents_avail_notavail"]],
  market_services_w3[["subrespondents_avail_notavail"]],
  market_services_w4[["subrespondents_avail_notavail"]],
  market_services_w5[["subrespondents_avail_notavail"]],
  market_services_w6[["subrespondents_avail_notavail"]],
  market_services_w7[["subrespondents_avail_notavail"]],
  market_services_w8[["subrespondents_avail_notavail"]],
  market_services_w9[["subrespondents_avail_notavail"]],
  market_services_w10[["subrespondents_avail_notavail"]],
  market_services_w11[["subrespondents_avail_notavail"]],
  market_services_w12[["subrespondents_avail_notavail"]],
  market_services_w13[["subrespondents_avail_notavail"]],
  market_services_w14[["subrespondents_avail_notavail"]],
  market_services_w15[["subrespondents_avail_notavail"]],
  market_services_w16[["subrespondents_avail_notavail"]],
  market_services_w17[["subrespondents_avail_notavail"]],
  market_services_w18[["subrespondents_avail_notavail"]],
  market_services_w19[["subrespondents_avail_notavail"]]
)

market_services_subrespondents_available_data <- rbind(
  market_services_w1[["subrespondents_available_data"]],
  market_services_w2[["subrespondents_available_data"]],
  market_services_w3[["subrespondents_available_data"]],
  market_services_w4[["subrespondents_available_data"]],
  market_services_w5[["subrespondents_available_data"]],
  market_services_w6[["subrespondents_available_data"]],
  market_services_w7[["subrespondents_available_data"]],
  market_services_w8[["subrespondents_available_data"]],
  market_services_w9[["subrespondents_available_data"]],
  market_services_w10[["subrespondents_available_data"]],
  market_services_w11[["subrespondents_available_data"]],
  market_services_w12[["subrespondents_available_data"]],
  market_services_w13[["subrespondents_available_data"]],
  market_services_w14[["subrespondents_available_data"]],
  market_services_w15[["subrespondents_available_data"]],
  market_services_w16[["subrespondents_available_data"]],
  market_services_w17[["subrespondents_available_data"]],
  market_services_w18[["subrespondents_available_data"]],
  market_services_w19[["subrespondents_available_data"]]
)

market_services_Labour <- rbind(
  market_services_w1[["Labour"]],
  market_services_w2[["Labour"]],
  market_services_w3[["Labour"]],
  market_services_w4[["Labour"]],
  market_services_w5[["Labour"]],
  market_services_w6[["Labour"]],
  market_services_w7[["Labour"]],
  market_services_w8[["Labour"]],
  market_services_w9[["Labour"]],
  market_services_w10[["Labour"]],
  market_services_w11[["Labour"]],
  market_services_w12[["Labour"]],
  market_services_w13[["Labour"]],
  market_services_w14[["Labour"]],
  market_services_w15[["Labour"]],
  market_services_w16[["Labour"]],
  market_services_w17[["Labour"]],
  market_services_w18[["Labour"]],
  market_services_w19[["Labour"]]
)

market_services_list <- list(
  main = market_services_main,
  subrespondents = market_services_subrespondents,
  subrespondents_avail_notavail = market_services_subrespondents_avail_notavail,
  subrespondents_available_data = market_services_subrespondents_available_data,
  Labour = market_services_Labour
)

identical(names(market_services_w1), names(market_services_list))
writexl::write_xlsx(market_services_list,  glue::glue("{output_path}CPI_Market_Services_Dataset_merge.xlsx"), format_headers = F)

## Form 4: IME and Hawala. (from week 1-10)
ime_hawala_main <- rbind(
  ime_hawala_w1[["main"]],
  ime_hawala_w2[["main"]],
  ime_hawala_w3[["main"]],
  ime_hawala_w4[["main"]],
  ime_hawala_w5[["main"]],
  ime_hawala_w6[["main"]],
  ime_hawala_w7[["main"]],
  ime_hawala_w8[["main"]],
  ime_hawala_w9[["main"]],
  ime_hawala_w10[["main"]]
)

ime_hawala_subresps <- rbind(
  ime_hawala_w1[["ime_hawala_subresps"]],
  ime_hawala_w2[["ime_hawala_subresps"]],
  ime_hawala_w3[["ime_hawala_subresps"]],
  ime_hawala_w4[["ime_hawala_subresps"]],
  ime_hawala_w5[["ime_hawala_subresps"]],
  ime_hawala_w6[["ime_hawala_subresps"]],
  ime_hawala_w7[["ime_hawala_subresps"]],
  ime_hawala_w8[["ime_hawala_subresps"]],
  ime_hawala_w9[["ime_hawala_subresps"]],
  ime_hawala_w10[["ime_hawala_subresps"]]
)

ime_hawala_avail_navail <- rbind(
  ime_hawala_w1[["ime_hawala_avail_navail"]],
  ime_hawala_w2[["ime_hawala_avail_navail"]],
  ime_hawala_w3[["ime_hawala_avail_navail"]],
  ime_hawala_w4[["ime_hawala_avail_navail"]],
  ime_hawala_w5[["ime_hawala_avail_navail"]],
  ime_hawala_w6[["ime_hawala_avail_navail"]],
  ime_hawala_w7[["ime_hawala_avail_navail"]],
  ime_hawala_w8[["ime_hawala_avail_navail"]],
  ime_hawala_w9[["ime_hawala_avail_navail"]],
  ime_hawala_w10[["ime_hawala_avail_navail"]]
)

ime_hawala_exchange_rate_and_hawaladest <- rbind(
  ime_hawala_w1[["exchange_rate_and_hawaladest"]],
  ime_hawala_w2[["exchange_rate_and_hawaladest"]],
  ime_hawala_w3[["exchange_rate_and_hawaladest"]],
  ime_hawala_w4[["exchange_rate_and_hawaladest"]],
  ime_hawala_w5[["exchange_rate_and_hawaladest"]],
  ime_hawala_w6[["exchange_rate_and_hawaladest"]],
  ime_hawala_w7[["exchange_rate_and_hawaladest"]],
  ime_hawala_w8[["exchange_rate_and_hawaladest"]],
  ime_hawala_w9[["exchange_rate_and_hawaladest"]],
  ime_hawala_w10[["exchange_rate_and_hawaladest"]]
)

ime_hawala_same_fee_for_selected_dest_same <- rbind(
  ime_hawala_w1[["same_fee_for_selected_dest_same"]],
  ime_hawala_w2[["same_fee_for_selected_dest_same"]],
  ime_hawala_w3[["same_fee_for_selected_dest_same"]],
  ime_hawala_w4[["same_fee_for_selected_dest_same"]],
  ime_hawala_w5[["same_fee_for_selected_dest_same"]],
  ime_hawala_w6[["same_fee_for_selected_dest_same"]],
  ime_hawala_w7[["same_fee_for_selected_dest_same"]],
  ime_hawala_w8[["same_fee_for_selected_dest_same"]],
  ime_hawala_w9[["same_fee_for_selected_dest_same"]],
  ime_hawala_w10[["same_fee_for_selected_dest_same"]]
)

ime_hawala_transfer_fees_1st_dest <- rbind(
  ime_hawala_w1[["transfer_fees_1st_dest"]],
  ime_hawala_w2[["transfer_fees_1st_dest"]],
  ime_hawala_w3[["transfer_fees_1st_dest"]],
  ime_hawala_w4[["transfer_fees_1st_dest"]],
  ime_hawala_w5[["transfer_fees_1st_dest"]],
  ime_hawala_w6[["transfer_fees_1st_dest"]],
  ime_hawala_w7[["transfer_fees_1st_dest"]],
  ime_hawala_w8[["transfer_fees_1st_dest"]],
  ime_hawala_w9[["transfer_fees_1st_dest"]],
  ime_hawala_w10[["transfer_fees_1st_dest"]]
)

ime_hawala_transfer_fees_2nd_dest <- rbind(
  ime_hawala_w1[["transfer_fees_2nd_dest"]],
  ime_hawala_w2[["transfer_fees_2nd_dest"]],
  ime_hawala_w3[["transfer_fees_2nd_dest"]],
  ime_hawala_w4[["transfer_fees_2nd_dest"]],
  ime_hawala_w5[["transfer_fees_2nd_dest"]],
  ime_hawala_w6[["transfer_fees_2nd_dest"]],
  ime_hawala_w7[["transfer_fees_2nd_dest"]],
  ime_hawala_w8[["transfer_fees_2nd_dest"]],
  ime_hawala_w9[["transfer_fees_2nd_dest"]],
  ime_hawala_w10[["transfer_fees_2nd_dest"]]
)

ime_hawala_transfer_fees_3rd_dest <- rbind(
  ime_hawala_w1[["transfer_fees_3rd_dest"]],
  ime_hawala_w2[["transfer_fees_3rd_dest"]],
  ime_hawala_w3[["transfer_fees_3rd_dest"]],
  ime_hawala_w4[["transfer_fees_3rd_dest"]],
  ime_hawala_w5[["transfer_fees_3rd_dest"]],
  ime_hawala_w6[["transfer_fees_3rd_dest"]],
  ime_hawala_w7[["transfer_fees_3rd_dest"]],
  ime_hawala_w8[["transfer_fees_3rd_dest"]],
  ime_hawala_w9[["transfer_fees_3rd_dest"]],
  ime_hawala_w10[["transfer_fees_3rd_dest"]]
)

ime_hawala_list <- list(
  main = ime_hawala_main,
  ime_hawala_subresps = ime_hawala_subresps,
  ime_hawala_avail_navail = ime_hawala_avail_navail,
  exchange_rate_and_hawaladest = ime_hawala_exchange_rate_and_hawaladest,
  same_fee_for_selected_dest_same = ime_hawala_same_fee_for_selected_dest_same,
  transfer_fees_1st_dest = ime_hawala_transfer_fees_1st_dest,
  transfer_fees_2nd_dest = ime_hawala_transfer_fees_2nd_dest,
  transfer_fees_3rd_dest = ime_hawala_transfer_fees_3rd_dest
)

identical(names(ime_hawala_w1), names(ime_hawala_list))
writexl::write_xlsx(ime_hawala_list,  glue::glue("{output_path}CPI_Market_IME_Hawala_Dataset_merge.xlsx"), format_headers = F)

## IME version 2 (from week 11 onwards).
ime_hawala_main_v2 <- rbind(
  ime_hawala_w11[["main"]],
  ime_hawala_w12[["main"]],
  ime_hawala_w13[["main"]],
  ime_hawala_w14[["main"]],
  ime_hawala_w15[["main"]],
  ime_hawala_w16[["main"]],
  ime_hawala_w17[["main"]],
  ime_hawala_w18[["main"]],
  ime_hawala_w19[["main"]]
)

ime_hawala_subresps_v2 <- rbind(
  ime_hawala_w11[["ime_hawala_subresps"]],
  ime_hawala_w12[["ime_hawala_subresps"]],
  ime_hawala_w13[["ime_hawala_subresps"]],
  ime_hawala_w14[["ime_hawala_subresps"]],
  ime_hawala_w15[["ime_hawala_subresps"]],
  ime_hawala_w16[["ime_hawala_subresps"]],
  ime_hawala_w17[["ime_hawala_subresps"]],
  ime_hawala_w18[["ime_hawala_subresps"]],
  ime_hawala_w19[["ime_hawala_subresps"]]
)

ime_hawala_Currency_Exchange_v2 <- rbind(
  ime_hawala_w11[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w12[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w13[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w14[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w15[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w16[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w17[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w18[["ime_hawala_Currency_Exchange"]],
  ime_hawala_w19[["ime_hawala_Currency_Exchange"]]
)

ime_hawala_Hawala_Transfer_v2 <- rbind(
  ime_hawala_w11[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w12[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w13[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w14[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w15[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w16[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w17[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w18[["ime_hawala_Hawala_Transfer"]],
  ime_hawala_w19[["ime_hawala_Hawala_Transfer"]]
)

ime_hawala_list_v2 <- list(
  main = ime_hawala_main_v2,
  ime_hawala_subresps = ime_hawala_subresps_v2,
  ime_hawala_Currency_Exchange = ime_hawala_Currency_Exchange_v2,
  ime_hawala_Hawala_Transfer = ime_hawala_Hawala_Transfer_v2
)

identical(names(ime_hawala_w11), names(ime_hawala_list_v2))
writexl::write_xlsx(ime_hawala_list_v2,  glue::glue("{output_path}CPI_Market_IME_Hawala_Dataset_v2_merge.xlsx"), format_headers = F)

## Form 5: Bank
bank_manager <- rbind(
  bank_w1[["bank_manager"]],
  bank_w2[["bank_manager"]],
  bank_w3[["bank_manager"]],
  bank_w4[["bank_manager"]],
  bank_w5[["bank_manager"]],
  bank_w6[["bank_manager"]],
  bank_w7[["bank_manager"]],
  bank_w8[["bank_manager"]],
  bank_w9[["bank_manager"]],
  bank_w10[["bank_manager"]],
  bank_w11[["bank_manager"]],
  bank_w12[["bank_manager"]],
  bank_w13[["bank_manager"]],
  bank_w14[["bank_manager"]],
  bank_w15[["bank_manager"]],
  bank_w16[["bank_manager"]],
  bank_w17[["bank_manager"]],
  bank_w18[["bank_manager"]],
  bank_w19[["bank_manager"]]
)

bank_queues_interview <- rbind(
  bank_w1[["queues_interview"]],
  bank_w2[["queues_interview"]],
  bank_w3[["queues_interview"]],
  bank_w4[["queues_interview"]],
  bank_w5[["queues_interview"]],
  bank_w6[["queues_interview"]],
  bank_w7[["queues_interview"]],
  bank_w8[["queues_interview"]],
  bank_w9[["queues_interview"]],
  bank_w10[["queues_interview"]],
  bank_w11[["queues_interview"]],
  bank_w12[["queues_interview"]],
  bank_w13[["queues_interview"]],
  bank_w14[["queues_interview"]],
  bank_w15[["queues_interview"]],
  bank_w16[["queues_interview"]],
  bank_w17[["queues_interview"]],
  bank_w18[["queues_interview"]],
  bank_w19[["queues_interview"]]
)

bank_list <- list(
  bank_manager = bank_manager,
  queues_interview = bank_queues_interview
)

identical(names(bank_w1), names(bank_list))
writexl::write_xlsx(bank_list,  glue::glue("{output_path}CPI_Bank_Dataset_merge.xlsx"), format_headers = F)

## Form 5.1 Bank Operationality data. It is available from week 8 onwards.
bank_operationality_data <- rbind(
  bank_operationality_w8[["bank_operationality_data"]],
  bank_operationality_w9[["bank_operationality_data"]],
  bank_operationality_w10[["bank_operationality_data"]],
  bank_operationality_w11[["bank_operationality_data"]],
  bank_operationality_w12[["bank_operationality_data"]],
  bank_operationality_w13[["bank_operationality_data"]],
  bank_operationality_w14[["bank_operationality_data"]],
  bank_operationality_w15[["bank_operationality_data"]],
  bank_operationality_w16[["bank_operationality_data"]],
  bank_operationality_w17[["bank_operationality_data"]],
  bank_operationality_w18[["bank_operationality_data"]],
  bank_operationality_w19[["bank_operationality_data"]]
)

no_bank <- rbind(
  bank_operationality_w8[["no_bank"]],
  bank_operationality_w9[["no_bank"]],
  bank_operationality_w10[["no_bank"]],
  bank_operationality_w11[["no_bank"]],
  bank_operationality_w12[["no_bank"]],
  bank_operationality_w13[["no_bank"]],
  bank_operationality_w14[["no_bank"]],
  bank_operationality_w15[["no_bank"]],
  bank_operationality_w16[["no_bank"]],
  bank_operationality_w17[["no_bank"]],
  bank_operationality_w18[["no_bank"]],
  bank_operationality_w19[["no_bank"]]
)

bank_operationality_list <- list(
  bank_operationality_data = bank_operationality_data,
  no_bank = no_bank
)

identical( names(bank_operationality_w8), names(bank_operationality_list))
writexl::write_xlsx(bank_operationality_list, glue::glue("{output_path}CPI_Bank_Operationality_Status_Dataset_merge.xlsx"), format_headers = F)

## Form 6: Border Traffic Count. Not available for week 1.
border_traffic_count_data <- rbind(
  border_traffic_count_w2[["data"]],
  border_traffic_count_w3[["data"]],
  border_traffic_count_w4[["data"]],
  border_traffic_count_w5[["data"]],
  border_traffic_count_w6[["data"]],
  border_traffic_count_w7[["data"]],
  border_traffic_count_w8[["data"]],
  border_traffic_count_w9[["data"]],
  border_traffic_count_w10[["data"]],
  border_traffic_count_w11[["data"]],
  border_traffic_count_w12[["data"]],
  border_traffic_count_w13[["data"]],
  border_traffic_count_w14[["data"]],
  border_traffic_count_w15[["data"]],
  border_traffic_count_w16[["data"]],
  border_traffic_count_w17[["data"]],
  border_traffic_count_w18[["data"]],
  border_traffic_count_w19[["data"]]
)

border_traffic_count_Traffic_count <- rbind(
  border_traffic_count_w2[["Traffic_count"]],
  border_traffic_count_w3[["Traffic_count"]],
  border_traffic_count_w4[["Traffic_count"]],
  border_traffic_count_w5[["Traffic_count"]],
  border_traffic_count_w6[["Traffic_count"]],
  border_traffic_count_w7[["Traffic_count"]],
  border_traffic_count_w8[["Traffic_count"]],
  border_traffic_count_w9[["Traffic_count"]],
  border_traffic_count_w10[["Traffic_count"]],
  border_traffic_count_w11[["Traffic_count"]],
  border_traffic_count_w12[["Traffic_count"]],
  border_traffic_count_w13[["Traffic_count"]],
  border_traffic_count_w14[["Traffic_count"]],
  border_traffic_count_w15[["Traffic_count"]],
  border_traffic_count_w16[["Traffic_count"]],
  border_traffic_count_w17[["Traffic_count"]],
  border_traffic_count_w18[["Traffic_count"]],
  border_traffic_count_w19[["Traffic_count"]]
)

border_traffic_count_list <- list(
  data = border_traffic_count_data,
  Traffic_count = border_traffic_count_Traffic_count
)

identical(names(border_traffic_count_w2), names(border_traffic_count_list))
writexl::write_xlsx(border_traffic_count_list,  glue::glue("{output_path}CPI_Border_Count_of_Transport_Traffic_Dataset_merge.xlsx"), format_headers = F)

## Form 7: Border Transport Driver Surveys. Available only for week 1 and 2
border_transport_driver <- rbind(
  border_transport_driver_w1[["data"]],
  border_transport_driver_w2[["data"]]
)

writexl::write_xlsx(list(data = border_transport_driver), glue::glue("{output_path}CPI_Border_Transport_Driver_Survey_Dataset_merge.xlsx"), format_headers = F)

## Form 8 - Telecom
telecome_service <- rbind(
  telecome_service_w1[["telecom_data"]],
  telecome_service_w2[["telecom_data"]],
  telecome_service_w3[["telecom_data"]],
  telecome_service_w4[["telecom_data"]],
  telecome_service_w5[["telecom_data"]],
  telecome_service_w6[["telecom_data"]],
  telecome_service_w7[["telecom_data"]],
  telecome_service_w8[["telecom_data"]],
  telecome_service_w9[["telecom_data"]],
  telecome_service_w10[["telecom_data"]],
  telecome_service_w11[["telecom_data"]],
  telecome_service_w12[["telecom_data"]],
  telecome_service_w13[["telecom_data"]],
  telecome_service_w14[["telecom_data"]],
  telecome_service_w15[["telecom_data"]],
  telecome_service_w16[["telecom_data"]],
  telecome_service_w17[["telecom_data"]],
  telecome_service_w18[["telecom_data"]],
  telecome_service_w19[["telecom_data"]]
)

writexl::write_xlsx(list(telecom_data = telecome_service), glue::glue("{output_path}CPI_Telecom_Service_Providers_Dataset_merge.xlsx"), format_headers = F)

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

## form 10: Government Employee_Salary_Payment_Verification. Available only for week 8 and 16. week 8 is pilot data.
#### please copy week 16 data from "input/raw_data_fixed column names/W16 datasets_Economic Monitoring/" and put it in the "output/merged data forms/"

## form 11: Railway Count. Available only in week 10




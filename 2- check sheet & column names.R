##### check sheet/column names in each forms for all weeks -------------------------------------------------
source("1- read data.R")

# form 1: FI
all(sapply(list(
  names(fi_w2), names(fi_w3), names(fi_w4), names(fi_w5), names(fi_w6), names(fi_w7),
  names(fi_w8), names(fi_w9), names(fi_w10), names(fi_w11), names(fi_w12), names(fi_w13), names(fi_w14), names(fi_w15),
  names(fi_w16), names(fi_w17)
), FUN = setequal, names(fi_w1)))

check_column_names(target = fi_w1, check_with = fi_w2)
check_column_names(target = fi_w1, check_with = fi_w3)
check_column_names(target = fi_w1, check_with = fi_w4)
check_column_names(target = fi_w1, check_with = fi_w5)
check_column_names(target = fi_w1, check_with = fi_w6)
check_column_names(target = fi_w1, check_with = fi_w7)
check_column_names(target = fi_w1, check_with = fi_w8)
check_column_names(target = fi_w1, check_with = fi_w9)
check_column_names(target = fi_w1, check_with = fi_w10)
check_column_names(target = fi_w1, check_with = fi_w11)
check_column_names(target = fi_w1, check_with = fi_w12)
check_column_names(target = fi_w1, check_with = fi_w13)
check_column_names(target = fi_w1, check_with = fi_w14)
check_column_names(target = fi_w1, check_with = fi_w15)
check_column_names(target = fi_w1, check_with = fi_w16)
check_column_names(target = fi_w1, check_with = fi_w17)

# form 2: NFI
all(sapply(list(
  names(nfi_w2), names(nfi_w3), names(nfi_w4), names(nfi_w5), names(nfi_w6), names(nfi_w7),
  names(nfi_w8), names(nfi_w9), names(nfi_w10), names(nfi_w11), names(nfi_w12), names(nfi_w13), names(nfi_w14), names(nfi_w15),
  names(nfi_w16), names(nfi_w17)
), FUN = identical, names(nfi_w1)))

check_column_names(target = nfi_w1, check_with = nfi_w2)
check_column_names(target = nfi_w1, check_with = nfi_w3)
check_column_names(target = nfi_w1, check_with = nfi_w4)
check_column_names(target = nfi_w1, check_with = nfi_w5)
check_column_names(target = nfi_w1, check_with = nfi_w6)
check_column_names(target = nfi_w1, check_with = nfi_w7)
check_column_names(target = nfi_w1, check_with = nfi_w8)
check_column_names(target = nfi_w1, check_with = nfi_w9)
check_column_names(target = nfi_w1, check_with = nfi_w10)
check_column_names(target = nfi_w1, check_with = nfi_w11)
check_column_names(target = nfi_w1, check_with = nfi_w12)
check_column_names(target = nfi_w1, check_with = nfi_w13)
check_column_names(target = nfi_w1, check_with = nfi_w14)
check_column_names(target = nfi_w1, check_with = nfi_w15)
check_column_names(target = nfi_w1, check_with = nfi_w16)
check_column_names(target = nfi_w1, check_with = nfi_w17)

## form 3: services
all(sapply(list(
  names(market_services_w2), names(market_services_w3), names(market_services_w4), names(market_services_w5), names(market_services_w6), names(market_services_w7),
  names(market_services_w8), names(market_services_w9), names(market_services_w10), names(market_services_w11), names(market_services_w12), names(market_services_w13), names(market_services_w14), names(market_services_w15),
  names(market_services_w16), names(market_services_w17)
), FUN = identical, names(market_services_w1)))

check_column_names(target = market_services_w1, check_with = market_services_w2)
check_column_names(target = market_services_w1, check_with = market_services_w3)
check_column_names(target = market_services_w1, check_with = market_services_w4)
check_column_names(target = market_services_w1, check_with = market_services_w5)
check_column_names(target = market_services_w1, check_with = market_services_w6)
check_column_names(target = market_services_w1, check_with = market_services_w7)
check_column_names(target = market_services_w1, check_with = market_services_w8)
check_column_names(target = market_services_w1, check_with = market_services_w9)
check_column_names(target = market_services_w1, check_with = market_services_w10)
check_column_names(target = market_services_w1, check_with = market_services_w11)
check_column_names(target = market_services_w1, check_with = market_services_w12)
check_column_names(target = market_services_w1, check_with = market_services_w13)
check_column_names(target = market_services_w1, check_with = market_services_w14)
check_column_names(target = market_services_w1, check_with = market_services_w15)
check_column_names(target = market_services_w1, check_with = market_services_w16)
check_column_names(target = market_services_w1, check_with = market_services_w17)

## form 4: IME and Hawala (from week 1-10)
all(sapply(list(
  names(ime_hawala_w2), names(ime_hawala_w3), names(ime_hawala_w4), names(ime_hawala_w5), names(ime_hawala_w6), names(ime_hawala_w7),
  names(ime_hawala_w8), names(ime_hawala_w9), names(ime_hawala_w10)
), FUN = identical, names(ime_hawala_w1)))

check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w2)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w3)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w4)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w5)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w6)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w7)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w8)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w9)
check_column_names(target = ime_hawala_w1, check_with = ime_hawala_w10)

## IME Hawala version 2 (from week 11 onwards)
all(sapply(list(
  names(ime_hawala_w12), names(ime_hawala_w13), names(ime_hawala_w14), names(ime_hawala_w15),
  names(ime_hawala_w16), names(ime_hawala_w17)
), FUN = identical, names(ime_hawala_w11)))

check_column_names(target = ime_hawala_w11, check_with = ime_hawala_w12)
check_column_names(target = ime_hawala_w11, check_with = ime_hawala_w13)
check_column_names(target = ime_hawala_w11, check_with = ime_hawala_w14)
check_column_names(target = ime_hawala_w11, check_with = ime_hawala_w15)
check_column_names(target = ime_hawala_w11, check_with = ime_hawala_w16)
check_column_names(target = ime_hawala_w11, check_with = ime_hawala_w17)

## form 5: Bank
all(sapply(list(
  names(bank_w2), names(bank_w3), names(bank_w4), names(bank_w5), names(bank_w6), names(bank_w7),
  names(bank_w8), names(bank_w9), names(bank_w10), names(bank_w11), names(bank_w12), names(bank_w13), names(bank_w14), names(bank_w15),
  names(bank_w16), names(bank_w17)
), FUN = identical, names(bank_w1)))

check_column_names(target = bank_w1, check_with = bank_w2)
check_column_names(target = bank_w1, check_with = bank_w3)
check_column_names(target = bank_w1, check_with = bank_w4)
check_column_names(target = bank_w1, check_with = bank_w5)
check_column_names(target = bank_w1, check_with = bank_w6)
check_column_names(target = bank_w1, check_with = bank_w7)
check_column_names(target = bank_w1, check_with = bank_w8)
check_column_names(target = bank_w1, check_with = bank_w9)
check_column_names(target = bank_w1, check_with = bank_w10)
check_column_names(target = bank_w1, check_with = bank_w11)
check_column_names(target = bank_w1, check_with = bank_w12)
check_column_names(target = bank_w1, check_with = bank_w13)
check_column_names(target = bank_w1, check_with = bank_w14)
check_column_names(target = bank_w1, check_with = bank_w15)
check_column_names(target = bank_w1, check_with = bank_w16)
check_column_names(target = bank_w1, check_with = bank_w17)

## form 6: Border Traffic Count. It isn't available for week 1
all(sapply(list(
  names(border_traffic_count_w2), names(border_traffic_count_w3), names(border_traffic_count_w4), names(border_traffic_count_w5), names(border_traffic_count_w6), names(border_traffic_count_w7),
  names(border_traffic_count_w8), names(border_traffic_count_w9), names(border_traffic_count_w10), names(border_traffic_count_w11), names(border_traffic_count_w12), names(border_traffic_count_w13), names(border_traffic_count_w14), names(border_traffic_count_w15),
  names(border_traffic_count_w16)
), FUN = identical, names(border_traffic_count_w2)))

check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w3)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w4)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w5)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w6)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w7)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w8)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w9)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w10)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w11)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w12)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w13)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w14)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w15)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w16)
check_column_names(target = border_traffic_count_w2, check_with = border_traffic_count_w17)

## form 7: Border Transport Driver Surveys. It is available only for week 1 and 2
all(sapply(list(
  names(border_transport_driver_w1)
), FUN = setequal, names(border_transport_driver_w2)))

check_column_names(target = border_transport_driver_w1, check_with = border_transport_driver_w2)

## form 8: Telecom
all(sapply(list(
  names(telecome_service_w2), names(telecome_service_w3), names(telecome_service_w4), names(telecome_service_w5), names(telecome_service_w6), names(telecome_service_w7),
  names(telecome_service_w8), names(telecome_service_w9), names(telecome_service_w10), names(telecome_service_w11), names(telecome_service_w12), names(telecome_service_w13), names(telecome_service_w14), names(telecome_service_w15),
  names(telecome_service_w16), names(telecome_service_w17)
), FUN = identical, names(telecome_service_w1)))

check_column_names(target = telecome_service_w1, check_with = telecome_service_w2)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w3)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w4)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w5)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w6)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w7)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w8)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w9)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w10)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w11)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w12)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w13)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w14)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w15)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w16)
check_column_names(target = telecome_service_w1, check_with = telecome_service_w17)

## form 9: MMOs (available only for week 1 and 8. Both are pilot data)
# all(sapply(list(names(mmo_w8)
# ), FUN = identical, names(mmo_w1)))
# 
# check_column_names(target = mmo_w1, check_with = mmo_w8)

## Form 5.1: Bank Operationality Status, from week 8 onwards
all(sapply(list(
  names(bank_operationality_w9), names(bank_operationality_w10), names(bank_operationality_w11), names(bank_operationality_w12), names(bank_operationality_w13), names(bank_operationality_w14), names(bank_operationality_w15),
  names(bank_operationality_w16), names(bank_operationality_w17)
), FUN = identical, names(bank_operationality_w8)))

check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w9)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w10)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w11)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w12)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w13)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w14)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w15)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w16)
check_column_names(target = bank_operationality_w8, check_with = bank_operationality_w17)

## form 10: Government Employee_Salary_Payment_Verification. Available only for week 8 and 16. week 8 is pilot data.
## form 11: Railway Count. Available only in week 10


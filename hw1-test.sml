use "hw1.sml";

(* good dates *)
val d1 = (1992, 2, 18)
val d2 = (1994, 4, 14)
val d3 = (111, 3, 3)
val d4 = (22, 3, 22)

(* bad dates *)
val d5 = (0, 3, 3)
val d6 = (1, 0, 1)
val d7 = (1, 1, 0)
val d8 = (1, 13, 1)
val d9 = (1, 1, 32)
val d10 = (1, 2, 30)
val d11 = (~1, 1, 30)

(* good leap dates*)
val d12 = (2000, 2, 29)
val d13 = (2004, 2, 29)

(* bad leap dates *)
val d14 = (1800, 2, 29)
val d15 = (1900, 2, 29)

val good_dates = [d1, d2, d3, d4, d12, d13]
val bad_dates = [d5, d6, d7, d8, d9, d10, d11, d14, d15]

val dates = [d1, d2, d3, d4]

val test1a = is_older(d1, d2) = true
val test1b = is_older(d1, d3) = false

val test2a = number_in_month(dates, 2) = 1
val test2b = number_in_month(dates, 3) = 2

val test3a = number_in_months(dates, [2, 3, 4]) = 4
val test3b = number_in_months(dates, [4])       = 1
val test3c = number_in_months(dates, [])        = 0

val test4a = dates_in_month(dates, 2) = [d1]
val test4b = dates_in_month(dates, 3) = [d3, d4]
val test4c = dates_in_month(dates, 5) = []

val test5a = dates_in_months(dates, [2])    = [d1]
val test5b = dates_in_months(dates, [2, 3]) = [d1, d3, d4]
val test5c = dates_in_months(dates, [5])    = []

val strings = ["i", "am", "the", "walrus"]
val test6a = get_nth(strings, 1) = "i"
val test6b = get_nth(strings, 4) = "walrus"

val test7a = date_to_string(d1) = "February 18, 1992"
val test7b = date_to_string(d4) = "March 22, 22"

val num_list = [1, 2, 3, 4, 5]
val test8a = number_before_reaching_sum(10, num_list)  = 3
val test8b = number_before_reaching_sum(1, num_list)   = 0
val test8c = number_before_reaching_sum(100, num_list) = 5

val test9a = what_month(1)   = 1
val test9b = what_month(31)  = 1
val test9c = what_month(32)  = 2
val test9d = what_month(334) = 11
val test9e = what_month(365) = 12

val test10a = month_range(1, 2)   = [1, 1]
val test10b = month_range(31, 32) = [1, 2]
val test10c = month_range(2, 1)   = []

val test11a = oldest(dates) = SOME d4
val test11b = oldest([])    = NONE

val test12a = append([], [])         = []
val test12b = append([], [1, 2, 3])  = [1, 2, 3]
val test12c = append([3], [])        = [3]
val test12d = append([1, 2, 3], [4]) = [1, 2, 3, 4]

val test12e = reverse_list([])        = []
val test12f = reverse_list([1])       = [1]
val test12g = reverse_list([1, 2, 3]) = [3, 2, 1]

val test12h = remove_duplicates([])           = []
val test12i = remove_duplicates([2, 3])       = [2, 3]
val test12j = remove_duplicates([2, 2, 3, 3]) = [2, 3]

val test12k = number_in_months_challenge(dates, [2, 3, 3, 4, 4]) = 4
val test12l = number_in_months_challenge(dates, [4, 4, 4])       = 1
val test12m = number_in_months_challenge(dates, [])              = 0

val test12n = dates_in_months_challenge(dates, [2])    = [d1]
val test12o = dates_in_months_challenge(dates, [2, 3]) = [d1, d3, d4]
val test12p = dates_in_months_challenge(dates, [5])    = []

val test13a = all(reasonable_dates(good_dates)) = true
val test13b = any(reasonable_dates(bad_dates)) = false

val ints = [1, 2, 3, 4, 5]
fun lt3 (x) = x < 3
fun gt5 (x) = x > 5

val test14a = any(map(lt3, ints)) = true
val test14b = any(map(gt5, ints)) = false

val test15a = all([true, true]) = true
val test15b = all([true, false]) = false

val test16a = list_ref(ints, 0) = 1
val test16b = list_ref(ints, 4) = 5

val test17a = valid_year(9999) = true
val test17b = valid_year(0) = false
val test17c = valid_year(1) = true
val test17d = valid_year(~1) = false

val test18a = valid_month(0) = false
val test18b = valid_month(1) = true
val test18c = valid_month(~1) = false
val test18d = valid_month(12) = true
val test18e = valid_month(13) = false

val test19a = valid_day(0, 1, false) = false
val test19b = valid_day(1, 1, false) = true
val test19c = valid_day(31, 1, false) = true
val test19d = valid_day(29, 2, true) = true
val test19e = valid_day(28, 2, true) = true
val test19f = valid_day(29, 2, false) = false
val test19g = valid_day(28, 2, false) = true

val test20a = is_leap_year(1) = false
val test20b = is_leap_year(1999) = false
val test20c = is_leap_year(1900) = false
val test20d = is_leap_year(1904) = true
val test20e = is_leap_year(2000) = true
(* Coursera Programming Languages, Homework 1 *)

(* 1. *)
fun is_older (x: int*int*int, y: int*int*int) =
  if #1 x <> #1 y then #1 x < #1 y
  else if #2 x <> #2 y then #2 x < #2 y
  else #3 x < #3 y


(* 2. *)
fun number_in_month (dates: (int*int*int) list, month: int) =
  if null(dates) then 0
  else
    let val date = hd(dates)
    in
      if #2 date = month then 1 + number_in_month(tl(dates), month)
      else number_in_month(tl(dates), month)
    end


(* 3. *)
fun number_in_months (dates: (int*int*int) list, months: int list) =
  if null(months) then 0
  else number_in_month(dates, hd(months)) + number_in_months(dates, tl(months))


(* 4. *)
fun dates_in_month (dates: (int*int*int) list, month: int) =
  if null(dates) then []
  else
    let val date = hd(dates)
    in
      if #2 date = month then date :: dates_in_month(tl(dates), month)
      else dates_in_month(tl(dates), month)
    end


(* 5. *)
fun dates_in_months (dates: (int*int*int) list, months: int list) =
  if null(months) then []
  else dates_in_month(dates, hd(months)) @ dates_in_months(dates, tl(months))


(* 6. *)
fun get_nth (strings: string list, n: int) =
  if n = 1 then hd(strings)
  else get_nth(tl(strings), n-1)


(* 7. *)
fun date_to_string (date: int*int*int) =
  let
    val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  in
    get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end


(* 8. *)
fun number_before_reaching_sum (sum: int, numbers: int list) =
  let
    fun count (acc: int, n: int, remaining: int list) =
      if null(remaining) then n
      else
        let val new = acc + hd(remaining)
        in
          if new >= sum then n
          else count(new, n+1, tl(remaining))
        end
  in
    count(0, 0, numbers)
  end


(* 9. *)
fun what_month (day: int) =
  1 + number_before_reaching_sum(day, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])


(* 10. *)
fun month_range (day1: int, day2: int) =
  if day1 > day2 then []
  else what_month(day1) :: month_range(day1+1, day2)


(* 11. *)
fun oldest (dates: (int*int*int) list) =
  let
    fun h (oldest_date: (int*int*int) option, dates: (int*int*int) list) =
      if null(dates) then oldest_date
      else if not ( isSome(oldest_date) ) orelse is_older(hd(dates), valOf( oldest_date))
        then h(SOME (hd dates), tl(dates))
      else h(oldest_date, tl(dates))
  in
    h(NONE, dates)
  end


(* 12. *)
fun append (xs, ys) =
  if null xs
  then ys
  else (hd xs) :: append(tl xs, ys)


fun reverse_list (lst) =
  if null lst
  then []
  else append(reverse_list(tl lst), [hd lst])


fun remove_duplicates (lst: int list) =
  let
    fun contains (x: int, lst: int list) =
      if null lst
      then false
      else if x = hd(lst)
      then true
      else contains(x, tl(lst))

    fun remove (remaining: int list, so_far: int list) =
      if null remaining
      then so_far
      else
        let
          val elem = hd(remaining)
        in
          if contains(elem, so_far)
          then remove(tl(remaining), so_far)
          else remove(tl(remaining), elem :: so_far)
        end
  in
    reverse_list(remove(lst, []))
  end


fun number_in_months_challenge (dates: (int*int*int) list, months: int list) =
  number_in_months(dates, remove_duplicates(months))


fun dates_in_months_challenge (dates: (int*int*int) list, months: int list) =
  dates_in_months(dates, remove_duplicates(months))


(* 13. *)

(* helpers *)
fun map (f, l) =
  if null l
  then []
  else f(hd l) :: map(f, tl l)


fun any (l) =
  if null l
  then false
  else if hd l
  then true
  else any(tl l)


fun all (l) =
  if null l
  then true
  else if not (hd l)
  then false
  else all(tl l)


fun list_ref (l, n) =
  if n = 0
  then hd l
  else list_ref(tl l, n-1)


(* actual problem*)
fun valid_year (year: int) =
  year >= 1


fun valid_month (month: int) =
  month >= 1 andalso month <= 12


fun valid_day (day: int, month: int, is_leap: bool) =
  let
    val feb = if is_leap then 29 else 28
    val last_days = [31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    val last_day = list_ref(last_days, month-1)
  in
    day >= 1 andalso day <= last_day
  end


fun is_leap_year (y: int) =
  (y mod 400 = 0) orelse ( (y mod 4 = 0) andalso not (y mod 100 = 0) )


fun reasonable_date (date: int*int*int) =
  let
    val y = #1 date
    val m = #2 date
    val d = #3 date
    val is_leap = is_leap_year(y)
  in
    valid_year(y) andalso valid_month(m) andalso valid_day(d, m, is_leap)
  end


fun reasonable_dates (dates: (int*int*int) list) =
  map(reasonable_date, dates)

(* Coursera Programming Languages, Homework 2 *)

fun reverse_list (lst) =
  let
    fun reverse (remaining, so_far) =
      case remaining of
        [] => so_far
      | head::tail => reverse(tail, head::so_far)
  in
    reverse(lst, [])
  end

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* Needs rewriting, algorithm is not elegant or obvious*)
fun all_except_option (item, lst) =
  let
    fun remove (remaining, so_far) =
      case remaining of
        [] => (false, so_far)
      | head::tail =>
          if head = item
          then (true, reverse_list(so_far) @ tail)
          else remove (tail, head::so_far)
  in
    case remove(lst, []) of
      (true, result) => SOME result
    | (false, _) => NONE
  end

fun get_substitutions1 (subs_list, str) =
  case subs_list of
    [] => []
  | subs::subs_list' =>
      case all_except_option(str, subs) of
        NONE => get_substitutions1(subs_list', str)
      | SOME lst => lst @ get_substitutions1(subs_list', str)

fun get_substitutions2 (subs_list, str) =
  let
    fun extract (remaining, result) =
      case remaining of
        [] => result
      | subs::remaining' =>
          case all_except_option(str, subs) of
            NONE => extract(remaining', result)
          | SOME lst => extract(remaining', result @ lst)
  in
    extract(subs_list, [])
  end

fun similar_names (subs_list, {first, middle, last}) =
  let
    fun construct_name (first_names, full_names) =
      case first_names of
        [] => full_names
        | new_name::other_names =>
          construct_name(other_names,
                         {first=new_name, middle=middle, last=last}::full_names)
  in
    reverse_list(construct_name(get_substitutions1(subs_list, first),
                                [{first=first,middle=middle,last=last}] ))
  end



(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

fun card_color (card) =
  case card of
      (Clubs, _) => Black
    | (Spades, _) => Black
    | _ => Red

fun card_value (card) =
  case card of
      (_, Ace) => 11
    | (_, King) => 10
    | (_, Queen) => 10
    | (_, Jack) => 10
    | (_, Num(i)) => i

fun remove_card (cards, card, ex) =
  case all_except_option(card, cards) of
      NONE => raise ex
    | SOME without => without

fun all_same_color(cards) =
  case cards of
      [] => true
    | _::[] => true
    | card1::card2::rest =>
        if card_color(card1) <> card_color(card2)
        then false
        else all_same_color(card2::rest)

fun sum_cards(cards) =
  let
    fun accumulate(remaining, sum) =
      case remaining of
          [] => sum
        | card::rest => accumulate(rest, sum + card_value(card))
  in
    accumulate(cards, 0)
  end

fun score (hand, goal) =
  let
    val sum = sum_cards(hand)
    val prelim_score =
      if sum > goal then 3 * (sum - goal) else goal - sum
    val factor =
      if all_same_color(hand) then 2 else 1
  in
    prelim_score div factor
  end

fun officiate (stack, moves, goal) =
  let
    fun play (stack, hand, moves) =
      case moves of
          [] => score(hand, goal)
        | Discard(card)::moves' =>
            case all_except_option(card, hand) of
                NONE => raise IllegalMove
              | SOME without_card => play(stack, without_card, moves')
        | Draw::moves' =>
            case stack of
                [] => score(hand, goal)
              | card::stack' =>
                if sum_cards(card::hand) > goal
                then score(card::hand, goal)
                else play(stack', card::hand, moves')
  in
    play(stack, [], moves)
  end
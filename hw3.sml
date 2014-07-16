(* Coursera Programming Languages, Homework 3. *)

exception NoAnswer


datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern


datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu


fun g f1 f2 p =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


(**** for the challenge problem only ****)
datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string


(* 1. *)
fun only_capitals (strs) =
	List.filter (fn s => Char.isUpper(String.sub(s, 0))) strs


(* 2. *)
fun longest_string1 (strs) =
	let
		fun longest (cur, prev) =
			if String.size(cur) > String.size(prev)
			then cur
			else prev
	in
		foldl longest "" strs
	end


(* 3. *)
fun longest_string2 (strs) =
	let
		fun longest (cur, prev) =
			if String.size(cur) >= String.size(prev)
			then cur
			else prev
	in
		foldl longest "" strs
	end


(* 4. *)
fun longest_string_helper f strs =
	let
		fun longest (cur, prev) =
			if f(String.size(cur), String.size(prev))
			then cur
			else prev
	in
		foldl longest "" strs
	end


val longest_string3 = longest_string_helper(fn (cur, prev) => cur > prev)


val longest_string4 = longest_string_helper(fn (cur, prev) => cur >= prev)


(* 5. *)
val longest_capitalized = longest_string1 o only_capitals


(* 6. *)
val rev_string = String.implode o rev o String.explode


(* 7. *)
fun first_answer f lst =
	case lst of
		[] => raise NoAnswer |
	  x::lst' =>
	    case f(x) of
	  	  SOME x => x |
	      NONE => first_answer f lst'


(* 8. *)
fun all_answers f lst =
	let fun iter (so_far, remaining) =
				case remaining of
					[] => SOME so_far |
					x::remaining' =>
					  case f(x) of
					  	NONE => NONE |
					  	SOME l => iter(so_far @ l, remaining')
	in iter([], lst) end


(* 9. *)
fun count_wildcards (p) =
	let
		fun f1 () = 1
		fun f2 (x) = 0
	in g f1 f2 p end


fun count_wild_and_variable_lengths (p) =
	let
		fun f1 () = 1
		fun f2 (x) = String.size(x)
	in g f1 f2 p end


fun count_some_var (str, p) =
	let
		fun f1 () = 0
		fun f2 (identifier) =
			if identifier = str then 1 else 0
	in g f1 f2 p end


(* 10. *)
fun check_pat (p) =
	let
		fun exists (elem, lst) =
			case lst of
				[] => false |
				first::rest =>
				  if elem = first
				  then true
				  else exists(elem, rest)

		fun no_repeats (names) =
			case names of
				[] => true |
				first::rest =>
				  if exists(first, rest)
				  then false
				  else no_repeats(rest)

		fun extract_names (p) =
			case p of
				Variable x => [x] |
				TupleP ps =>
				  List.foldl (fn (new, cur) => cur @ extract_names(new)) [] ps |
				ConstructorP(_,p) => extract_names(p) |
				_ => []

	in no_repeats(extract_names(p))
	end


(* 11. *)
fun match (value, pattern) =
	case (pattern, value) of
		  (Wildcard, _) => SOME []
		| (Variable s, _) => SOME [(s, value)]
		| (UnitP, Unit) => SOME []
		| (ConstP x, Const y) => if x = y then SOME [] else NONE
		| (TupleP ps, Tuple vs) =>
		    if List.length(ps) = List.length(vs)
		    then all_answers match (ListPair.zip(vs, ps))
		    else NONE
		| (ConstructorP(s1, p), Constructor(s2, v)) =>
		    if s1 = s2 then match(v, p) else NONE
		| (_, _) => NONE


(* 12. *)
fun first_match (value, patterns) =
	SOME (first_answer (fn p => match(value, p)) patterns) handle NoAnswer => NONE

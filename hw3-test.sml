use "hw3.sml";

val strs1 = ["All", "my", "Loving"]
val strs2 = ["love", "me", "do"]
val strs3 = ["All", "my", "loving"]

val t1a = only_capitals(strs1) = ["All", "Loving"]
val t1b = only_capitals(strs2) = []

val t2a = longest_string1(strs1) = "Loving"
val t2b = longest_string1([]) = ""
val t2c = longest_string1(["one", "two"]) = "one"

val t3a = longest_string2(strs1) = "Loving"
val t3b = longest_string2([]) = ""
val t3c = longest_string2(["one", "two"]) = "two"

val t4a = longest_string3(strs1) = "Loving"
val t4b = longest_string3([]) = ""
val t4c = longest_string3(["one", "two"]) = "one"

val t5a = longest_string4(strs1) = "Loving"
val t5b = longest_string4([]) = ""
val t5c = longest_string4(["one", "two"]) = "two"

val t6a = longest_capitalized(strs3) = "All"
val t6b = longest_capitalized(strs2) = ""

val t7a = rev_string("Hello") = "olleH"
val t7b = rev_string("") = ""

val t8a = first_answer (fn x => SOME x) [1, 2, 3] = 1
val t8b = ( (first_answer (fn x => SOME x) []) handle NoAnswer => [] ) = []
val t8c = first_answer (fn x => if x mod 2 = 0 then SOME x else NONE) [1, 2, 3] = 2

val t9a = all_answers (fn x => SOME [x]) [] = SOME []
val t9b = all_answers (fn x => SOME [x]) [1, 2, 3] = SOME [1, 2, 3]

val t10a = count_wildcards(Wildcard) = 1
val t10b = count_wildcards(Variable("nope")) = 0
val t10c = count_wildcards(TupleP([Variable("x"), Wildcard, UnitP, Wildcard, ConstP(1), Wildcard])) = 3

val t10d = count_wild_and_variable_lengths(Wildcard) = 1
val t10e = count_wild_and_variable_lengths(Variable("yep")) = 3
val t10f = count_wild_and_variable_lengths(TupleP([Variable("x"), TupleP([Variable("inner"), Wildcard]), Wildcard, ConstructorP("C", Variable("c")), UnitP, Wildcard, Variable("xyz"), Wildcard])) = 14

val t10g = count_some_var("str", Wildcard) = 0
val t10h = count_some_var("yep", Variable("yep")) = 1
val t10i = count_some_var("test", TupleP([Variable("x"), TupleP([Variable("test"), Wildcard]), Wildcard, ConstructorP("C", Variable("c")), UnitP, Wildcard, Variable("test"), Wildcard])) = 2

val t11a = check_pat(Wildcard) = true
val t11b = check_pat(Variable("yep")) = true
val t11c = check_pat(TupleP([Variable("x"), TupleP([Variable("x"), Wildcard]), Wildcard, ConstructorP("C", Variable("y")), UnitP, Wildcard, Variable("z"), Wildcard])) = false
val t11d = check_pat(TupleP([Variable("x"), TupleP([Variable("y"), Wildcard]), Wildcard, ConstructorP("C", Variable("x")), UnitP, Wildcard, Variable("z"), Wildcard])) = false
val t11e = check_pat(TupleP([Variable("x"), TupleP([Variable("y"), Wildcard]), Wildcard, ConstructorP("C", Variable("z")), UnitP, Wildcard, Variable("x"), Wildcard])) = false
val t11f = check_pat(TupleP([Variable("x"), TupleP([Variable("y"), Wildcard]), Wildcard, ConstructorP("C", Variable("z")), UnitP, Wildcard, Variable("a"), Wildcard])) = true

val t12a = match(Unit, Wildcard) = SOME []
val t12b = match(Unit, UnitP) = SOME []
val t12c = match(Const 42, UnitP) = NONE
val t12d = match(Const 42, Variable "answer") = SOME [("answer", Const 42)]

val t12e = match(Const 6, ConstP 6) = SOME []
val t12f = match(Const 6, ConstP 666) = NONE

val t12g = match(Tuple([Const 6, Unit]), TupleP([ConstP 6, UnitP])) = SOME []
val t12h = match(Tuple([Const 6, Tuple([Constructor("c", Const 1)]), Unit]), TupleP([ConstP 6, TupleP([Variable "v"]), UnitP])) = SOME [("v", Constructor("c", Const 1))]
val t12i = match(Tuple([Const 6, Const 7]), TupleP([ConstP 6, UnitP])) = NONE

val t13a = first_match(Unit, [ConstP 5, UnitP]) = SOME []
val t13b = first_match(Unit, [Wildcard, ConstP 5]) = SOME []
val t13c = first_match(Unit, [ConstP 5]) = NONE

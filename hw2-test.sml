use "hw2.sml";

val s = ["love", "me", "do"]
val t1a = all_except_option("love", s) = SOME ["me", "do"]
val t1b = all_except_option("me", ["me"]) = SOME []
val t1c = all_except_option("love", []) = NONE
val t1d = all_except_option("love", ["glass", "onion"]) = NONE

val t2a = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]
val t2b = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val t3a = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]
val t3b = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val t4answer = [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val t4a = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) = t4answer

val card1 = (Clubs, Num(5))
val card2 = (Diamonds, Jack)
val card3 = (Hearts, Ace)
val card4 = (Spades, Num(10))

val cards = [card1, card2, card3, card4]
exception Ex

val t5a = card_color(card1) = Black
val t5b = card_color(card3) = Red

val t6a = card_value(card2) = 10
val t6b = card_value(card4) = 10
val t6c = card_value(card3) = 11

val t7a = remove_card(cards, card1, Ex) = [card2, card3, card4]
val t7b = remove_card(card1::cards, card1, Ex) = cards
val t7c = ( remove_card([card2, card3], card1, Ex) handle Ex => [] ) = []
val t7d = ( remove_card([], card1, Ex) handle Ex => [] ) = []

val t8a = all_same_color([]) = true
val t8b = all_same_color(cards) = false
val t8c = all_same_color([card1, card4]) = true

val t9a = sum_cards([]) = 0
val t9b = sum_cards([card1]) = 5
val t9c = sum_cards(cards) = 36

val t10a = score(cards, 36) = 0
val t10b = score(cards, 35) = 3
val t10c = score(cards, 37) = 1
val t10d = score(cards, 36) = 0
val t10e = score([card1, card4], 10) = 7
val t10f = score([card1, card4], 20) = 2
val t10g = score([card1, card4], 21) = 3

extends Node


var card_ref = load("res://src/Card/CardData.gd")

var deck = []



func buy_cards(hand, n = 1) -> void:

	for _i in range(n):
		hand.append(get_random_card())


func get_random_card(first: bool = false):

	randomize()
	var r = int(rand_range(0, deck.size()))
	var card = deck[r]
	
	if first:
		if card.type == "plus4" or card.type == "jokey":
			card.color = int(rand_range(1,5))

	deck.remove(r)
	return card


func gen_deck() -> Array:

	for n in range(10):
		for c in range(1, 5):
			for _i in range(2):

				var card = card_ref.new(str(n), c)
				deck.append(card)
				if n == 0: break
	
	for n in ["block", "reverse", "plus2"]:
		for c in range(1, 5):
			for _i in range(2):

				var card = card_ref.new(n, c)
				deck.append(card)
	
	for n in ["plus4", "jokey"]:
		for _i in range(4):

			var card = card_ref.new(n, -1)
			deck.append(card)
	
	return deck


func array_to_dic(arr: Array):

	var dic = {}
	var j = 0
	
	for c in arr:
		dic[j] = {"stringValue": c.to_string()}

		j += 1
	
	return dic


func update_deck(dic: Dictionary):

	deck.clear()
	for k in dic:
		deck.append(to_card_data(dic[k]))


func to_card_data(s):
	var args
	if typeof(s) == TYPE_DICTIONARY:
		 args = s.stringValue.split("_")
	elif typeof(s) == TYPE_STRING: args = s.split("_")
	 

	# print("args[0]: ", args[0])
	# print("int(args[1]): ", int(args[1]))
	# print("int(args[2]): ", int(args[2]))

	var c = card_ref.new(args[0], int(args[1]), int(args[2]))
	return c
	# var c = card_ref.new(args[0], int(args[1].split("_")[0]), int(args[2].split("_")[1]))
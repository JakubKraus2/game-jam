extends StaticBody2D



var flower = load("res://game/objects/flowers/flower.tscn")
var flowers = []
var not_poisonous = 0
var correct_code = []
@export var safe = Node2D


func _ready():
	for i in 3:
		var flower_intance = flower.instantiate()
		add_child(flower_intance)
		flower_intance.position.x = 34 * i
		flowers.append(flower_intance)
	check_flowers()


func check_flowers():
	not_poisonous = 0
	correct_code.clear()
	for i in flowers:
		for j in flowers:
			if i.generate_random == j.generate_random && i != j:
				i.generate_flower()
				check_flowers()
				return
		if i.is_poisonous == false:
			not_poisonous += 1
		correct_code.append(i.leaf_num)
	if not_poisonous != 1:
		for i in flowers:
			i.generate_flower()
		check_flowers()
	safe.correct_code.clear()
	safe.correct_code.append_array(correct_code)
	print(safe.correct_code)

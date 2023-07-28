extends CanvasLayer



var flask_big = load("res://game/minigames/mixing_minigame/flask_big.tscn")
var space = 104

var percentage = 0
var correct_substances = {"Cerna": 15, "Modra": 50, "Zluta": 35}

func _ready():
	$VBoxContainer/SubstanceName.text = "Amoniak"
	$VBoxContainer/SubstancePercentage.text = str(percentage) + "%"
	get_parent().player.set_physics_process(false)
	for i in get_parent().substance_table.substances.size():
		var flask_big_instance = flask_big.instantiate()
		add_child(flask_big_instance)
		flask_big_instance.global_position = Vector2(340 + (space*i), 80)
		for j in flask_big_instance.get_children():
			if j.is_in_group("substance_particle"):
				j.substance_particle_name = get_parent().substance_table.substances[i].substance_name
				j.set_modulate(get_parent().substance_table.substances[i].substance_color)


func _on_pouring_flask_child_entered_tree(node):
	if node.is_in_group("substance_particle"):
		percentage += 1
		$VBoxContainer/SubstancePercentage.text = str(percentage) + "%"

func _on_button_pressed():
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()

func _on_button_2_pressed():
	var passable = 0
	for i in $PouringFlask.get_children():
		if i.is_in_group("substance_particle"):
			if get_parent().owner.correct_substances.has(i.substance_particle_name):
				get_parent().owner.correct_substances[i.substance_particle_name] += 1
	for i in get_parent().owner.correct_substances:
		if get_parent().owner.correct_substances[i] < get_parent().owner.correct_percentage[i] + 15 && get_parent().owner.correct_substances[i] > get_parent().owner.correct_percentage[i] - 15 :
			passable += 1
		else:
			print("game over")
			print(get_parent().owner.correct_substances)
			break
	if passable == get_parent().owner.correct_substances.size():
		print("you win")
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()

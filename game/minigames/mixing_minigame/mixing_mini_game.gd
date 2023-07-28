extends CanvasLayer



var flask_big = load("res://game/minigames/mixing_minigame/flask_big.tscn")
var generated_substance = load("res://game/objects/substances/test_substance.tscn")
var space = 104

var percentage = 0
var passable = 0


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
	for i in get_parent().owner.correct_substances:
		get_parent().owner.correct_substances[i] = 0


func _on_pouring_flask_child_entered_tree(node):
	if node.is_in_group("substance_particle"):
		percentage += 1
		$VBoxContainer/SubstancePercentage.text = str(percentage) + "%"

func _on_button_pressed():
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()

func _on_button_2_pressed():
	for i in $PouringFlask.get_children():
		if i.is_in_group("substance_particle"):
			if get_parent().owner.correct_substances.has(i.substance_particle_name):
				get_parent().owner.correct_substances[i.substance_particle_name] += 1
	for i in get_parent().owner.correct_substances:
		if get_parent().owner.correct_substances[i] < get_parent().owner.correct_percentage[i] + 15 && get_parent().owner.correct_substances[i] > get_parent().owner.correct_percentage[i] - 15 :
			passable += 1
	generate_substance()
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()
	get_parent().check_placements()

func generate_substance():
	var generated_substance_instance = generated_substance.instantiate()
	for i in get_parent().substance_table.get_children():
		if i.is_in_group("placements"):
			for j in i.get_children():
				j.queue_free()
			if !get_parent().substance_table.placements.has(i):
				get_parent().substance_table.placements.append(i)
	get_parent().substance_table.substances.append(generated_substance_instance)
	generated_substance_instance.substance_color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), randf_range(0.3, 1))
	get_parent().substance_table.placements[0].add_child(generated_substance_instance)
	generated_substance_instance.global_position = get_parent().substance_table.placements[0].global_position
	get_parent().substance_table.placements.erase(get_parent().substance_table.placements[0])
	if passable == get_parent().owner.correct_substances.size():
		print("jj")
		generated_substance_instance.add_to_group("correct")
	else:
		print("nn")
		generated_substance_instance.add_to_group("incorrect")

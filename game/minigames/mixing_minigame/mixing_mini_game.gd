extends CanvasLayer



var flask_big = load("res://game/minigames/mixing_minigame/flask_big.tscn")
var generated_substance = load("res://game/objects/substances/test_substance.tscn")
var progress_box = load("res://game/minigames/mixing_minigame/progress_box.tscn")
var space = 104

var passable = 0
var wrong_substances = {}
var wrong_percentage = {}


func _ready():
	$Button.disabled = false
	$Button2.disabled = true
	get_parent().player.set_physics_process(false)
	for i in get_parent().owner.correct_substances:
		get_parent().owner.correct_substances[i] = 0
	for i in get_parent().substance_table.substances.size():
		var flask_big_instance = flask_big.instantiate()
		add_child(flask_big_instance)
		flask_big_instance.global_position = Vector2(340 + (space*i), 80)
		for j in flask_big_instance.get_children():
			if j.is_in_group("substance_particle"):
				j.substance_particle_name = get_parent().substance_table.substances[i].substance_name
				j.set_modulate(get_parent().substance_table.substances[i].substance_color)
		var progress_box_instance = progress_box.instantiate()
		$ProgressContainer.add_child(progress_box_instance)
		progress_box_instance.substance_name.text = str(get_parent().substance_table.substances[i].substance_name)
		if get_parent().owner.correct_substances.has(get_parent().substance_table.substances[i].substance_name):
			progress_box_instance.substance_percentage.text = "%d" % get_parent().owner.correct_substances[get_parent().substance_table.substances[i].substance_name] + "%"
		else:
			progress_box_instance.substance_percentage.text = "0%"
			wrong_substances.keys().append(progress_box_instance.substance_name.text)
			wrong_substances[progress_box_instance.substance_name.text] = 0
			wrong_percentage.keys().append(progress_box_instance.substance_name.text)
			wrong_percentage[progress_box_instance.substance_name.text] = floor(randf_range(10, 50))


func update_percentage(node):
	if node.is_in_group("substance_particle"):
		if get_parent().owner.correct_substances.has(node.substance_particle_name):
			get_parent().owner.correct_substances[node.substance_particle_name] += 1
		else:
			wrong_substances[node.substance_particle_name] +=  1
	for i in $ProgressContainer.get_children():
		if i.substance_name.text == node.substance_particle_name && get_parent().owner.correct_substances.has(i.substance_name.text):
			i.substance_percentage.text = str(floor(get_parent().owner.correct_substances[i.substance_name.text] / get_parent().owner.correct_percentage[i.substance_name.text] * 100)) + "%"
		if i.substance_name.text == node.substance_particle_name && wrong_percentage.has(i.substance_name.text):
			i.substance_percentage.text = str(floor(wrong_substances[node.substance_particle_name] / wrong_percentage[node.substance_particle_name] * 100)) + "%"

func _on_pouring_flask_child_entered_tree(node):
	$Button2.disabled = false
	$Button.disabled = true
	update_percentage(node)


func _on_button_pressed():
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()

func _on_button_2_pressed():
	for i in get_parent().owner.correct_substances:
		get_parent().owner.correct_substances[i] = 0
	for i in $PouringFlask.get_children():
		if i.is_in_group("substance_particle"):
			if get_parent().owner.correct_substances.has(i.substance_particle_name):
				get_parent().owner.correct_substances[i.substance_particle_name] += 1
	for i in get_parent().owner.correct_substances:
		if get_parent().owner.correct_substances[i] < get_parent().owner.correct_percentage[i] + 10 && get_parent().owner.correct_substances[i] > get_parent().owner.correct_percentage[i] - 10 :
			passable += 1
	generate_substance()
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()
	get_parent().check_placements()
	print(get_parent().owner.correct_substances)

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
	generated_substance_instance.substance_name = "Mixture"
	get_parent().substance_table.placements[0].add_child(generated_substance_instance)
	generated_substance_instance.global_position = get_parent().substance_table.placements[0].global_position
	get_parent().substance_table.placements.erase(get_parent().substance_table.placements[0])
	if passable == get_parent().owner.correct_substances.size():
		print("jj")
		generated_substance_instance.add_to_group("correct")
	else:
		print("nn")
		generated_substance_instance.add_to_group("incorrect")

extends CanvasLayer



var flask_big = load("res://game/minigames/mixing_minigame/flask_big.tscn")
var space = 104


func _ready():
	get_parent().player.set_physics_process(false)
	print(get_parent().substance_table.substances)
	for i in get_parent().substance_table.substances.size():
		var flask_big_instance = flask_big.instantiate()
		add_child(flask_big_instance)
		flask_big_instance.global_position = Vector2(340 + (space*i), 80)
		for j in flask_big_instance.get_children():
			if j.is_in_group("substance_particle"):
				j.substance_particle_name = get_parent().substance_table.substances[i].substance_name
				j.set_modulate(get_parent().substance_table.substances[i].substance_color)


func _on_button_pressed():
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()

extends CanvasLayer




func _ready():
	get_parent().player.set_physics_process(false)
	print(get_parent().substance_table.substances)


func _on_button_pressed():
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()

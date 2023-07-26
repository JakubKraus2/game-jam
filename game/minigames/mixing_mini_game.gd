extends CanvasLayer




func _ready():
	print(get_parent().substance_table.substances)


func _on_button_pressed():
	get_parent().playing_mini_game = false
	queue_free()

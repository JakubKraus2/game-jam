extends LevelParent


var page = 1



func _on_ready():
	get_parent().player.set_physics_process(false)
	change_page()

func change_page():
	if page < 1:
		page = 1
	elif page > 9:
		page = 9
	$CenterContainer/VBoxContainer/CenterContainer/Flower.texture = load("res://assets/objects/flowers/flower" + str(page) + ".png")
	match page:
		1:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_not_poison.png")
		2:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_poison.png")
		3:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_poison.png")
		4:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_poison.png")
		5:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_not_poison.png")
		6:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_poison.png")
		7:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_not_poison.png")
		8:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_poison.png")
		9:
			$CenterContainer/VBoxContainer/Sign.texture = load("res://assets/menus/book_flower_poison.png")


func _on_texture_button_pressed():
	page -= 1
	change_page()

func _on_texture_button_2_pressed():
	page += 1
	change_page()

func _on_texture_button_3_pressed():
	get_parent().player.set_physics_process(true)
	get_parent().playing_mini_game = false
	queue_free()

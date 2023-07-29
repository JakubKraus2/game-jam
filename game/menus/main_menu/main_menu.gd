extends LevelParent





func _on_quit_button_pressed():
	PseudoLoading.get_node("AnimationPlayer").play("change")
	await PseudoLoading.get_node("AnimationPlayer").animation_finished
	get_tree().quit()

func _on_select_level_button_pressed():
	PseudoLoading.get_node("AnimationPlayer").play("change")
	await PseudoLoading.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file("res://game/menus/level_select_menu/level_select_menu.tscn")

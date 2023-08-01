extends CanvasLayer




func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible == false:
			$AnimationPlayer.play("open")
		else:
			$AnimationPlayer.play("close")

func _on_visibility_changed():
	if Global.current_level != null:
		$TextureRect/HBoxContainer/Label.text = "Level" + str(Global.current_level)


func _on_resume_button_pressed():
	$AnimationPlayer.play("close")

func _on_quit_button_pressed():
	PseudoLoading.get_node("AnimationPlayer").play("change")
	$AnimationPlayer.play("close")
	await PseudoLoading.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file("res://game/menus/level_select_menu/level_select_menu.tscn")
	MainCamera.global_position = MainCamera.get_viewport_rect().size/2

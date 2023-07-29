extends CanvasLayer




func _ready():
	print(Global.data)
	print(Global.level)
	PseudoLoading.get_node("AnimationPlayer").play("load")
	var last_unlocked_level = clamp(Global.level, 1, $VBoxContainer/HBoxContainer.get_child_count())
	for i in last_unlocked_level:
		$VBoxContainer/HBoxContainer.get_child(i).disabled = false
	for i in $VBoxContainer/HBoxContainer.get_children():
		if i.disabled == true:
			i.get_child(0).visible = false
		else:
			i.get_child(0).visible = true


func _on_texture_button_pressed():
	PseudoLoading.get_node("AnimationPlayer").play("change")
	await PseudoLoading.get_node("AnimationPlayer").animation_finished
	Global.current_level = 1
	get_tree().change_scene_to_file("res://game/levels/level1.tscn")

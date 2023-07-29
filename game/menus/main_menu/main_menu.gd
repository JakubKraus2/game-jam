extends LevelParent





func _on_quit_button_pressed():
	PseudoLoading.get_node("AnimationPlayer").play("change")
	await PseudoLoading.get_node("AnimationPlayer").animation_finished
	get_tree().quit()

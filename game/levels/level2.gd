extends LevelParent



var correct_substances = {"Water": 0.0, "Flower Powder": 0.0}
var correct_percentage = {"Water": 60.0, "Flower Powder": 20.0}
var already_played = false


func _on_ready():
	$DialoguePlayer.play()
	$Player.set_physics_process(false)


func _on_child_exiting_tree(node):
	if already_played == false:
		if node == $DialoguePlayer:
			$Player.set_physics_process(true)
			$Fuses.get_node("BlackOutTimer").start()
			already_played = true

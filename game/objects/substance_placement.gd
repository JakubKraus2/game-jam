extends Node2D



func _ready():
	get_parent().placements.append(self)


func _on_child_exiting_tree(node):
	if !get_parent().placements.has(self):
		get_parent().placements.append(self)
		get_parent().interaction_input_text.visible = true
		get_parent().interaction_text.visible = true
	get_parent().substances.erase(node)

func _on_child_entered_tree(node):
	await get_tree().create_timer(0.01).timeout
	get_parent().placements.erase(self)

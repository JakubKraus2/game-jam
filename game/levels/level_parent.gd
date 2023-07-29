extends Node
class_name LevelParent



func _ready():
	PseudoLoading.get_node("AnimationPlayer").play("load")

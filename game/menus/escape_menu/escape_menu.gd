extends CanvasLayer




func _ready():
	if Global.current_level != null:
		$TextureRect/HBoxContainer/Label.text = "Level" + str(Global.current_level)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible == false:
			$AnimationPlayer.play("open")
		else:
			$AnimationPlayer.play("close")

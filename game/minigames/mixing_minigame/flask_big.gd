extends Button




func _ready():
	set_process(false)

func _process(delta):
	var old_position = global_position
	global_position = Vector2(get_global_mouse_position().x - ($AnimatableBody2D/Sprite2D.texture.get_width()), get_global_mouse_position().y - ($AnimatableBody2D/Sprite2D.texture.get_height()))
#	var tween = create_tween()
#	tween.tween_property(self, "global_position", Vector2(get_global_mouse_position().x - ($AnimatableBody2D/Sprite2D.texture.get_width()), get_global_mouse_position().y - ($AnimatableBody2D/Sprite2D.texture.get_height())), 0.1)
	if Input.is_action_just_released("rotate_up"):
		var rotation_tween = create_tween()
		rotation_tween.tween_property(self, "rotation", rotation+0.4, 0.1)
	if Input.is_action_just_released("rotate_down"):
		var rotation_tween2 = create_tween()
		rotation_tween2.tween_property(self, "rotation", rotation-0.4, 0.1)


func _on_button_down():
	set_process(true)

func _on_button_up():
	rotation = 0
	set_process(false)

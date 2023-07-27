extends AnimatableBody2D




func _ready():
	set_process(false)

func _process(delta):
	if Input.is_action_pressed("left_click"):
		var target = Vector2.ZERO
		target.x = clamp(get_global_mouse_position().x, 0, get_viewport_rect().size.x)
		target.y = clamp(get_global_mouse_position().y, 0, get_viewport_rect().size.y)
		var tween = create_tween()
		tween.tween_property(self, "global_position", target, 250 * delta)
		if Input.is_action_just_released("rotate_up"):
			var rotation_tween = create_tween()
			rotation_tween.tween_property(self, "rotation", rotation+0.4, 0.1)
		if Input.is_action_just_released("rotate_down"):
			var rotation_tween2 = create_tween()
			rotation_tween2.tween_property(self, "rotation", rotation-0.4, 0.1)
	elif Input.is_action_just_released("left_click"):
		var tween = create_tween()
		tween.tween_property(self, "global_position", global_position, 250 * delta)
		set_process(false)
		$Area2D/CollisionShape2D.disabled = true
		await get_tree().create_timer(0.1).timeout
		$Area2D/CollisionShape2D.disabled = false


func _on_area_2d_mouse_entered():
	set_process(true)

func _on_area_2d_mouse_exited():
	if !Input.is_action_pressed("left_click"):
		set_process(false)

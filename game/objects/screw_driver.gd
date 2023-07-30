extends Pickable




func _on_ready():
	$Label2.text = "Screw Driver"
	$SpriteIdle.visible = true
	$Sprite2D.visible = false

func _process(delta):
	check_for_areas()
	if Input.is_action_just_pressed("interact"):
		if get_parent().name != "Player":
			reparent(player)
			position = Vector2(7, 8)
			$Label.visible = false
			$Label2.visible = false
			$SpriteIdle.visible = false
			$Sprite2D.visible = true
			$AreaChecker.set_deferred("monitorable", false)
		else:
			reparent(get_parent().owner)
			$SpriteIdle.visible = true
			$Sprite2D.visible = false
			$AreaChecker.set_deferred("monitorable", true)

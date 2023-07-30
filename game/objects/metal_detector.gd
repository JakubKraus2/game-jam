extends Pickable


var distance
@export var object_to_find = Node2D



func _on_ready():
	$Label2.text = "Metal Detector"
	$SpriteIdle.visible = true
	$Sprite2D.visible = false

func _process(delta):
	check_for_areas()
	distance = abs($BeepSound.global_position - object_to_find.global_position)
	distance = clamp(abs(distance.x + distance.y)/1000, 0.0, 1.0)
	$BeepSoundFrequencyTimer.set_wait_time(0.1 + distance)
	if Input.is_action_just_pressed("interact"):
		if get_parent().name != "Player":
			$BeepSoundFrequencyTimer.start()
			reparent(player)
			player.speed = 140
			player.get_node("AnimationTree").set("parameters/Movement/TimeScale/scale", 0.7)
			position = Vector2(7, 8)
			$Label.visible = false
			$Label2.visible = false
			$SpriteIdle.visible = false
			$Sprite2D.visible = true
			$AreaChecker.set_deferred("monitorable", false)
		else:
			reparent(get_parent().owner)
			$BeepSoundFrequencyTimer.stop()
			player.speed = 200
			player.get_node("AnimationTree").set("parameters/Movement/TimeScale/scale", 1.0)
			$SpriteIdle.visible = true
			$Sprite2D.visible = false
			$AreaChecker.set_deferred("monitorable", true)


func _on_beep_sound_frequency_timer_timeout():
	$BeepSound.play()


func _on_object_detector_area_entered(area):
	object_to_find.found = true

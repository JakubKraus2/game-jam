extends StaticBody2D



var player


func _ready():
	set_process(false)
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Hand over"
	$Label.visible = false
	$Label2.visible = false

func _process(delta):
	if player.can_pick_up == false:
		$Label.visible = true
		$Label2.visible = true
		if Input.is_action_just_pressed("put"):
			for i in player.get_children():
				if i.is_in_group("substances"):
					if i.is_in_group("correct"):
						i.queue_free()
						player.can_pick_up = true
						print("victory")
						if Global.level < Global.current_level + 1:
							Global.level =  Global.current_level + 1
							Global.data.level = Global.level
							Global.save_data()
						break
					else:
						i.queue_free()
						player.can_pick_up = true
						print("game over")
						break
	else:
		$Label.visible = false
		$Label2.visible = false


func _on_area_2d_body_entered(body):
	player = body
	if player.can_pick_up == false:
		set_process(true)

func _on_area_2d_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

extends Node2D



var water_drop = load("res://game/objects/water_drop.tscn")
var towel



func _ready():
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use Towel"
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("put"):
		if towel.name == "Towel" && towel.get_parent().name == "Player":
			towel.is_used = true
			towel.get_node("Sprite2D").set_modulate(Color(0.5, 0.5, 0.5, 1))
			towel.get_node("SpriteIdle").set_modulate(Color(0.5, 0.5, 0.5, 1))
			queue_free()

func _on_create_water_drop_timer_timeout():
	var water_drop_instance = water_drop.instantiate()
	add_child(water_drop_instance)
	water_drop_instance.position = Vector2(randf_range(-44, 44), randf_range(-22, 22))
	$CreateWaterDropTimer.start()


func _on_area_entered(area):
	towel = area
	if area.name == "Towel" && towel.get_parent().name == "Player":
		$Label.visible = true
		$Label2.visible = true
		set_process(true)


func _on_area_exited(area):
	$Label.visible = false
	$Label2.visible = false
	set_process(true)

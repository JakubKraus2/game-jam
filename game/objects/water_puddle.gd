extends Node2D



var water_drop = load("res://game/objects/water_drop.tscn")





func _on_create_water_drop_timer_timeout():
	var water_drop_instance = water_drop.instantiate()
	add_child(water_drop_instance)
	water_drop_instance.position = Vector2(randf_range(-44, 44), randf_range(-22, 22))
	$CreateWaterDropTimer.start()

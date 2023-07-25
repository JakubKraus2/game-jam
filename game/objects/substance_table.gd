extends StaticBody2D



var player
var placements = []
@onready var interaction_input_text = $Label
@onready var interaction_text = $Label2


func _ready():
	$Label.visible = false
	$Label2.visible = false
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Put Down"
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("put"):
		for i in player.get_children():
			if i.is_in_group("substances") && placements.size() > 0:
				i.reparent(placements[0])
				i.global_position = placements[0].global_position
				i.set_process(false)
				player.can_pick_up = true
				i.collision_checker.set_deferred("monitorable", true)
				if i.collision_checker.has_overlapping_areas():
					for j in i.collision_checker.get_overlapping_areas():
						j.get_parent().set_process(false)
		$Label.visible = false
		$Label2.visible = false


func _on_area_2d_body_entered(body):
	player = body
	set_process(true)
	if player.can_pick_up == false:
		$Label.visible = true
		$Label2.visible = true

func _on_area_2d_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

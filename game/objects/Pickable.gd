extends Area2D
class_name Pickable



var player



func _ready():
	$Label.text = "[" + InputMap.action_get_events("interact")[0].as_text() + "]"
	$Label.visible = false
	$Label2.visible = false
	$SpriteIdle.visible = true
	$Sprite2D.visible = false
	set_process(false)

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var side = 200 * direction
	if side != Vector2.ZERO:
		$AnimationTree.set("parameters/Direction/blend_position", side)


func check_for_areas():
	if $AreaChecker.has_overlapping_areas():
		for i in $AreaChecker.get_overlapping_areas():
			i.get_parent().set_process(false)


func _on_body_entered(body):
	if get_parent().name != "Player":
		$Label.visible = true
		$Label2.visible = true
	player = body
	set_process(true)

func _on_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

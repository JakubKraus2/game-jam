extends Area2D


var player
var distance
@export var object_to_find = Node2D


func _ready():
	$Label.text = "[" + InputMap.action_get_events("interact")[0].as_text() + "]"
	$Label2.text = "Metal Detector"
	$Label.visible = false
	$Label2.visible = false
	$SpriteIdle.visible = true
	$Sprite2D.visible = false
	set_process(false)

func _process(delta):
	distance = abs($BeepSound.global_position - object_to_find.global_position)
	distance = clamp(abs(distance.x - distance.y)/1000, 0.0, 1.0)
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
		else:
			reparent(get_parent().owner)
			$BeepSoundFrequencyTimer.stop()
			player.speed = 200
			player.get_node("AnimationTree").set("parameters/Movement/TimeScale/scale", 1.0)
			$SpriteIdle.visible = true
			$Sprite2D.visible = false

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var side = 200 * direction
	if side != Vector2.ZERO:
		$AnimationTree.set("parameters/Direction/blend_position", side)


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


func _on_beep_sound_frequency_timer_timeout():
	$BeepSound.play()

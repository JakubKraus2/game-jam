extends Area2D



var player
var black_out = false
@export var darkness = TextureRect
@export var doctor = Node2D


func _ready():
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use"
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("put") && black_out == true:
		$Label.visible = false
		$Label2.visible = false
		$Sprite2D.texture = load("res://assets/objects/fuses.png")
		black_out = false
		darkness.visible = false
		$LoseTimer.stop()


func _on_body_entered(body):
	player = body
	if black_out == true:
		$Label.visible = true
		$Label2.visible = true
		set_process(true)

func _on_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)


func _on_black_out_timer_timeout():
	$BlackOutTimer.start(randi_range(23, 35))
	$LoseTimer.start(12)
	$Sprite2D.texture = load("res://assets/objects/fuses_off.png")
	darkness.visible = true
	black_out = true

func _on_lose_timer_timeout():
	doctor.lose()

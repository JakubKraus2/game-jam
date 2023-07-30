extends StaticBody2D



var pong_mini_game = load("res://game/minigames/pong_minigame/pong_minigame.tscn")
var playing_mini_game = false
var already_played = false
var player
@export var hidden_substance_name = "Test"
@export var hidden_substance_color = Color(1, 1, 1, 1)


func _ready():
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use"
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("put") && playing_mini_game == false && already_played == false:
		playing_mini_game = true
		$Label.visible = false
		$Label2.visible = false
		var pong_mini_game_instance = pong_mini_game.instantiate()
		add_child(pong_mini_game_instance)


func _on_area_2d_body_entered(body):
	player = body
	if already_played == false:
		$Label.visible = true
		$Label2.visible = true
		set_process(true)

func _on_area_2d_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

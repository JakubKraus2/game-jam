extends Node2D



var generated_substance = load("res://game/objects/substances/substance.tscn")
var safe_minigame = load("res://game/minigames/safe_minigame/safe_minigame.tscn")
var player
var playing_mini_game = false
var already_played = false

@export var correct_code: Array[int] = []
@export var generated_substance_name = "Test"
@export var generated_substance_color = Color(1, 1, 1, 1)


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
		var safe_minigame_instance = safe_minigame.instantiate()
		add_child(safe_minigame_instance)


func generate_substance():
	var generated_substance_instance = generated_substance.instantiate()
	get_parent().add_child(generated_substance_instance)
	$Sprite2D.set_offset(Vector2(12, 0))
	generated_substance_instance.global_position = Vector2(global_position.x, global_position.y + 11)
	generated_substance_instance.substance_name = generated_substance_name
	generated_substance_instance.substance_color = generated_substance_color
	generated_substance_instance._ready()
	$Sprite2D.texture = load("res://assets/objects/safe_opened.png")


func _on_body_entered(body):
	player = body
	if already_played == false:
		$Label.visible = true
		$Label2.visible = true
		set_process(true)

func _on_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

extends StaticBody2D



@onready var interaction_input_text = $Label
@onready var interaction_text = $Label2
@export var substance_table = Node2D
var mixing_mini_game = load("res://game/minigames/mixing_minigame/mixing_mini_game.tscn")
var playing_mini_game = false
var player


func _ready():
	set_process(false)
	interaction_input_text.visible = false
	interaction_text.visible = false
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use"

func _process(delta):
	if Input.is_action_just_pressed("put") && playing_mini_game == false:
		playing_mini_game = true
		var mixing_mini_game_instance = mixing_mini_game.instantiate()
		add_child(mixing_mini_game_instance)


func _on_area_2d_body_entered(body):
	player = body
	check_placements()

func _on_area_2d_body_exited(body):
	interaction_input_text.visible = false
	interaction_text.visible = false
	set_process(false)


func check_placements():
	if substance_table.placements.size() == 0 && $Area2D.has_overlapping_bodies():
		interaction_text.visible = true
		interaction_input_text.visible = true
		set_process(true)
	else:
		interaction_text.visible = false
		interaction_input_text.visible = false
		set_process(false)

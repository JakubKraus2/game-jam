extends Area2D
class_name Substance


var player
@export var substance_name = "test"
@onready var interaction_text = $Label
@onready var substance_name_text = $Label2


func _ready():
	interaction_text.visible = false #set text to invisible
	substance_name_text.visible = false #set text to invisible
	interaction_text.text = "[" + InputMap.action_get_events("interact")[0].as_text() + "]" #set text to interaction
	substance_name_text.text = substance_name #set text to sbbstance name
	set_process(false) #process is turned off for optimalization

func _process(delta): #is called every frame
	if Input.is_action_just_pressed("interact"): #after pressing F
		if get_parent().name != "Player": #is player not the current parent?
			reparent(player) #change current parent to player
			position = Vector2(0, -16) #set position
			interaction_text.visible = false #set text to invisible
			substance_name_text.visible = false #set text to invisible
		else: #player IS the parent
			reparent(get_tree().root) #change parent to root of the tree


func _on_body_entered(body): #if player collides with substance
	interaction_text.visible = true #set text to visible
	substance_name_text.visible = true #set text to visible
	player = body #player is now saved into player variable
	set_process(true) #process is turned on

func _on_body_exited(body): #player is no longer colliding with substance
	if get_parent().name == "Player":
		set_process(false) #turn process off
	interaction_text.visible = false #set text to invisible
	substance_name_text.visible = false #set text to invisible

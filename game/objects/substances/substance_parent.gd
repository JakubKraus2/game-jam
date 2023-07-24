extends Area2D
class_name Substance


var player
@export var substance_name = "test"
@onready var interaction_text = $Label
@onready var substance_name_text = $Label2
@onready var animation_player = $AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var collision_checker = $Area2D
@onready var sprite = $Sprite2D


func _ready():
	add_to_group("substances")
	interaction_text.visible = false #set text to invisible
	substance_name_text.visible = false #set text to invisible
	interaction_text.text = "[" + InputMap.action_get_events("interact")[0].as_text() + "]" #set text to interaction
	substance_name_text.text = substance_name #set text to sbbstance name
	set_process(false) #process is turned off for optimalization

func _process(delta): #is called every frame
	if Input.is_action_just_pressed("interact"): #after pressing F
		if get_parent().name != "Player" && !animation_player.is_playing(): #is player not the current parent?
			reparent(player) #change current parent to player
			player.can_pick_up = false
			position = Vector2(0, -16) #set position
			interaction_text.visible = false #set text to invisible
			substance_name_text.visible = false #set text to invisible
			sprite.offset = Vector2(0, 0)
			collision.position = Vector2(0, 0)
			interaction_text.position = Vector2(0, 0)
			substance_name_text.position = Vector2(0, 0)
#			animation_player.stop()
			collision_checker.set_deferred("monitorable", false)
		else: #player IS the parent
			reparent(get_tree().root) #change parent to root of the tree
			player.can_pick_up = true
			animation_player.play("fall")
			collision_checker.set_deferred("monitorable", true)


func _on_body_entered(body): #if player collides with substance
	interaction_text.visible = true #set text to visible
	substance_name_text.visible = true #set text to visible
	player = body #player is now saved into player variable
	if collision_checker.has_overlapping_areas():
		for i in collision_checker.get_overlapping_areas():
			i.get_parent().set_process(false)
	if player.can_pick_up == true:
		set_process(true) #process is turned on

func _on_body_exited(body): #player is no longer colliding with substance
	interaction_text.visible = false #set text to invisible
	substance_name_text.visible = false #set text to invisible
	await get_tree().create_timer(0.01).timeout
	if get_parent().name != "Player":
		set_process(false)

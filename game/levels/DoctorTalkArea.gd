extends Area2D



var player
@onready var dialogue_player = $"../DialoguePlayer"


func _ready():
	PseudoLoading.get_node("AnimationPlayer").play("load")
	set_process(false)
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Talk"
	$Label.visible = false
	$Label2.visible = false

func _process(delta):
	if Input.is_action_just_pressed("put"):
		dialogue_player.play()
		$Label.visible = false
		$Label2.visible = false
		set_process(false)

func _on_body_entered(body):
	player = body
	$Label.visible = true
	$Label2.visible = true
	set_process(true)

func _on_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)


func _on_level_tutorial_child_exiting_tree(node):
	if node == dialogue_player:
		$"../AnimationPlayer".play("spawn_tables")
		queue_free()

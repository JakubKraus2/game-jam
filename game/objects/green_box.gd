extends StaticBody2D


var player
var found = false
var hidden_substance = load("res://game/objects/substances/substance.tscn")
@export var hidden_substance_name = "Test"
@export var hidden_substance_color = Color(1, 1, 1, 1)


func _ready():
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use Screw Driver"
	$Label.visible = false
	$Label2.visible = false
	$Sprites.visible = false
	$CollisionShape2D.disabled = true
	set_process(false)

func _process(delta):
	if Input.is_action_pressed("put"):
		if $Sprites.visible == false:
			for i in player.get_children():
				if i.name == "ScrewDriver":
					$Sprites.visible = true
					$Label.visible = false
					$Label2.visible = false
					$CollisionShape2D.disabled = false
					var hidden_substance_instance = hidden_substance.instantiate()
					add_child(hidden_substance_instance)
					hidden_substance_instance.substance_name = hidden_substance_name
					hidden_substance_instance.substance_color = hidden_substance_color
					hidden_substance_instance.insides.set_self_modulate(hidden_substance_color)
		else:
			set_process(false)


func _on_area_2d_body_entered(body):
	player = body
	if found == true:
		for i in player.get_children():
			if i.name == "ScrewDriver" && $Sprites.visible == false:
				$Label.visible = true
				$Label2.visible = true
				set_process(true)

func _on_area_2d_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

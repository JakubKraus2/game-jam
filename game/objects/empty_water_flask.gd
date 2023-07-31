extends Node2D



var generated_substance = load("res://game/objects/substances/substance.tscn")
var towel
@export var generated_substance_name = "Dirty Water"
@export var generated_substance_color = Color(1, 1, 1, 1)


func _ready():
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use Towel"
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("put"):
		if towel.name == "Towel" && towel.is_used == true && towel.get_parent().name == "Player":
			towel.get_node("Sprite2D").set_modulate(Color(1, 1, 1, 1))
			towel.get_node("SpriteIdle").set_modulate(Color(1, 1, 1, 1))
			towel.is_used = false
			generate_substance()


func generate_substance():
	var generated_substance_instance = generated_substance.instantiate()
	get_parent().add_child(generated_substance_instance)
	generated_substance_instance.global_position = global_position
	generated_substance_instance.substance_name = generated_substance_name
	generated_substance_instance.substance_color = generated_substance_color
	generated_substance_instance._ready()
	queue_free()


func _on_area_entered(area):
	towel = area
	if area.name == "Towel" && towel.is_used == true && towel.get_parent().name == "Player":
		$Label.visible = true
		$Label2.visible = true
		set_process(true)

func _on_area_exited(area):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

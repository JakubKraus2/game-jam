extends Node2D



var generated_substance = load("res://game/objects/substances/substance.tscn")
var flower
var generated_substance_name = "Flower Powder"


func _ready():
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use Mortar"
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("put"):
		if flower.is_in_group("flowers") && flower.get_parent().name == "Player":
			generate_substance()
			flower.queue_free()


func generate_substance():
	var generated_substance_instance = generated_substance.instantiate()
	get_parent().add_child(generated_substance_instance)
	generated_substance_instance.global_position = global_position
	generated_substance_instance.global_position.x = global_position.x-24
	if flower.is_poisonous == false:
		generated_substance_instance.substance_name = generated_substance_name
	else:
		generated_substance_instance.substance_name = generated_substance_name + " "
	generated_substance_instance.substance_color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), randf_range(0.3, 1))
	generated_substance_instance._ready()


func _on_area_entered(area):
	flower = area
	if area.is_in_group("flowers") && flower.get_parent().name == "Player":
		$Label.visible = true
		$Label2.visible = true
		set_process(true)

func _on_area_exited(area):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

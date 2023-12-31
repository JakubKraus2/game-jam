extends Pickable



var flower_name:String = ""
var is_poisonous = true
var leaf_num = 1
var generate_random



func _on_ready():
	generate_flower()

func _process(delta):
	check_for_areas()
	if Input.is_action_just_pressed("interact"):
		if get_parent().name != "Player":
			reparent(player)
			position = Vector2(0, -20)
			$Label.visible = false
			$Label2.visible = false
			$AreaChecker.set_deferred("monitorable", false)
		else:
			reparent(get_parent().owner)
			$AreaChecker.set_deferred("monitorable", true)


func generate_flower():
	generate_random = randi_range(0, 8)
	match generate_random:
		0:
			flower_name = "Oleander"
			is_poisonous = false
			leaf_num = 4
		1:
			flower_name = "Datura"
			is_poisonous = true
			leaf_num = 4
		2:
			flower_name = "Hydrangea"
			is_poisonous = true
			leaf_num = 6
		3:
			flower_name = "Zephia"
			is_poisonous = true
			leaf_num = 6
		4:
			flower_name = "Purpura"
			is_poisonous = false
			leaf_num = 4
		5:
			flower_name = "Zorra"
			is_poisonous = true
			leaf_num = 7
		6:
			flower_name = "Fluvia"
			is_poisonous = false
			leaf_num = 7
		7:
			flower_name = "Celestella"
			is_poisonous = true
			leaf_num = 1
		8:
			flower_name = "Aconite"
			is_poisonous = true
			leaf_num = 9
	$SpriteIdle.texture = load("res://assets/objects/flowers/flower" + str(generate_random+1) + ".png")
	$Sprite2D.texture = load("res://assets/objects/flowers/flower" + str(generate_random+1) + ".png")
	$Label2.text = str(flower_name)

func _physics_process(delta):
	pass

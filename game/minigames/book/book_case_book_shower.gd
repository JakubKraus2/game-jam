extends StaticBody2D



var player
var playing_mini_game = false
@export var book = load("res://game/objects/flowers/poison_flower_book.tscn")


func _ready():
	$Label.text = "[" + InputMap.action_get_events("put")[0].as_text() + "]"
	$Label2.text = "Use"
	$Label.visible = false
	$Label2.visible = false
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("put") && playing_mini_game == false:
		playing_mini_game = true
		$Label.visible = false
		$Label2.visible = false
		var book_instance = book.instantiate()
		add_child(book_instance)


func _on_area_2d_body_entered(body):
	player = body
	$Label.visible = true
	$Label2.visible = true
	set_process(true)

func _on_area_2d_body_exited(body):
	$Label.visible = false
	$Label2.visible = false
	set_process(false)


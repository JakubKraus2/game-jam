extends CanvasLayer


@export_file("*.json") var dialogue_file
@export var player = Node2D

var dialogues = []
var current_dialogue_index = 0
var is_active = false

var display = ""
var current_char = 0


func _ready():
	$NinePatchRect.visible = false

func _process(delta):
	$NinePatchRect/Text.text = display

func _input(event):
	if !is_active:
		return
	if event.is_pressed() && current_char >= len(dialogues[current_dialogue_index]["text"]):
		next_line()


func play():
	if is_active:
		return
	player.can_move = false
	dialogues = load_dialogues()
	is_active = true
	$NinePatchRect.visible = true
	current_dialogue_index -= 1
	$CharTimer.start()
	next_line()

func next_line():
	display = ""
	current_char = 0
	current_dialogue_index += 1
	if current_dialogue_index >= len(dialogues):
		queue_free()
		player.can_move = true
		return

func load_dialogues():
	if FileAccess.file_exists(dialogue_file):
		FileAccess.open(dialogue_file, FileAccess.READ)
		return JSON.parse_string(FileAccess.get_file_as_string(dialogue_file))


func _on_char_timer_timeout():
	if is_active && current_char < len(dialogues[current_dialogue_index]["text"]):
		display += dialogues[current_dialogue_index]["text"][current_char]
		current_char += 1

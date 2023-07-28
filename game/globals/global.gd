extends Node


const SAVE_PATH = "user://save_file.save"
var data = {}

var level = 1
var current_level = 1


func _ready():
	load_data()
	level = data.level

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(data)
	file.close()

func load_data():
	if !FileAccess.file_exists(SAVE_PATH):
		data = {
			"level": level
		}
		save_data()
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	data = file.get_var()
	file.close()

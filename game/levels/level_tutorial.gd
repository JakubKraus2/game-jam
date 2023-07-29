extends LevelParent



var correct_substances = {"Gulas": 0.0, "Svickova": 0.0, "Ryze": 0.0}
var correct_percentage = {"Gulas": 30.0, "Svickova": 60.0, "Ryze": 40.0}

@onready var dialogue_player = $DialoguePlayerMinigame
var already_played = false


func _on_mixing_table_child_entered_tree(node):
	if $MixingTable.playing_mini_game && already_played == false:
		dialogue_player.play()
		already_played = true

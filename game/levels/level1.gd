extends LevelParent



var correct_substances = {"Cerna": 0.0, "Modra": 0.0, "Zluta": 0.0}
var correct_percentage = {"Cerna": 15.0, "Modra": 50.0, "Zluta": 35.0}




func _on_ready():
	var box_random_position = randi_range(0, 2)
	match box_random_position:
		0:
			$GreenBox.position = Vector2(randi_range(-585, -390), randi_range(310, 210))
		1:
			$GreenBox.position = Vector2(randi_range(-245, -80), randi_range(310, 210))
		2:
			$GreenBox.position = Vector2(randi_range(400, 530), randi_range(310, 210))
	print($GreenBox.position)

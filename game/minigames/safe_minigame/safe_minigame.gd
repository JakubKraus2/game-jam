extends LevelParent



var typed_code = []



func check_typed_code():
	$Code.text = ""
	for i in typed_code:
		$Code.text += str(i)
	if typed_code.size() >= 3:
		for i in $HBoxContainer/VBoxContainer.get_child_count():
			$HBoxContainer/VBoxContainer.get_child(i).disabled = true
			$HBoxContainer/VBoxContainer2.get_child(i).disabled = true
			$HBoxContainer/VBoxContainer3.get_child(i).disabled = true
		await get_tree().create_timer(0.5).timeout
		if typed_code == get_parent().correct_code:
			queue_free()
			get_parent().already_played = true
			get_parent().generate_substance()
		else:
			typed_code.clear()
			$Code.text = ""
		for i in $HBoxContainer/VBoxContainer.get_child_count():
			$HBoxContainer/VBoxContainer.get_child(i).disabled = false
			$HBoxContainer/VBoxContainer2.get_child(i).disabled = false
			$HBoxContainer/VBoxContainer3.get_child(i).disabled = false


func _on_button_1_pressed():
	typed_code.append(1)
	check_typed_code()

func _on_button_2_pressed():
	typed_code.append(2)
	check_typed_code()

func _on_button_3_pressed():
	typed_code.append(3)
	check_typed_code()

func _on_button_4_pressed():
	typed_code.append(4)
	check_typed_code()

func _on_button_5_pressed():
	typed_code.append(5)
	check_typed_code()

func _on_button_6_pressed():
	typed_code.append(6)
	check_typed_code()

func _on_button_7_pressed():
	typed_code.append(7)
	check_typed_code()

func _on_button_8_pressed():
	typed_code.append(8)
	check_typed_code()

func _on_button_9_pressed():
	typed_code.append(9)
	check_typed_code()

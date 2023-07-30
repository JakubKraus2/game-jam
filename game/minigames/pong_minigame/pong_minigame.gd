extends LevelParent



var hidden_substance = load("res://game/objects/substances/substance.tscn")
var player_score = 0
var enemy_score = 0
@export var ball = Node2D


func _on_ready():
	reset_ball()
	$HBoxContainer/PlayerScore.text = str(player_score)
	$HBoxContainer/EnemyScore.text = str(enemy_score)
	get_parent().player.set_physics_process(false)


func reset_ball():
	if player_score < 3 && enemy_score < 3:
		ball.can_move = false
		ball.global_position = Vector2(320, 180)
		$AnimationPlayer.play("cound_down")
		await $AnimationPlayer.animation_finished
		ball.can_move = true

func check_results():
	if player_score >= 3:
		$AnimationPlayer.play("win")
		get_parent().already_played = true
		get_parent().get_node("Computer").texture = load("res://assets/objects/computer_opened.png")
		get_parent().playing_mini_game = false
		await $AnimationPlayer.animation_finished
		queue_free()
		get_parent().player.set_physics_process(true)
		show_hidden_substance()
	if enemy_score >= 3:
		$AnimationPlayer.play("lost")
		get_parent().playing_mini_game = false
		await $AnimationPlayer.animation_finished
		queue_free()
		get_parent().player.set_physics_process(true)


func show_hidden_substance():
	var hidden_substance_instance = hidden_substance.instantiate()
	get_parent().add_child(hidden_substance_instance)
	hidden_substance_instance.position = Vector2(44, 12)
	hidden_substance_instance.substance_name = get_parent().hidden_substance_name
	hidden_substance_instance.substance_color = get_parent().hidden_substance_color
	hidden_substance_instance.insides.set_self_modulate(get_parent().hidden_substance_color)
	

func _on_border_body_entered(body):
	body.direction.y *= -1


func _on_win_area_body_entered(body):
	player_score += 1
	$HBoxContainer/PlayerScore.text = str(player_score)
	check_results()
	reset_ball()

func _on_lose_area_body_entered(body):
	enemy_score += 1
	$HBoxContainer/EnemyScore.text = str(enemy_score)
	check_results()
	reset_ball()

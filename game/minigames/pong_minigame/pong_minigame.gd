extends LevelParent



var player_score = 0
var enemy_score = 0
@export var ball = Node2D



func _on_ready():
	reset_ball()
	$HBoxContainer/PlayerScore.text = str(player_score)
	$HBoxContainer/EnemyScore.text = str(enemy_score)
#	get_parent().player.set_physics_process(false)


func reset_ball():
	ball.can_move = false
	ball.global_position = Vector2(320, 180)
	$AnimationPlayer.play("cound_down")
	await $AnimationPlayer.animation_finished
	ball.can_move = true


func _on_border_body_entered(body):
	body.direction.y *= -1


func _on_win_area_body_entered(body):
	player_score += 1
	$HBoxContainer/PlayerScore.text = str(player_score)
	reset_ball()

func _on_lose_area_body_entered(body):
	enemy_score += 1
	$HBoxContainer/EnemyScore.text = str(enemy_score)
	reset_ball()

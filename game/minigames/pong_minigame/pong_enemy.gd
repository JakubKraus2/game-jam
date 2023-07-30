extends CharacterBody2D


var speed = 200.0
var can_move = true
@export var ball = Node2D


func _physics_process(delta):
	if can_move:
		var direction = round((ball.global_position - global_position).normalized())
		velocity.y = speed * direction.y
	else:
		velocity.y = 0
	move_and_slide()


func _on_ball_checker_body_entered(body):
	$ReactionTimer.start()
	body.direction.x *= -1

func _on_reaction_timer_timeout():
	if can_move:
		$ReactionTimer.start(randf_range(1.2, 1.4))
	else:
		$ReactionTimer.start(randf_range(1, 2))
	can_move = !can_move

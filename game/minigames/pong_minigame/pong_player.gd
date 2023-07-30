extends CharacterBody2D


const SPEED = 150.0



func _physics_process(delta):
	var direction = Input.get_axis("move_up", "move_down")
	velocity.y = direction * SPEED
	move_and_slide()


func _on_ball_checker_body_entered(body):
	body.direction.x *= -1

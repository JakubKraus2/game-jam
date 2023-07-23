extends CharacterBody2D


var speed := 200.0



func _physics_process(delta):
	movement(delta)


func movement(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = lerp(velocity, speed * direction, pow(2, -40 * delta))
	move_and_slide()

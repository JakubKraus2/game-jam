extends CharacterBody2D


var speed := 200.0
var can_pick_up = true
var can_move = true
var side


func _physics_process(delta):
	movement(delta)


func movement(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	side = direction * speed
	if can_move:
		if side == Vector2.ZERO:
			$AnimationTree.get("parameters/playback").travel("Idle")
		else:
			$AnimationTree.get("parameters/playback").travel("Movement")
			$AnimationTree.set("parameters/Idle/blend_position", side)
			$AnimationTree.set("parameters/Movement/BlendSpace2D/blend_position", side)
		velocity = lerp(velocity, speed * direction, pow(2, -40 * delta))
		move_and_slide()

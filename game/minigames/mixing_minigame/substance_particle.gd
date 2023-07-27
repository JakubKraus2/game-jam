extends RigidBody2D


var substance_particle_name = ""


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

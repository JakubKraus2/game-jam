extends Area2D


func _ready():
	MainCamera.enabled = true


func _on_body_entered(body):
	MainCamera.global_position = get_parent().global_position

extends StaticBody2D




func _on_area_2d_body_entered(body):
	body.call_deferred("reparent", self)

extends Ball


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(_direction * speed * delta)
	
	if collision:
		var body: Object = collision.get_collider()
		if body is Paddle:
			set_player(body.player_binding.player_data)
		
		_direction = _get_random_direction()

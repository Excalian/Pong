extends Ball


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(_direction * speed * delta)
	
	if collision:
		var body: Object = collision.get_collider()
		if body is Paddle:
			set_owned_player(body.paddle_binding.player_data)
			speed_increase_rate = min(speed_increase_rate * 1.2, SPEED_INCREASE_LIMIT)
			_bounces_not_on_paddle = 0
		else:
			_bounces_not_on_paddle += 1
		speed = min(speed + speed_increase_rate, SPEED_LIMIT)
		
		if _bounces_not_on_paddle > 2:
			_direction = _get_random_direction()
		else:
			_direction = _direction.bounce(collision.get_normal())

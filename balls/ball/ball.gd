extends CharacterBody2D
class_name Ball


const speed_limit := 400
const speed_increase_limit := 10

@export_range(0, speed_limit) var speed := 50
@export_range(0, speed_limit) var speed_increase_rate := 2

var entered_goal := false

var _owned_player := PlayerData.new()
var _direction := _get_random_direction()


func _physics_process(delta) -> void:
	var collision := move_and_collide(_direction * speed * delta)
	
	if collision:
		var body = collision.get_collider()
		if body is Paddle:
			set_player(body.player_binding.player_data)
			speed_increase_rate = min(speed_increase_rate * 1.2, speed_increase_limit)
		speed = min(speed + speed_increase_rate, speed_limit)
		
		_direction = _direction.bounce(collision.get_normal())


func _get_random_direction() -> Vector2:
	return Vector2(1, randf_range(-0.5, 0.5)).normalized()


func set_player(player: PlayerData) -> void:
	_owned_player = player
	modulate = player.paddle_color

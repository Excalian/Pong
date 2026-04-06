extends CharacterBody2D
class_name Ball


const SPEED_LIMIT: int = 400
const SPEED_INCREASE_LIMIT: int = 10

@export_range(0, SPEED_LIMIT) var speed: int = 50
@export_range(0, SPEED_LIMIT) var speed_increase_rate: int = 2

var entered_goal: bool= false

var _bounces_not_on_paddle: int = 0
var _direction: Vector2 = _get_random_direction()


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(_direction * speed * delta)
	
	if collision:
		var body: Object = collision.get_collider()
		if body is Paddle:
			speed_increase_rate = min(speed_increase_rate * 1.2, SPEED_INCREASE_LIMIT)
			_bounces_not_on_paddle = 0
		else:
			_bounces_not_on_paddle += 1
		speed = min(speed + speed_increase_rate, SPEED_LIMIT)
		
		if _bounces_not_on_paddle > 2:
			_direction = _get_random_direction()
		else:
			_direction = _direction.bounce(collision.get_normal())


func _get_random_direction() -> Vector2:
	var x: int = [-1, 1].pick_random()
	var y: float = randf_range(-1.0, 1.0)
	return Vector2(x, y).normalized()

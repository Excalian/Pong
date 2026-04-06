extends CharacterBody2D
class_name Paddle

const AI_REACTIVITY: int = 900
const AI_DEADZONE: float = 15.0

@export var ball_system: BallSystem
@export var goal_system: GoalSystem
@export var paddle_binding: PaddleBinding
@export var speed: float = 50.0


func _physics_process(delta: float) -> void:
	var target_direction: float = 0.0
	
	if paddle_binding.is_ai:
		target_direction = _get_ai_direction()
	else:
		target_direction = _get_direction()
	
	if target_direction == 0:
		velocity.y = move_toward(velocity.y, 0, AI_REACTIVITY * delta)
	else:
		velocity.y = move_toward(velocity.y, target_direction * speed, AI_REACTIVITY * delta)
	
	if abs(velocity.y) < 1:
		velocity.y = 0
	
	move_and_slide()


func _get_direction() -> float:
	if Input.is_action_pressed(paddle_binding.up_key):
		return -1
	if Input.is_action_pressed(paddle_binding.down_key):
		return 1
	return 0


func _get_ai_direction() -> float:
	var ball: Ball = ball_system.current_ball

	var distance: float = ball.position.y - position.y
	if abs(distance) < AI_DEADZONE:
		return 0
	
	return sign(distance)

extends CharacterBody2D
class_name Paddle

const AI_REACTIVITY: int = 900
const AI_DEADZONE: float = 15.0

@export var ball_system: BallSystem
@export var goal_system: GoalSystem
@export var paddle_binding: PaddleBinding
@export var speed: float = 50.0
@export var flash_shader: Shader

@onready var paddle_color: Color = paddle_binding.player_data.paddle_color
@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite_material: ShaderMaterial = ShaderMaterial.new()

var current_tween: Tween


func _ready() -> void:
	modulate = paddle_color
	goal_system.player_won.connect(_on_player_won)
	
	sprite_material.shader = flash_shader
	sprite_material.set_shader_parameter("flash_strength", 0.0)
	sprite.material = sprite_material

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


func _on_player_won(_ball: Ball, player: PlayerData) -> void:
	if player != paddle_binding.player_data:
		return
	
	flash()


func flash() -> void:
	if current_tween:
		current_tween.kill()
	
	current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_QUAD)
	
	current_tween.tween_property(sprite_material, "shader_parameter/flash_strength", 1.0, 0.05)
	current_tween.tween_property(sprite_material, "shader_parameter/flash_strength", 0.6, 0.08)
	current_tween.tween_property(sprite_material, "shader_parameter/flash_strength", 0.0, 0.35)


func _get_direction() -> float:
	if Input.is_action_pressed(paddle_binding.up_key):
		return -1
	if Input.is_action_pressed(paddle_binding.down_key):
		return 1
	return 0


func _get_ai_direction() -> float:
	var active_balls: Array[Ball] = ball_system.active_balls
	if active_balls.is_empty():
		return 0

	var closest_ball: Ball = null
	var closest_distance: float = INF

	for ball: Ball in active_balls:
		var distance: float = abs(ball.position.x - position.x)
		if distance < closest_distance:
			closest_distance = distance
			closest_ball = ball

	var y_distance: float = closest_ball.position.y - position.y
	if abs(y_distance) < AI_DEADZONE:
		return 0
	
	return sign(y_distance)

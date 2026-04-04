extends CharacterBody2D
class_name Paddle

@export var player_binding: PlayerBinding
@export var speed: float = 50.0

func _ready() -> void:
	modulate = player_binding.player_data.paddle_color

func _physics_process(_delta) -> void:
	var dir := 0.0
	
	if Input.is_action_pressed(player_binding.up_key):
		dir -= 1
	if Input.is_action_pressed(player_binding.down_key):
		dir += 1
	
	velocity = Vector2(0, dir * speed)
	move_and_slide()

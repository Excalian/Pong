extends Node2D
class_name BallSystem


@export var goal_system: GoalSystem
@export var ball: PackedScene

@onready var default_ball_spawn_position: Vector2 = get_viewport().get_visible_rect().size / 2

var current_ball: Ball


func _ready() -> void:
	goal_system.player_won.connect(_on_player_won)
	spawn_ball()


func _on_player_won(ball_instance: Ball, _player: PlayerData) -> void:
	ball_instance.queue_free()
	call_deferred("spawn_ball")


func spawn_ball(ball_position: Vector2 = default_ball_spawn_position) -> void:
	var ball_instance: Ball = ball.instantiate()
	ball_instance.position = ball_position
	
	add_child(ball_instance)
	current_ball = ball_instance
	

extends Node2D
class_name BallSystem


@export var goal_system: GoalSystem
@export var balls: Dictionary[String, PackedScene] = {}

@onready var default_ball_spawn_position: Vector2 = get_viewport().get_visible_rect().size / 2


func _ready() -> void:
	goal_system.player_won.connect(_on_player_won)
	spawn_ball()


func _on_player_won(ball: Ball, _player: PlayerData):
	ball.queue_free()
	call_deferred("spawn_ball", _get_random_ball_name())


func _get_random_ball_name() -> String:
	var random_ball_name: String = "_"
	
	while random_ball_name[0] == "_":
		random_ball_name = balls.keys().pick_random()
	
	return random_ball_name


func spawn_ball(ball_name: String = "ball", ball_position: Vector2 = default_ball_spawn_position) -> void:
	if not ball_name in balls:
		push_error("You provide an incorrect ball name to \"spawn_ball\"")
	
	var ball: Ball = balls[ball_name].instantiate()
	ball.position = ball_position
	
	add_child(ball)

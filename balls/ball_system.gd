extends Node2D
class_name BallSystem


@export var goal_system: GoalSystem
@export_dir var ball_data_path: String

var balls: Dictionary[String, BallData] = {}
var active_balls: Array[Ball] = []

@onready var default_ball_spawn_position: Vector2 = get_viewport().get_visible_rect().size / 2


func _ready() -> void:
	_load_ball_data()
	goal_system.player_won.connect(_on_player_won)
	spawn_ball(balls.values()[0])


func _on_player_won(ball: Ball, _player: PlayerData) -> void:
	active_balls.erase(ball)
	ball.queue_free()
	call_deferred("spawn_ball", _get_weighted_random_ball())


func _load_ball_data() -> void:
	"Opens all of the BallData resources in a folder, and puts them into the balls dictionary"
	var directory: DirAccess = DirAccess.open(ball_data_path)
	if not directory:
		push_error("Cannot open " + ball_data_path)
		return
	
	directory.set_include_hidden(false)
	directory.set_include_navigational(false)
	
	directory.list_dir_begin()
	var filename: String = directory.get_next()
	while filename != "":
		if filename.ends_with(".tres"):
			var path: String = ball_data_path + filename
			var data: BallData = load(path)
			if data:
				balls[filename.get_basename()] = data
		filename = directory.get_next()


func _get_weighted_random_ball() -> BallData:
	"Use the weights on the ball_data to randomly select a ball"
	var total_weight: float = 0.0
	for ball_data: BallData in balls.values():
		total_weight += ball_data.weight

	var random: float = randf() * total_weight
	for ball_data: BallData in balls.values():
		random -= ball_data.weight
		if random <= 0:
			return ball_data
	return balls.values()[0]


func spawn_ball(ball_data: BallData, ball_position: Vector2 = default_ball_spawn_position) -> void:
	"Spawn whichever ball you want, wherever you want"
	var ball: Ball = ball_data.scene.instantiate()
	ball.position = ball_position
	
	add_child(ball)
	active_balls.append(ball)
	

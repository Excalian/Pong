extends Area2D
class_name Goal


@export var points_to_give: int = 1
@export var player: PlayerData
@export var flash_shader: Shader

@onready var goal_system: GoalSystem = get_parent()

var current_tween: Tween


func _ready() -> void:
	var rect: ColorRect = ColorRect.new()
	var rect_size: Vector2 = $CollisionShape2D.shape.size
	rect.color = player.color
	rect.position = rect_size / -2
	rect.size = rect_size

	add_child(rect)
	goal_system.player_won.connect(_on_player_won)


func _on_player_won(_ball: Ball, this_player: PlayerData) -> void:
	if this_player != player:
		return
	flash()


func flash() -> void:
	if current_tween:
		current_tween.kill()
	
	current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_QUAD)
	
	current_tween.tween_property(self, "modulate", Color.BLACK, 0.05)
	current_tween.tween_property(self, "modulate", player.color, 0.35)

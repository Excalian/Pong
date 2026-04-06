extends Label
class_name ScoreDisplay


@export var player: PlayerData


func _ready() -> void:
	text = str(player.score)
	resized.connect(_on_resized)
	_on_resized()


func _on_pause_menu_opened() -> void:
	text = str(player.score)


func _on_resized() -> void:
	var new_size: float = size.y * 0.6
	add_theme_font_size_override("font_size", int(new_size))

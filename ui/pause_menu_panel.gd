extends Panel


@export var left_display: ScoreDisplay
@export var right_display: ScoreDisplay

@export var red: StyleBoxFlat
@export var pink: StyleBoxFlat
@export var blue: StyleBoxFlat

var right_score: int = 0
var left_score: int = 0


func _ready() -> void:
	add_theme_stylebox_override("panel", pink)
	left_display.score_changed.connect(_on_left_score_changed)
	right_display.score_changed.connect(_on_right_score_changed)


func compare_scores() -> void:
	if right_score > left_score:
		add_theme_stylebox_override("panel", blue)
	elif left_score > right_score:
		add_theme_stylebox_override("panel", red)
	else:
		add_theme_stylebox_override("panel", pink)


func _on_left_score_changed(score: int) -> void:
	left_score = score
	compare_scores()


func _on_right_score_changed(score: int) -> void:
	right_score = score
	compare_scores()

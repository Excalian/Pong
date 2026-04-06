extends CanvasLayer
class_name PauseMenu


func _ready() -> void:
	visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if not get_tree().paused:
			open()
		else:
			close()


func open() -> void:
	get_tree().paused = true
	visible = true



func close() -> void:
	visible = false
	get_tree().paused = false

extends Area2D
class_name Goal


@export var points_to_give: int = 1

func _ready() -> void:
	var rect_size: Vector2 = $CollisionShape2D.shape.size 
	var rect: ColorRect = ColorRect.new()
	rect.color = Color.WHITE.darkened(0.95)
	rect.position = rect_size / -2
	rect.size = rect_size

	add_child(rect)

extends SubViewportContainer

@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	_resize_ui_viewport_container()
	sub_viewport.size_changed.connect(_resize_ui_viewport_container)

func _resize_ui_viewport_container() -> void:
	size = get_viewport().get_visible_rect().size

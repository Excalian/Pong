extends Button

@export var help_menu: PanelContainer


func _ready() -> void:
	help_menu.visible = false
	pressed.connect(_button_pressed)


func _button_pressed() -> void:
	help_menu.visible = not help_menu.visible

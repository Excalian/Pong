"""
Specifies (and allows the storage) of player's data
"""


extends Resource
class_name PlayerData


@export var name: String = "No One"
@export var score: int = 0
@export_color_no_alpha var paddle_color: Color = Color.WHITE

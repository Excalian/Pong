extends Node2D
class_name GoalSystem

signal player_won(ball: Ball, player: PlayerData)




func on_player_win(body: Node2D, goal: Goal) -> void:
	if not body is Ball:
		return
	
	if body.entered_goal:
		return
	body.entered_goal = true
	
	var player: PlayerData = body._owned_player
	player.score += goal.points_to_give
	print(player.name, ": ", player.score)
	
	player_won.emit(body, player)


func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			child.body_entered.connect(on_player_win.bind(child))

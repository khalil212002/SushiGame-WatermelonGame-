extends Node

var maxLevel = 0
var score = 0
var labelNode:Label

func _update_score(pointsToAdd):
	score += pointsToAdd
	labelNode.text = str(score)

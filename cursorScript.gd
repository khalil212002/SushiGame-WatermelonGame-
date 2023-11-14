extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _drop_ball():
	var ball = preload("res://ball.tscn").instantiate()
	ball.global_position = global_position
	get_owner().add_child(ball)

var dragging = false
func _input(event):
	if(event is InputEventScreenTouch):
		if(event.pressed):
			dragging = true
		else:
			if(dragging):
				_drop_ball()
			dragging = false
			
	elif(event is InputEventMouseButton):
		if(event.pressed):
			_drop_ball()
		
	if(event is InputEventMouseMotion):
		var ball = get_node("Sprite2D")
		var leftBoundary = (35 + ball.texture.get_width() * ball.scale.x / 2)
		var rightBoundary =  (720 - 35 - (ball.texture.get_width() * ball.scale.x / 2))
		
		if(event.position.x >= leftBoundary and event.position.x <= rightBoundary):
			global_position.x = event.position.x
		elif(event.position.x < leftBoundary):
			global_position.x = leftBoundary
		else:
			global_position.x = rightBoundary

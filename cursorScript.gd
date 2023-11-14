extends Node2D

var rayCast:RayCast2D
var line2d:Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	rayCast = get_node("RayCast2D")
	line2d = get_node("Line2D")
	line2d.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dragging):
		line2d.points[1].y = rayCast.get_collision_point().y - global_position.y

func _drop_ball():
	var ball = preload("res://ball.tscn").instantiate()
	ball.global_position = global_position
	get_owner().add_child(ball)

var dragging = false
func _input(event):
	if(event is InputEventScreenTouch or event is InputEventMouseButton):
		if(event.pressed):
			dragging = true
			line2d.show()
		else:
			if(dragging):
				_drop_ball()
			dragging = false
			line2d.hide()
		
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

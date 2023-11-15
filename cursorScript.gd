extends Node2D

var rayCast:RayCast2D
var line2d:Line2D

var leftBoundary:float
var rightBoundary:float
var hasBallChild = true

# Called when the node enters the scene tree for the first time.
func _ready():
	rayCast = get_node("RayCast2D")
	line2d = get_node("Line2D")
	line2d.hide()
	_calculate_boundaries()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dragging):
		line2d.points[1].y = rayCast.get_collision_point().y - global_position.y
		
func _calculate_boundaries():
	var ball = get_node("RigidBody2D/CollisionShape2D/Sprite2D")
	var ballCollision = get_node("RigidBody2D/CollisionShape2D")
	leftBoundary = (35 + ball.texture.get_width() * ballCollision.scale.x / 2)
	rightBoundary =  (720 - 35 - (ball.texture.get_width() * ballCollision.scale.x / 2))

func _drop_ball():
	var ball = get_node("RigidBody2D")
	var globalPos = ball.global_position
	ball.get_parent().remove_child(ball)
	ball.global_position = globalPos
	get_owner().add_child(ball)
	ball.freeze = false
	hasBallChild = false

var dragging = false
func _input(event):
	if(hasBallChild and (event is InputEventScreenTouch or event is InputEventMouseButton)):
		if(event.pressed):
			dragging = true
			line2d.show()
		else:
			if(dragging):
				_drop_ball()
			dragging = false
			line2d.hide()
		
	if(event is InputEventMouseMotion):		
		if(event.position.x >= leftBoundary and event.position.x <= rightBoundary):
			global_position.x = event.position.x
		elif(event.position.x < leftBoundary):
			global_position.x = leftBoundary
		else:
			global_position.x = rightBoundary

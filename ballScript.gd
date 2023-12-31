extends RigidBody2D

const areaSize = 5
const growSize = 1.5
const numberOfImages = 6
const ballStartScale = 0.1

var alive = true
var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_area_collision()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _grow():
	Globals._update_score((level + 1) * 10)
	
	if(level < numberOfImages - 1):
		level += 1
		get_node("CollisionShape2D/Sprite2D").texture = load(Globals.imageName + str(level) + Globals.imageFormat)
		get_node("CollisionShape2D").scale *= growSize
		_update_area_collision()
		mass += 3
	else:
		level = 0
		get_node("CollisionShape2D/Sprite2D").texture = load(Globals.imageName + str(level) + Globals.imageFormat)
		get_node("CollisionShape2D").scale = Vector2.ONE * ballStartScale

		_update_area_collision()
		mass = 1
		
	for coli in get_node("Area2D").get_overlapping_areas():
		_on_area_2d_area_entered(coli)
	
func _update_area_collision():
	var areaCollision = get_node("Area2D/CollisionShape2D")
	var sprite = get_node("CollisionShape2D/Sprite2D")
	var spriteCollision = get_node("CollisionShape2D")
	
	var newShape = CircleShape2D.new()
	newShape.radius = sprite.texture.get_width() * spriteCollision.scale.y / 2 + areaSize
	areaCollision.shape = newShape

func _kill():
	alive = false
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _on_area_2d_area_entered(area):
	var other = area.get_owner()
	if(alive and other.get_script().get_path() == "res://ballScript.gd" and other.level == level):
		other._kill()
		_grow()
		if(level > Globals.maxLevel):
			Globals.maxLevel = level


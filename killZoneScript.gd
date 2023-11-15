extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _check_still_in(area:Area2D, timer:Timer):
	remove_child(timer)
	if(area in get_overlapping_areas()):
		print_debug("Game Over")

func _on_area_entered(area):
	var timer = Timer.new()
	timer.connect("timeout", _check_still_in.bind(area, timer))
	timer.one_shot = true
	timer.wait_time = 2
	add_child(timer)
	timer.start()

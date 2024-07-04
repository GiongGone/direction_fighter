extends RigidBody2D

var speed = 1
var max_range = 1

func _ready():
	$gun.play()

func _process(_delta):
	var range = Vector2(0, -2) * speed * max_range
	speed += 0.1
	global_position += range
	if speed > 6:
		max_range -= 0.1
	if speed > 8: # This is a bug fighter, for creep values
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(_body):
	print("Finally")
	queue_free()


func _on_body_entered(body): # Something is wrong with the mask; I can't get this to work
	print("I feel something..!")

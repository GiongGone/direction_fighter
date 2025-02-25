extends RigidBody2D

signal sick
var sickness = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sickness < 1:
		sick.emit()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	print("Hit")


func _on_area_2d_area_entered(area):
	sickness -= 1
	print("Hit twice")

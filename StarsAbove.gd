extends TextureRect

var speed = 0
var shift = 0

func _process(delta):
	var velocity = Vector2(1, 0) * speed * shift
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		velocity.x = 0
		position = Vector2(0, 0)
	position += velocity * delta
	velocity.x += 1
	if speed > 150:
		speed = 0
	if shift < -150:
		shift = 0
	print(speed)
	print(shift)


func _on_player_dir_left():
	speed += 50

func _on_player_dir_right():
	shift -= 50

extends Node
@export var mob_scene: PackedScene
@export var war_hit: PackedScene
var score
var b_gain
var hot = 0
signal bang

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$AnimatedSprite2D.play("stars")
	$gun.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		if hot > 0:
			shoot()
		if hot < 0:
			shoot_2()

func game_over():
		$ScoreTimer.stop()
		$MobTimer.stop()
		$Music.stop()
		$DeathSound.play()
		$HUD.show_game_over()

func new_game():
	score = 0
	b_gain = 0
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()
	$HUD.update_score(score)
	$HUD.lap_cab(b_gain)
	$HUD.show_message("Get Ready")

func _on_score_timer_timeout():
	$ScoreTimer.stop()

func _on_start_timer_timeout():
		$MobTimer.start()
		$ScoreTimer.start()

func _on_mob_timer_timeout():
		# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(66.6, 133.2), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	mob.sick.connect(self._get_score.bind())

func _get_score():
	score += 1
	$HUD.update_score(score)

func shoot():
	# Create a new instance of the shoot scene
	var bull = war_hit.instantiate() # Currently is on the top var as "packed scene"
	var bull_shaft = $Player.position + Vector2(7.5, -45)
	bull.set_position(bull_shaft) # Can be the same as below
	add_child(bull)
	hot -= 1
	b_gain += 1
	$HUD.lap_cab(b_gain)
	$gun2.start()
	return "This is the end"
func shoot_2():
	# Create a new instance of the shoot scene
	var bull = war_hit.instantiate() # Currently is on the top var as "packed scene"
	var bull_shaft = $Player.position + Vector2(-7.5, -45)
	bull.set_position(bull_shaft) # Can be the same as above
	add_child(bull)
	hot += 1
	b_gain += 1
	$HUD.lap_cab(b_gain)
	$gun.start()
	return "This is the end"

func _on_gun_timeout():
	hot = 1
	$gun.stop()

func _on_gun_2_timeout():
	hot = -1
	$gun2.stop()

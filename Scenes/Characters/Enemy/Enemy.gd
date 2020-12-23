extends KinematicBody2D

const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1) 
const WALK_SPEED = 80
const STATE_LIVE = 0
const STATE_KILLED = 1

var linear_velosity = Vector2()
var direction = -1
var anim = ""
var state = STATE_LIVE

onready var detect_left_floor = $Raycasts/Detect_left_floor
onready var detect_right_floor = $Raycasts/Detect_right_floor
onready var detect_left_wall = $Raycasts/Detect_left_wall
onready var detect_right_wall = $Raycasts/Detect_right_wall
onready var Body = $Body

func _physics_process(delta):
	var new_anim = ""
	
	if state == STATE_LIVE:
		#print(123)
		linear_velosity += GRAVITY_VEC * delta
		linear_velosity.x = direction * WALK_SPEED
		linear_velosity = move_and_slide(linear_velosity, FLOOR_NORMAL)
		
		if not detect_left_floor.is_colliding() or detect_left_wall.is_colliding():
			direction = 1
		
		if not detect_right_floor.is_colliding() or detect_right_wall.is_colliding():
			direction = -1
		
		Body.scale.x = direction
		new_anim = "walk"
	
	if anim != new_anim:
		anim = new_anim
		$AnimationPlayer.play(anim)

func _on_DamageZone_body_entered(body):
	if body.is_in_group("player"):
		body.damage(25)

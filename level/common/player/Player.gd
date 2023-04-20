extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 30
const JUMP_STEP = 200
const GRAVITY := 10
const FLOOR_NORMAL = Vector2(0, -1)

var motion := Vector2(0, 0)

onready var player = $PlayerSprite

func _physics_process(_delta):
	_handle_motion()
	motion = move_and_slide(motion, FLOOR_NORMAL)
	pass


func _handle_motion():
	_handle_motion_horizontal()
	_handle_motion_vertical()
	_play_animation()
	pass


func _play_animation():
	var anim: String	
	if is_on_floor():
		# not motion.x == 0 because of a `lerp` in `_handle_motion_horizontal`
		anim = "idle" if abs(motion.x) < ACCELERATION / 2.0 else "run"
	else:
		anim = "jump" if motion.y < 0 else "fall"

	if Input.is_action_pressed("ui_left"):
		player.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		player.set_flip_h(false)

	player.play(anim)
	pass


func _handle_motion_vertical():
	motion.y += GRAVITY
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		motion.y = -JUMP_STEP
	pass


func _handle_motion_horizontal():
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	elif Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	else:
		# Idle
		var friction = 0.2 if is_on_floor() else 0.05
		motion.x = lerp(motion.x, 0, friction)
	pass

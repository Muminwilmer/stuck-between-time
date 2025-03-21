extends CharacterBody2D

const WALK_SPEED = 180.0
const RUN_SPEED = 240.0
const JUMP_FORCE = -300.0
const MAX_FALL_SPEED = 400.0
const WALLJUMP_FORCE = -400.0

var hold_time_proj = 0.0
var charging_proj = false
var is_running = false
var is_jumping = false
var is_walljumping = false
var can_dash = true
var is_dashing = false

var dash_speed = 600.0
var dash_length = 0.18
var dash_remain = 0.0

@onready var newtime_map = get_parent().get_node("Newtime")
@onready var oldtime_map = get_parent().get_node("Oldtime")
@onready var projectile = preload("res://Assets/Scenes/ResourceScenes/projectile.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	$Sprite2D.flip_h = velocity.x < 0
	handle_gravity(delta)
	handle_actions(delta)
	handle_animation(delta)
	move_and_slide()

func handle_gravity(delta):
	if not is_on_floor() and not is_dashing:
		velocity.y = min(velocity.y + gravity * delta, MAX_FALL_SPEED)

func handle_actions(delta):
	handle_movement()
	handle_jump()
		
	if is_on_floor():
		is_jumping = false
		is_walljumping = false

func handle_movement():
	if not is_dashing:
		is_running = Input.is_action_pressed("run")
		var direction = Input.get_axis("left", "right")
		
		
		if direction:
			# Apply air factor to reduce movement speed while in the air
			velocity.x = direction * (RUN_SPEED if is_running else WALK_SPEED)
			$Sprite2D.flip_h = direction < 0
			
		elif not is_dashing and not is_walljumping:
			# Smooth deceleration to 0 when not pressing any movement key
			velocity.x = move_toward(velocity.x, 0, (RUN_SPEED if is_running else WALK_SPEED))


func handle_jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE




func handle_animation(delta):
		var direction = Input.get_axis("left", "right")
		if direction != 0:
			$AnimationPlayer.play("Run")
		else:
			$AnimationPlayer.play("Idle")


# Player.gd

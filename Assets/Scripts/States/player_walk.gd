extends State
class_name PlayerWalk

@export var player: CharacterBody2D
@export var move_speed: float = 50.0
@export var RUN_SPEED = 240.0

@export var max_fall_speed: float = 200

var is_running: bool

func enter():
	pass

func physics_update(delta):
	is_running = Input.is_action_pressed("run")
	var direction = Input.get_axis("left", "right")

	if not player.is_dashing:
		if direction:
			var target_speed = RUN_SPEED if is_running else move_speed
			player.velocity.x = direction * target_speed
			
		elif not player.is_walljumping:
			var decel_speed = RUN_SPEED if is_running else move_speed
			player.velocity.x = move_toward(player.velocity.x, 0, decel_speed * delta)

	# Dash input? Transition!
	if Input.is_action_just_pressed("dash") and player.can_dash:
		emit_signal("Transitioned", self, "dash")

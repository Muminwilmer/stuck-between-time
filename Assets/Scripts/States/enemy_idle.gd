extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed: float = 20
@export var jump_speed: float = 800
@export var max_fall_speed: float = 200
@export var gravity: float = 500
@export var collision_infront: RayCast2D
@export var collision_above: RayCast2D

var move_direction: Vector2 = Vector2.ZERO
var direction: int = 1
var is_jumping: bool = false

func Enter():
	move_direction = Vector2(move_speed * direction, 0)
	is_jumping = false

func update(delta):
	if not enemy or not collision_infront or not collision_above:
		return
	
	# Handle gravity only if not on the floor and not jumping
	handle_gravity(delta)

	# Handle obstacle in front
	if collision_infront.is_colliding():
		if collision_above.is_colliding():
			print("Obstacle too high, turning around")
			direction *= -1  # Reverse direction
		else:
			print("Jumping over obstacle")
			move_direction.y = -jump_speed  # Jump
			is_jumping = true  # Flag that we are jumping
			return
	
	# Apply horizontal movement
	move_direction.x = move_speed * direction

func handle_gravity(delta):
	# Apply gravity if the enemy is not on the floor and not jumping
	if not enemy.is_on_floor() and not is_jumping:
		move_direction.y = clamp(move_direction.y + gravity * delta, -INF, max_fall_speed)  # Apply gravity, clamp fall speed
		print("Falling")
	else:
		# Once on the floor, stop jumping and reset the fall velocity
		if is_jumping:
			print("Landed")
			is_jumping = false  # Reset jump state
		move_direction.y = 0  # Stop falling

func physics_update(delta):
	if not enemy:
		return
	
	enemy.scale.x = direction  # Flip sprite
	enemy.velocity = move_direction  # Apply movement

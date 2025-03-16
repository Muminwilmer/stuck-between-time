extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed: float = 50.0

@export var max_fall_speed: float = 200
@export var gravity: float = 500

var direction: int = 1
var last_frame_pos: Vector2

func Enter():
	pass
	
func update(delta):
	if last_frame_pos == enemy.position:
		direction *= -1
	last_frame_pos = enemy.position
	
func physics_update(delta):
	if not enemy:
		return

	# Apply gravity
	if not enemy.is_on_floor():
		enemy.velocity.y = min(enemy.velocity.y + gravity * delta, max_fall_speed)
	else:
		enemy.velocity.y = 0
		
	enemy.velocity.x = direction * move_speed

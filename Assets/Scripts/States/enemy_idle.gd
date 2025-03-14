extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var collision_infront: RayCast2D
@export var collision_above: RayCast2D

@export var move_speed: float = 20
@export var jump_speed: float = 800
@export var max_fall_speed: float = 200
@export var gravity: float = 200


var move_direction: Vector2 = Vector2.ZERO
var direction: int = 1
var is_jumping: bool = false

func Enter():
	print("Entered Idle Mode")

#func update(delta):


func physics_update(delta):
	if not enemy:
		return
		
	if not enemy.is_on_floor():
		move_direction.y = gravity
		
	if collision_infront.is_colliding():
		#print("Collision infront")
		#print(direction)
		if collision_above.is_colliding():
			direction *= -1
		elif enemy.is_on_floor():
			move_direction.y = -jump_speed
	else:
		move_direction.x = move_speed
	enemy.scale.x = direction  # Flip sprite
	enemy.velocity = move_direction  # Apply movement

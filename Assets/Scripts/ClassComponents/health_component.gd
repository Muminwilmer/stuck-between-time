extends Node2D
class_name HealthComponent

signal damage_taken(amount: float, position: Vector2)  # No direct connection
signal died

@export var maxHealth := 20.0
var health : float

func _ready():
	health = maxHealth

func damage(attack: Attack):
	if attack.projectile_owner == get_parent():
		return
	
	health -= attack.attack_damage
	emit_signal("damage_taken", attack.attack_damage, get_parent().global_position) # Broadcast damage

	if health <= 0:
		emit_signal("died")
		get_parent().queue_free()

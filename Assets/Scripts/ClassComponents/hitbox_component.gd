extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var knockback_component : KnockbackComponent

func damage(attack : Attack):
	if health_component:
		health_component.damage(attack)

	if knockback_component:
		knockback_component.knockback(attack)

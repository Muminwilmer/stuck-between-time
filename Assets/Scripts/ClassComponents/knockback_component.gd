extends Node2D
class_name KnockbackComponent

func knockback(attack: Attack):
	var parent = get_parent()
	if parent is CharacterBody2D:
		var knockback_direction = (global_position - attack.attack_position).normalized()
		parent.velocity = knockback_direction * attack.knockback_force
		parent.move_and_slide()

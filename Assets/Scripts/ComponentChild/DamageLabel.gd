extends Label
class_name DamageLabel

func show_damage(amount: float, position: Vector2):
	text = str("-" + str(amount))
	global_position = position
	visible = true

	# Animate the text
	var tween = get_tree().create_tween()
	modulate = Color(1, 1, 1, 1)  # Reset opacity
	tween.tween_property(self, "position", position + Vector2(0, -20), 0.5)
	tween.tween_property(self, "modulate:a", 0, 0.5)

	await tween.finished
	queue_free()  # Delete after animation

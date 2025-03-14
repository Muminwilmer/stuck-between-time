extends Node2D
class_name DamagePopupComponent

@export var damage_label_scene: PackedScene  # Assign the `DamageLabel.tscn` scene in the editor

func _ready():
	var parent_health_component = get_parent().get_node_or_null("HealthComponent")
	if parent_health_component:
		parent_health_component.damage_taken.connect(show_damage)

func show_damage(amount: float, position: Vector2):
	if not damage_label_scene:
		print("Warning: No DamageLabel scene assigned!")
		return

	var new_label = damage_label_scene.instantiate()  # Create a new label instance
	get_tree().current_scene.add_child(new_label)  # Add it to the scene
	new_label.show_damage(amount, position)  # Display the damage

extends State
class_name PlayerDash

@export var player: CharacterBody2D
@export var dash_speed: float = 600.0
@export var dash_duration: float = 0.18

var dash_timer = 0.0

func enter():
	dash_timer = 0.0
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("jump", "duck")
	player.velocity = compute_dash_velocity(direction_x, direction_y)
	player.is_dashing = true

func physics_update(delta):
	dash_timer += delta

	if dash_timer >= dash_duration:
		player.is_dashing = false
		player.velocity.x = move_toward(player.velocity.x, 0, dash_speed * delta)
		if player.is_on_floor():
			emit_signal("Transitioned", self, "walk")
	elif player.velocity != Vector2(0,0):
		create_dash_trail()

func compute_dash_velocity(direction_x: float, direction_y: float) -> Vector2:
	if player.is_on_floor():
		return Vector2(direction_x * dash_speed, 0)
	else:
		if direction_x == 0:
			direction_x = sign(player.velocity.x)

		return Vector2(direction_x * dash_speed, direction_y * dash_speed*.5)

func create_dash_trail():
	var sprite = player.get_node("Sprite2D")
	var ghost = Sprite2D.new()
	ghost.texture = sprite.texture
	ghost.hframes = sprite.hframes
	ghost.vframes = sprite.vframes
	ghost.frame = sprite.frame
	ghost.scale = sprite.scale
	ghost.global_position = sprite.global_position
	ghost.modulate = Color(1, 1, 1, 0.2)
	player.add_sibling(ghost)

	var tween = get_tree().create_tween()
	tween.tween_property(ghost, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.tween_callback(ghost.queue_free)

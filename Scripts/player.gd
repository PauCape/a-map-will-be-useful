extends CharacterBody2D

const SPEED = 300.0

@onready var vision_light: PointLight2D = $PointLight2D


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	var mouse_direction := get_global_mouse_position() - global_position

	vision_light.rotation = mouse_direction.angle() + PI*3/2

	move_and_slide()

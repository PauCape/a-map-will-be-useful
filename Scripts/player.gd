extends CharacterBody2D

const SPEED = 300.0

@onready var vision_light: PointLight2D = $PointLight2D

var facing_direction := Vector2.RIGHT


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	if direction:
		velocity = direction * SPEED
		facing_direction = direction

		# Dirección del cono corregida
		vision_light.rotation = facing_direction.angle() - PI*1/2
	else:
		velocity = Vector2.ZERO

	move_and_slide()

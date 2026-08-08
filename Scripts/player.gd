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
		
		# Apunta la luz en la dirección del movimiento
		vision_light.rotation = facing_direction.angle()
	else:
		velocity = Vector2.ZERO

	move_and_slide()

extends Polygon2D

@export var vision_distance: float = 250.0
@export var vision_angle: float = 90.0
@export var ray_count: int = 60

@export var wall_collision_mask: int = 2

func _ready() -> void:
	color = Color(1.0, 0.9, 0.2, 0.25)


func update_vision(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return

	var points := PackedVector2Array()
	points.append(Vector2.ZERO)

	var half_angle := deg_to_rad(vision_angle / 2.0)
	var center_angle := direction.angle()

	var space_state := get_world_2d().direct_space_state

	for i in range(ray_count + 1):
		var t := float(i) / float(ray_count)

		var angle := center_angle - half_angle + (half_angle * 2.0 * t)

		var ray_direction := Vector2.RIGHT.rotated(angle)
		var ray_end := global_position + ray_direction * vision_distance

		var query := PhysicsRayQueryParameters2D.create(
			global_position,
			ray_end
		)

		query.collision_mask = wall_collision_mask

		var result := space_state.intersect_ray(query)

		var point: Vector2

		if result:
			point = to_local(result.position)
		else:
			point = to_local(ray_end)

		points.append(point)

	polygon = points

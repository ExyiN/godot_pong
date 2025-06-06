extends ColorRect

func _draw() -> void:
	var screen_size: Vector2 = get_viewport_rect().size
	var from: Vector2 = Vector2(screen_size.x / 2, 0.0)
	var to: Vector2 = Vector2(screen_size.x / 2, screen_size.y)
	draw_dashed_line(from, to, Color.WHITE, 8.0, 16.0)

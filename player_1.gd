extends CharacterBody2D

@export var speed := 400
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	velocity = velocity * speed
	move_and_collide(velocity * delta)
	position = position.clamp(Vector2.ZERO, screen_size)
	

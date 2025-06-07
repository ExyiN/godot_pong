class_name Ball
extends RigidBody2D

@export var speed: float = DEFAULT_SPEED
@export var bounce_acceleration_multiplier: float = 1.05

@onready var screen_size: Vector2 = get_viewport_rect().size
@onready var bounce_sound: AudioStreamPlayer2D = $BounceSound

const DEFAULT_SPEED: float = 300.0

var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	var collision_data := move_and_collide(velocity * speed * delta)
	if collision_data:
		velocity = velocity.bounce(collision_data.get_normal())
		play_bounce_sound()

func launch() -> void:
	velocity = Vector2(randf_range(-1.0, 1.0), 0.0).normalized()
	velocity.y = randf_range(-0.5, 0.5)

func bounce_on_paddle(paddle_pos_y: float, paddle_height: float) -> void:
	var new_move_dir: float = (global_position.y - paddle_pos_y) / (paddle_height / 2)
	velocity = Vector2(-velocity.x, new_move_dir)
	speed *= bounce_acceleration_multiplier
	play_bounce_sound()
	
func reset() -> void:
	global_position = screen_size / 2
	speed = DEFAULT_SPEED
	velocity = Vector2.ZERO

func play_bounce_sound() -> void:
	bounce_sound.pitch_scale = randf_range(0.5, 1.5)
	bounce_sound.play()

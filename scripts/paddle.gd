class_name Paddle
extends Area2D

@export var acceleration: float = 40.0
@export var decelaration: float = 2.0
@export var is_player_two: bool = false
@export var is_ai: bool = false

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var screen_size: Vector2 = get_viewport_rect().size

const MAX_SPEED: float = 200.0

var input_up: String = "move_up"
var input_down: String = "move_down"
var velocity: float = 0.0

func _ready() -> void:
	if is_player_two:
		input_up += "_2"
		input_down += "_2"

func _physics_process(delta: float) -> void:
	var input_dir: float = 0.0
	if !is_ai:
		input_dir = Input.get_axis(input_up, input_down)
	else:
		input_dir = get_ai_dir()
	
	velocity += input_dir * acceleration * delta
	velocity = clampf(velocity, -MAX_SPEED, MAX_SPEED)
	
	if input_dir == 0:
		velocity = move_toward(velocity, 0.0, decelaration)
		
	global_position.y += velocity
	global_position.y = clampf(global_position.y, 0.0, screen_size.y)

func get_ai_dir() -> float:
	var ball: Ball = get_tree().get_first_node_in_group("balls")
	var accuracy: float = 20.0
	if global_position.y > ball.global_position.y + accuracy:
		return -1.0
	elif global_position.y < ball.global_position.y - accuracy:
		return 1.0
	return 0.0

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		body.bounce_on_paddle(global_position.y, collision_shape.shape.get_rect().size.y)
		
func reset() -> void:
	global_position.y = screen_size.y / 2

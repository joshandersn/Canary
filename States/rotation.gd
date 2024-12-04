extends Node
# Allows the rotation of the object with the users input

@export var rotation_speed := 0.6

var input_direction: Vector2
var rotation_velocity: Vector2
var object_type
@onready var parent = get_parent()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			input_direction = event.relative

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !(Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		input_direction.y = Input.get_axis("camera_forward", "camera_backward")
		input_direction.x = Input.get_axis("camera_left", "camera_right")
		
	rotation_velocity = lerp(rotation_velocity, input_direction * rotation_speed, delta * 30)
	
	if parent is RigidBody3D:
		parent.angular_velocity.x = input_direction.x
		parent.angular_velocity.y = input_direction.y
	elif parent is Node3D:
		parent.rotation.x += deg_to_rad(-rotation_velocity.y)
		parent.rotate_y(deg_to_rad(-rotation_velocity.x))

	parent.rotation.x = clamp(parent.rotation.x, deg_to_rad(-35), deg_to_rad(45))
	input_direction = Vector2.ZERO

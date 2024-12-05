extends Node
# Allows the object to me controlled by the movement keys

@export var enabled := true
@export var movement_speed := 10
@export var follow_rotation := true
@onready var parent = get_parent()
var input_direction: Vector3

func _input(event: InputEvent) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !(parent is RigidBody3D):
		print("parent is incompatible. Disabling this state")
		enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if enabled:
		if parent.camera_node:
			input_direction.x = Input.get_axis("move_left", "move_right")
			input_direction.z = Input.get_axis("move_forward", "move_backward")
			if input_direction.length():
				var v_rot = parent.camera_node.global_transform.basis.get_euler().y
				var camera_dir = input_direction.rotated(Vector3.UP, v_rot)
				parent.apply_force(camera_dir * movement_speed)
				var velocity = parent.linear_velocity.normalized()
				if velocity.length() > 0.9:
					parent.global_rotation.y = lerp_angle(parent.rotation.y, atan2(-velocity.z, velocity.x), delta * 30) 
		else:
			input_direction.x = Input.get_axis("move_backward", "move_forward")
			input_direction.z = Input.get_axis("move_left","move_right")
			parent.apply_force(input_direction * movement_speed)

extends Node

@export var enabled := true
@export var jump_direction := Vector3(0,500,0)
@export var jump_ray_length = 0.5

@onready var parent = get_parent()
@onready var new_ray = RayCast3D.new()

func _ready() -> void:
	new_ray.target_position.y = -jump_ray_length
	new_ray.set_collision_mask_value(3, true)
	add_sibling.call_deferred(new_ray)

func _input(event: InputEvent) -> void:
	if enabled:
		if Input.is_action_just_pressed("jump") and new_ray.is_colliding():
			parent.apply_force(jump_direction)

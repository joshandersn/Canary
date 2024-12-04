extends Node3D

@export var current = false
@export var target = Node3D
@onready var camera = $Neck/Camera
@onready var neck = $Neck
@export var follow_speed = 5.5
@export var neck_length = 5
@export var fov = 50

func update_variables():
	camera.current = current
	neck.spring_length = neck_length
	camera.fov = fov
	if "camera_node" in target:
		target.camera_node = self

func _ready() -> void:
	update_variables()

func _physics_process(delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position, delta * follow_speed)

extends CharacterBody3D;

@export var speed = 5.0;
@export var jump_velocity = 4.5;
@export var min_look_angle = -45;
@export var max_look_angle = 75;

var look_sensitivity = Globals.setting_values.look_sensitivity;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var _neck = $Neck;
@onready var _camera = $Neck/Camera3D;


func _unhandled_input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			_neck.rotate_y(-event.relative.x * 0.01 * look_sensitivity);
			_camera.rotate_x(-event.relative.y * 0.01 * look_sensitivity);
			_camera.rotation.x = clamp(
				_camera.rotation.x, 
				deg_to_rad(min_look_angle), 
				deg_to_rad(max_look_angle)
			);


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector(
		"movement_left", 
		"movement_right", 
		"movement_forward", 
		"movement_backward"
	)
	var direction = (_neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

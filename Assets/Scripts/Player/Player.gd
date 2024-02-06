extends Node;

@onready var _basic_movement: CharacterBody3D = $CharacterBody3D;
@onready var _camera: Camera3D = $CharacterBody3D/Neck/Camera3D;
@onready var _pause_menu = get_node('../PauseMenu');


func _ready():
	_pause_menu.settings_updated.connect(self._update_player_variables_from_Globals);
	## Capture the mouse initially.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


func _unhandled_input(event):
	# We want to capture the mouse if the player has clicked inside the game window.
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	# We want to release the mouse and open the pause menu if the player has pressed escape.
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		_pause_menu.show_menu();


## Updates any player variables from the global values.
func _update_player_variables_from_Globals():
	_camera.fov = Globals.setting_values.fov;
	_basic_movement.look_sensitivity = Globals.setting_values.look_sensitivity;

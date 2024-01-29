extends Control;

## This script handles all internal logic for the settings menu.

@onready var _resolution_options_btn: OptionButton = $VBoxContainer/Settings/MarginContainer/VBoxContainer/VideoSettings/VBoxContainer/Resolution/ResolutionOptions;
@onready var _window_mode_options_btn: OptionButton = $VBoxContainer/Settings/MarginContainer/VBoxContainer/VideoSettings/VBoxContainer/WindowMode/WindowModeOptions;
@onready var _anti_aliasing_options_btn: OptionButton = $VBoxContainer/Settings/MarginContainer/VBoxContainer/VideoSettings/VBoxContainer/AntiAliasing/AntiAliasingOptions;
@onready var _render_scale_slider: Slider = $VBoxContainer/Settings/MarginContainer/VBoxContainer/VideoSettings/VBoxContainer/RenderScale/HBoxContainer/RenderScaleSlider;
@onready var _look_sensitivity_slider: Slider = $VBoxContainer/Settings/MarginContainer/VBoxContainer/ControlSettings/VBoxContainer2/LookSensitivity/LookSensitivitySlider;
@onready var _master_volume_slider: Slider = $VBoxContainer/Settings/MarginContainer/VBoxContainer/ControlSettings/VBoxContainer2/MasterVolume/MasterVolumeSlider;
@onready var apply_btn: Button = $VBoxContainer/CancelAndApply/HBoxContainer/Apply;
@onready var cancel_btn: Button = $VBoxContainer/CancelAndApply/HBoxContainer/Cancel;


func _ready():
	_add_resolution_options();
	_add_window_mode_options();
	_add_anti_aliasing_options();
	_setup_signals();
	Globals.setting_values = get_settings_data();


## Returns the currently selected setting values in a SettingsData object.
func get_settings_data() -> SettingsData:
	var selected_resolution: Vector2 = Globals.SUPPORTED_RESOLUTIONS[
		OptionButtonExtensions.get_selected_item_text(_resolution_options_btn)
	];
	var selected_window_mode: int = Globals.WINDOW_MODES[
		OptionButtonExtensions.get_selected_item_text(_window_mode_options_btn)
	];
	var selected_anti_aliasing: int = Globals.ANTI_ALIASING_OPTIONS[
		OptionButtonExtensions.get_selected_item_text(_anti_aliasing_options_btn)
	];
	return SettingsData.new(
		selected_resolution,
		selected_window_mode,
		selected_anti_aliasing,
		_render_scale_slider.value,
		_look_sensitivity_slider.value,
		_master_volume_slider.value,
	);


## Sets the field values to those in the given SettingsData object.
func set_field_values(settings_data: SettingsData) -> void:
	var resolution_index = OptionButtonExtensions.get_index_of_item_text(
		_resolution_options_btn,
		_get_resolution_as_string(settings_data.selected_resolution),
	);
	_resolution_options_btn.select(resolution_index);
	_window_mode_options_btn.select(settings_data.selected_window_mode);
	_anti_aliasing_options_btn.select(settings_data.selected_anti_aliasing);
	_render_scale_slider.value = settings_data.render_scale;
	_look_sensitivity_slider.value = settings_data.look_sensitivity;
	_master_volume_slider.value = settings_data.master_volume;


## Updates the resolution OptionBtn's disabled property from the newly selected winow mode.
func _update_resolution_options_btn_disabled(new_selected_index: int) -> void:
	var new_window_mode: int = Globals.WINDOW_MODES[
		_window_mode_options_btn.get_item_text(new_selected_index)
	];
	# 3 is the integer value of Mode.MODE_FULLSCREEN
	_resolution_options_btn.disabled = new_window_mode == 3;


## Sets up all signals for the main menu.
func _setup_signals() -> void:
	cancel_btn.pressed.connect(self._reset_all_field_values);
	apply_btn.pressed.connect(self._apply_new_settings);
	_window_mode_options_btn.item_selected.connect(self._update_resolution_options_btn_disabled);


## Updates the global setting values with the current field values.
## Also updates the screen resolution and window mode.
func _apply_new_settings():
	var new_settings: SettingsData = get_settings_data();
	Globals.setting_values = new_settings;
	# In case the user has switched to windowed from fullscreen. We want the resolution 
	# to be updated after the game is set to windowed, otherwise the resolution won't update.
	DisplayServer.window_set_mode(new_settings.selected_window_mode);
	DisplayServer.window_set_size(new_settings.selected_resolution);


## Resets all field values to the values stored in Globals.
func _reset_all_field_values() -> void:
	set_field_values(Globals.setting_values);


## Adds all window mode options from Globals to the windowModeOptionsBtn.
func _add_window_mode_options() -> void:
	for option in Globals.WINDOW_MODES:
		_window_mode_options_btn.add_item(option);


## Adds all anti aliasing options from Globals to the antiAliasingOptionsBtn.
func _add_anti_aliasing_options() -> void:
	for option in Globals.ANTI_ALIASING_OPTIONS:
		_anti_aliasing_options_btn.add_item(option);


## Adds all resolution options from Globals to the resolutionOptionsBtn.
func _add_resolution_options() -> void:
	var max_display_size = DisplayServer.screen_get_size();
	var resolution_options: Dictionary = Globals.SUPPORTED_RESOLUTIONS;
	for option in resolution_options:
		if (resolution_options[option] <= max_display_size):
			_resolution_options_btn.add_item(option);

	var window_size = DisplayServer.window_get_size();
	var window_size_string = _get_resolution_as_string(window_size);
	# Set the current resolution to be the selected one in the options button.
	var window_size_index = OptionButtonExtensions.get_index_of_item_text(
		_resolution_options_btn, 
		window_size_string
	);
	_resolution_options_btn.select(window_size_index);


## Convert the given resolution to a string.
func _get_resolution_as_string(resolution: Vector2i) -> String:
	return "%s x %s" % [resolution.x, resolution.y];

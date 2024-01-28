class_name SettingsData;

var selected_resolution: Vector2;
var selected_window_mode: int;
var look_sensitivity: float;
var master_volume: float;

func _init(
    selected_resolution_value: Vector2,
    selected_window_mode_value: int,
    look_sensitivity_value: float,
    master_volume_value: float,
):
    selected_resolution = selected_resolution_value;
    selected_window_mode = selected_window_mode_value;
    look_sensitivity = look_sensitivity_value;
    master_volume = master_volume_value;
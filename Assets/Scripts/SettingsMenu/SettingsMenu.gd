extends Control;

@onready var resolutionOptionsBtn: OptionButton = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ResolutionOptions;
@onready var windowModeOptionsBtn: OptionButton = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/WindowModeOptions;

func _ready():
	addResolutions();
	addWindowModes();

## Adds all resolution options from GlobalConstants to the resolutionOptionsBtn.
func addResolutions():
	var maxDisplaySize = DisplayServer.screen_get_size()
	var resolutionOptions: Dictionary = GlobalConstants.RESOLUTIONS;
	for option in resolutionOptions:
		# Don't add the resolution option if it's too large for the user's display.
		if (resolutionOptions[option] <= maxDisplaySize):
			resolutionOptionsBtn.add_item(option);

## Adds all window mode options from GlobalConstants to the windowModeOptionsBtn.
func addWindowModes():
	for r in GlobalConstants.WINDOW_MODES:
		windowModeOptionsBtn.add_item(r);

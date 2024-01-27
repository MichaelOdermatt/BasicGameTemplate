extends Node

const RESOLUTIONS: Dictionary = {
	'3840 x 2160' : Vector2i(3840, 2160),
	'2560 x 1440' : Vector2i(2560, 1440),
	'1920 x 1080' : Vector2i(1920, 1080),
	'1366 x 768' : Vector2i(1366, 768),
	'1536 x 864' : Vector2i(1536, 864),
	'1280 x 720' : Vector2i(1280, 720),
	'1440 x 900' : Vector2i(1440, 900),
	'1600 x 900' : Vector2i(1600, 900),
	'1024 x 600' : Vector2i(1024, 600),
	'800 x 600' : Vector2i(800, 600),
}

const WINDOW_MODES: Dictionary = {
	'Windowed' : 0,
	'Fullscreen' : 1,
}
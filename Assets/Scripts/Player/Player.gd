extends Node;

func _unhandled_input(event):
    # We want to capture the mouse if the player has clicked inside the game window.
    if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
    # We want to release the mouse if the player has clicked escape.
    elif event.is_action_pressed("ui_cancel"):
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
extends VBoxContainer

onready var FullscreenCheck = find_node("FullscreenCheck")

func _ready() -> void:
	FullscreenCheck.pressed = Settings.settings.fullscreen_enabled

func _on_FullscreenCheck_toggled(button_pressed: bool) -> void:
	Settings.settings.fullscreen_enabled = button_pressed

func _on_Label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.pressed and event.button_index == BUTTON_LEFT:
			FullscreenCheck.pressed = not FullscreenCheck.pressed
			FullscreenCheck.grab_focus()

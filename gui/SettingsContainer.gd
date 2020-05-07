extends PanelContainer

onready var SaveButton = find_node("SaveButton")

func _enter_tree() -> void:
	Settings.load_settings()

func _ready() -> void:
	pass

func _on_SaveButton_pressed() -> void:
	Settings.save_settings()
	visible = false

func _on_CancelButton_pressed() -> void:
	Settings.load_settings()
	visible = false

func _on_SettingsContainer_visibility_changed() -> void:
	if visible:
		SaveButton.grab_focus()
	else:
		Settings.emit_signal("settings_closed")

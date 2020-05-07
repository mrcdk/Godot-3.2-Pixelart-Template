extends CanvasLayer

const SETTINGS_SAVE_PATH = "user://settings.tres"

signal settings_closed()

onready var SettingsContainer = find_node("SettingsContainer")

var settings:SettingsData = SettingsData.new()

func _ready() -> void:
	hide()
	load_settings()
	
func show():
	SettingsContainer.show()
	
func hide():
	SettingsContainer.hide()
		
func load_settings():
	settings = null
	if ResourceLoader.exists(SETTINGS_SAVE_PATH):
		settings = ResourceLoader.load(SETTINGS_SAVE_PATH)
	else:
		save_settings()
		
	settings.apply()
		
func save_settings():
	if ResourceSaver.save(SETTINGS_SAVE_PATH, settings) == OK:
		print("Settings saved!")
	else:
		print("Settings couldn't be saved :(")

func cancel_changes():
	load_settings()

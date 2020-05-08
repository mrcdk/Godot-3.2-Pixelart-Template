extends PanelContainer

onready var GameLogoTexture = find_node("GameLogoTexture")
onready var NewGameButton = find_node("NewGameButton")
onready var LoadGameButton = find_node("LoadGameButton")
onready var SettingsButton = find_node("SettingsButton")

func _ready() -> void:
	if not OS.get_name() == "HTML5":
		NewGameButton.grab_focus()
	
	Events.connect("html5_click_grabber_clicked", self, "_on_click_grabber_clicked")
	Settings.connect("settings_closed", self, "_on_settings_closed")

func _on_settings_closed() -> void:
	SettingsButton.grab_focus()
	
func _on_click_grabber_clicked() -> void:
	NewGameButton.grab_focus()

func _on_NewGameButton_pressed() -> void:
	Transitions.change_scene("res://TestScene.tscn")

func _on_LoadGameButton_pressed() -> void:
	print("Load game")

func _on_SettingsButton_pressed() -> void:
	Settings.show()

func _on_QuitGameButton_pressed() -> void:
	get_tree().quit()

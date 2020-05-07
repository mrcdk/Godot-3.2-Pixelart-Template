extends HBoxContainer

signal value_changed(new_value)

export (String, "Master,Music,SFX") var bus = "Master"

onready var MinusButton = find_node("MinusButton")
onready var VolumeSlider = find_node("VolumeSlider")
onready var PlusButton = find_node("PlusButton")

func _ready() -> void:
	VolumeSlider.value = Settings.settings.audio_volumes.get(bus, 1.0)

func _on_MinusButton_pressed() -> void:
	VolumeSlider.value -= VolumeSlider.step

func _on_PlusButton_pressed() -> void:
	VolumeSlider.value += VolumeSlider.step

func _on_VolumeSlider_value_changed(_value: float) -> void:
	Settings.settings.set_volume(bus, VolumeSlider.value)
	emit_signal("value_changed", VolumeSlider.value)
